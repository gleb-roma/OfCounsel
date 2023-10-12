import itertools
import json
from dotenv import load_dotenv
from fastapi.responses import HTMLResponse
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from research_copilot.db.courtlistener import get_search_opinion_by_id
from research_copilot.slackbot import app_state

load_dotenv()

from functools import partial
import requests
import os
import logging

from slack_bolt import App
from slack_bolt.adapter.fastapi import SlackRequestHandler
from slack_sdk.errors import SlackApiError

from research_copilot.llm import classify_action_required, actions
from research_copilot.agent import get_react_docstore_agent, simple_retrieval_qa_chain
from research_copilot.data_loading.ca_code import (
    codepiece_text_similarity_search,
    codepiece_fulltext_search,
    do_rag,
    get_path_nodes,
    retrieve_related_nodes,
)

logger = logging.getLogger(__name__)

app = App()
app_handler = SlackRequestHandler(app)

CLIENT_DATA_DIR = os.getenv("CLIENT_DATA_DIR", "/tmp")

# TODO restrict slack apis to slack ip ranges


def get_conversation_history(channel_id: str):
    conversation_history = []
    try:
        # Call the conversations.history method using the WebClient
        # conversations.history returns the first 100 messages by default
        # These results are paginated, see: https://api.slack.com/methods/conversations.history$pagination
        result = app.client.conversations_history(channel=channel_id)
        conversation_history = result["messages"]
        # Print results
        logger.info(
            "{} messages found in {}".format(len(conversation_history), channel_id)
        )
    except SlackApiError as e:
        logger.error("Error creating conversation: {}".format(e))
    return conversation_history


@app.event("app_mention")
def handle_app_mentions(event, say, logger):
    agent = get_react_docstore_agent()
    msg_text = event["text"]
    agent_response = agent.run(msg_text)

    thread_ts = event.get("thread_ts", event["ts"])
    say(text=agent_response, thread_ts=thread_ts)


def default_message_handler(event, say, logger):
    msg_text = event["text"]
    thread_ts = event.get("thread_ts", event["ts"])

    action_required = classify_action_required(msg_text)
    if not action_required:
        say(text="ERROR: Couldn't select the appropriate action", thread_ts=thread_ts)
        return
    if action_required == "other":
        say(
            text="I can't do that yet, but I'll ask a human to take a look.",
            thread_ts=thread_ts,
        )
        return
    say(text=f"Action required: {action_required}", thread_ts=thread_ts)


@app.event("file_shared")
def handle_file_shared_events(body, logger):
    # download all shared files
    file_id = body["event"]["file_id"]
    logger.info(f"Downloading file {file_id}...")
    resp = app.client.files_info(file=file_id)
    file = resp.get("file", {})
    url = file.get("url_private")
    if not url:
        logger.error(f"File {file_id} does not have a private URL.")
        return
    r = requests.get(url, headers={"Authorization": "Bearer %s" % app.client.token})
    with open(os.path.join(CLIENT_DATA_DIR, file["name"]), "wb") as f:
        f.write(r.content)
    logger.info(f"Downloaded file {file_id}.")


@app.event("message")
def handle_message(event, say, logger):
    pass


#     msg_text = event["text"].lower()
#     action_required = classify_action_required(msg_text)
#     thread_ts = event.get("thread_ts", None) or event["ts"]
#     if not action_required:
#         say(text="ERROR: Couldn't select the appropriate action", thread_ts=thread_ts)
#         return
#     if action_required == "other":
#         say(text="I can't do that yet, but I'll ask a human to take a look.", thread_ts=thread_ts)
#         return
#     say(text=f"Action required: {action_required}", thread_ts=thread_ts)


from fastapi import Depends, FastAPI, HTTPException, Query, Request

api = FastAPI()


@api.post("/slack/events")
async def endpoint(req: Request):
    return await app_handler.handle(req)


import jwt

JWT_SECRET = os.getenv("JWT_SECRET")
JWT_ALGORITHM = os.getenv("JWT_ALGORITHM")


def decodeJWT(token: str) -> dict:
    if not JWT_ALGORITHM or not JWT_SECRET:
        logging.error("JWT_SECRET or JWT_ALGORITHM is not set.")
        return {}
    try:
        return jwt.decode(token, JWT_SECRET, algorithms=[JWT_ALGORITHM])
        # return decoded_token if decoded_token["expires"] >= time.time() else None  #
    except:
        return {}


class JWTBearer(HTTPBearer):
    def __init__(self, auto_error: bool = True):
        super(JWTBearer, self).__init__(auto_error=auto_error)

    async def __call__(self, request: Request):
        credentials: HTTPAuthorizationCredentials | None = await super(
            JWTBearer, self
        ).__call__(request)
        if credentials:
            if not credentials.scheme == "Bearer":
                raise HTTPException(
                    status_code=403, detail="Invalid authentication scheme."
                )
            if not self.verify_jwt(credentials.credentials):
                raise HTTPException(
                    status_code=403, detail="Invalid token or expired token."
                )
            return credentials.credentials
        else:
            raise HTTPException(status_code=403, detail="Invalid authorization code.")

    def verify_jwt(self, jwtoken: str) -> bool:
        isTokenValid: bool = False
        try:
            payload = decodeJWT(jwtoken)
        except:
            payload = None
        if payload:
            isTokenValid = True
        return isTokenValid


SHARED_DEPS = [Depends(JWTBearer())]


# for viewing opinions:'
@api.get("/opinion/{opinion_id}", dependencies=SHARED_DEPS)
async def get_opinion(opinion_id: int):
    """
    Order of priority:
    - html_with_citations
    - html
    - html_lawbox
    - html_columbia
    - html_anon_2020
    - xml_harvard (convert to html)
    """
    opinion = get_search_opinion_by_id(opinion_id)
    if opinion is None:
        return HTMLResponse(content="Opinion not found", status_code=404)
    opinion_htmls = [
        opinion.html_with_citations,
        opinion.html,
        opinion.html_lawbox,
        opinion.html_columbia,
        opinion.html_anon_2020,
    ]
    for html_content in opinion_htmls:
        if html_content is not None and len(html_content) > 0:
            return HTMLResponse(content=html_content, status_code=200)
    if opinion.xml_harvard is not None and len(opinion.xml_harvard) > 0:
        #  TODO convert to html
        return HTMLResponse(content=opinion.xml_harvard, status_code=200)
    return HTMLResponse(content="Opinion not found", status_code=404)


@api.get("/opinion/{opinion_id}/{name}", dependencies=SHARED_DEPS)
async def get_opinion_extended(opinion_id: int, name: str):
    return await get_opinion(opinion_id)


def parse_params(params: str):
    try:
        return json.loads(params)
    except json.JSONDecodeError:
        raise HTTPException(status_code=442, detail="Invalid JSON format for params")


# for RAG:
@api.get("/rag/sim_search/", dependencies=SHARED_DEPS)
async def sim_search(
    query: str, limit: int = 5, ccpa_only: bool = True, params: str = Query(str({}))
):
    params_dict = parse_params(params)

    results = codepiece_text_similarity_search(
        text=query,
        embedding_model=app_state.embedding_model,
        embedding_name="gte-large",
        ccpa_only=ccpa_only,
        limit=limit,
    )
    if params_dict.get("related_limit"):
        for r in results:
            n = r["node"]
            r["related_nodes"] = retrieve_related_nodes(
                n, params_dict.get("related_limit")
            )
    return results


@api.get("/rag/text_search/", dependencies=SHARED_DEPS)
async def text_search(
    query: str, limit: int = 5, ccpa_only: bool = True, params: str = Query(str({}))
):
    params_dict = parse_params(params)

    results = codepiece_fulltext_search(
        text=query,
        ccpa_only=ccpa_only,
        limit=limit,
    )

    if params_dict.get("related_limit"):
        for r in results:
            n = r["node"]
            r["related_nodes"] = retrieve_related_nodes(
                n, params_dict.get("related_limit")
            )
    return results


@api.get("/rag/", dependencies=SHARED_DEPS)
async def rag(query: str, params: str = Query(str({}))):
    params_dict = parse_params(params)
    return do_rag(app_state.embedding_model, query, params_dict)


agent_funcs = {
    "simple_retrieval_qa_chain": partial(
        simple_retrieval_qa_chain, local_rag_embedding_model=app_state.embedding_model
    ),
}


@api.get("/chat/", dependencies=SHARED_DEPS)
async def chat(query: str, params: str = Query(str({}))):
    params_dict = parse_params(params)
    return do_chat(query, params_dict)


def do_chat(query: str, params_dict: dict):
    agent_name = params_dict.get("agent", "simple_retrieval_qa_chain")
    if agent_name not in agent_funcs:
        raise HTTPException(status_code=442, detail="Invalid agent name")
    if agent_name not in app_state.agents:
        app_state.agents[agent_name] = agent_funcs[agent_name](**params_dict)
    agent = app_state.agents[agent_name]
    return agent.run(query)


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(api, host="0.0.0.0", port=3006)

# Taylor's slack user id: U05PQ4GG59C
