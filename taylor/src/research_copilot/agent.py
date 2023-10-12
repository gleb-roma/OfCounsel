import time
from langchain.llms import OpenAI
from langchain.agents import initialize_agent, Tool
from langchain.agents import AgentType
from langchain.agents.react.base import DocstoreExplorer
from langchain.chat_models import ChatOpenAI
from langchain.memory import ConversationBufferMemory
from langchain.chat_models import ChatOpenAI
from langchain.chains.combine_documents.stuff import StuffDocumentsChain
from langchain.prompts import PromptTemplate
from langchain.chains import create_qa_with_sources_chain
from langchain.chains import RetrievalQA
from langchain.schema.retriever import BaseRetriever
from langchain.schema.document import Document
from typing import TYPE_CHECKING, Any, Dict, List, Optional
from langchain.callbacks.manager import CallbackManagerForRetrieverRun
from langchain.schema import AIMessage, HumanMessage, SystemMessage
from research_copilot import agent_prompts
from research_copilot.db.privacy_policy import (
    create_hypothetical_requirements_nodes_for_privacy_policy_section,
    get_all_privacy_policy_sections,
    hypothetical_requirement_similarity_search,
)
from sentence_transformers import SentenceTransformer


import requests

import logging

from research_copilot.data_loading.ca_code import (
    do_rag,
    get_all_codepiece_node_paths,
    get_unfulfilled_codepiece_requirements,
    mark_fulfilled_by,
    mark_not_fulfilled_by,
    update_codepiece_node_properties,
)

logger = logging.getLogger(__name__)


from langchain.schema.retriever import BaseRetriever
from langchain.schema.document import Document
from typing import TYPE_CHECKING, Any, Dict, List, Optional
from langchain.callbacks.manager import CallbackManagerForRetrieverRun
from pydantic import BaseModel

import requests
import json


class BaseOfCounselRetriever(BaseRetriever):
    params: Dict[str, Any] = {}

    RAG_SERVER_URL = "https://ladybird-winning-shiner.ngrok-free.app"
    AUTH_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiaWF0IjoxNTE2MjM5MDIyfQ.TzOHUu0Xi4oMx6F1SBGYwqqH_a2i9x7NJcD0mA-ucR0"

    def _call_search_endpoint(self, url, query, limit=5, ccpa_only=True):
        headers = {"Authorization": f"Bearer {self.AUTH_TOKEN}"}
        response = requests.get(
            url,
            params={
                "query": query,
                "limit": limit,
                "ccpa_only": ccpa_only,
                "params": json.dumps(self.params),
            },
            headers=headers,
        )
        if response.status_code == 200:
            results = response.json()
            return results
        else:
            raise Exception(
                f"Error {response.status_code} calling {url}: {response.text}"
            )

    def _results_to_docs(self, results):
        result_docs = []
        for r in results:
            if r["node"]["text"]:
                result_docs.append(
                    Document(
                        page_content=r["node"]["text"] or "",
                        metadata={**r["node"], "source": r["node"]["id"]},
                    )
                )
        return result_docs


class SimilarityOfCounselRetriever(BaseOfCounselRetriever):
    def _sim_search(self, query, limit=10, ccpa_only=True):
        """
        query: a string
        limit: number of results to return
        ccpa_only: only return results that are part of the CCPA - if False, will return all results from statutes in the database (currently all of CIV)
        """
        url = f"{self.RAG_SERVER_URL}/rag/sim_search/"
        return self._call_search_endpoint(url, query, limit, ccpa_only)

    def _get_relevant_documents(
        self, query: str, *, run_manager: CallbackManagerForRetrieverRun
    ) -> List[Document]:
        """
        _get_relevant_documents is function of BaseRetriever implemented here

        :param query: String value of the query

        """
        results = self._sim_search(query)
        return self._results_to_docs(results)


class PlainTextOfCounselRetriever(BaseOfCounselRetriever):
    def _text_search(self, query, limit=5, ccpa_only=True):
        url = f"{self.RAG_SERVER_URL}/rag/text_search/"
        return self._call_search_endpoint(url, query, limit, ccpa_only)

    def _get_relevant_documents(
        self, query: str, *, run_manager: CallbackManagerForRetrieverRun
    ) -> List[Document]:
        """
        _get_relevant_documents is function of BaseRetriever implemented here

        :param query: String value of the query

        """
        results = self._text_search(query)
        return self._results_to_docs(results)


class OfCounselRetriever(BaseOfCounselRetriever):
    local_rag_embedding_model: SentenceTransformer | None = None

    def __init__(self, local_rag_embedding_model=None, **kwargs):
        super().__init__()
        self.params = kwargs or {}
        self.local_rag_embedding_model = local_rag_embedding_model

    def _local_rag_search(self, query):
        if not self.local_rag_embedding_model:
            raise Exception(
                "local_rag_embedding_model must be set to use _local_rag_search"
            )
        return do_rag(self.local_rag_embedding_model, query, self.params)

    def _get_relevant_documents(
        self, query: str, *, run_manager: CallbackManagerForRetrieverRun
    ) -> List[Document]:
        """
        _get_relevant_documents is function of BaseRetriever implemented here

        :param query: String value of the query

        """
        results = []
        if self.local_rag_embedding_model:
            results = self._local_rag_search(query)
        else:
            url = f"{self.RAG_SERVER_URL}/rag/"
            results = self._call_search_endpoint(url, query)
        if self.params.get("mode") == "path_similarity":
            if self.params.get("flatten_path"):
                # returns all nodes from path (root to leaf) as individual documents
                result_docs = []
                for r in results:
                    for n in r["path_nodes"]:
                        result_docs.append(
                            Document(
                                page_content=n["text"],
                                metadata={**n, "source": n["id"]},
                            )
                        )
                return result_docs
            else:
                # combines text from all nodes in path into one document
                result_docs = []
                for r in results:
                    result_docs.append(
                        Document(
                            page_content=r["node"]["path_text"],
                            metadata={**r["node"], "source": r["node"]["id"]},
                        )
                    )
                return result_docs
        else:
            return self._results_to_docs(results)


def simple_retrieval_qa_chain(
    model_name="gpt-4", temperature=0.2, local_rag_embedding_model=None, **_
):
    chat = ChatOpenAI(model_name=model_name, temperature=temperature)

    qa_chain = create_qa_with_sources_chain(chat)

    doc_prompt = PromptTemplate(
        template="Content: {page_content}\nSource: {source}",
        input_variables=["page_content", "source"],
    )

    final_qa_chain = StuffDocumentsChain(
        llm_chain=qa_chain,
        document_variable_name="context",
        document_prompt=doc_prompt,
    )

    retrieval_qa = RetrievalQA(
        retriever=OfCounselRetriever(
            mode="path_similarity", local_rag_embedding_model=local_rag_embedding_model
        ),
        combine_documents_chain=final_qa_chain,
    )
    logger.info("Created retrieval_qa")
    return retrieval_qa


def get_react_docstore_agent():
    def search(query):
        return f"No results for {query}"

    def lookup(term):
        return f"No results for {term}"

    # tools = [
    #     Tool(
    #         name="Search",
    #         func=search,
    #         description="useful for when you need to ask with search",
    #     ),
    #     Tool(
    #         name="Lookup",
    #         func=lookup,
    #         description="useful for when you need to ask with lookup",
    #     ),
    # ]
    tools = []

    llm = OpenAI(temperature=0.5)
    # llm = ChatOpenAI(temperature=0, model="gpt-3.5-turbo", max_tokens=1000)
    # return initialize_agent(tools, llm, agent=AgentType.REACT_DOCSTORE, verbose=True)
    memory = ConversationBufferMemory(memory_key="chat_history")
    return initialize_agent(
        tools,
        llm,
        agent=AgentType.CONVERSATIONAL_REACT_DESCRIPTION,
        verbose=True,
        memory=memory,
    )


### Let every eye negotiate for itself and trust no agent. - Shakespeare


class PrivacyPolicyRequirement(BaseModel):
    text: str
    fulfilled: bool = False
    node_id: str


class PrivacyPolicyAgent(BaseModel):
    class Config:
        arbitrary_types_allowed = True

    chat_model: ChatOpenAI = ChatOpenAI(temperature=0, model="gpt-4")
    embeddings_model: SentenceTransformer = SentenceTransformer("thenlper/gte-large")

    def llm(self, prompt):
        messages = [
            SystemMessage(
                content="You are a helpful legal assistant. You are helping a business owner update a privacy policy to comply with new regulations."
            ),
            HumanMessage(content=prompt),
        ]
        return self.chat_model(messages).content

    def run(self):
        logger.info("Running PrivacyPolicyAgent")
        # No input, assume we already have policy and legislation loaded in database

        # Scan legislation for new requirements for privacy policy
        self.scan_legislation()

        # Scan policy to see if it fulfills requirements
        self.scan_policy()

        # Suggest changes to policy to fulfill requirements
        self.suggest_changes()

        return

    def scan_legislation(self):
        logger.info("Scanning legislation for new requirements")
        # traverse all ccpa nodes
        codepiece_node_paths = (
            get_all_codepiece_node_paths()
        )  # TODO try aggregatating entire sections
        req_count = 0
        for r in codepiece_node_paths:
            leaf_node = r["path_nodes"][-1]
            leaf_id = r["path_nodes"][-1]["id"]
            parent_context = " | ".join(
                [n.get("text", "") for n in r["path_nodes"][:-1]]
            )
            update_props = {}
            if "is_requirement" not in leaf_node:
                # check if it's relevant for privacy policy
                is_req = self.llm(
                    agent_prompts.check_if_req.format(
                        parent_context=parent_context,
                        subsection_text=leaf_node["text"],
                    )
                )
                update_props["is_requirement"] = is_req != "NO"
            if update_props.get("is_requirement"):
                # summarize the requirement
                req_summary = self.llm(
                    agent_prompts.summarize_req.format(
                        parent_context=parent_context,
                        subsection_text=leaf_node["text"],
                    )
                )
                update_props["requirement_summary"] = req_summary
                # vectorize the requirement and store it in the database
                update_props["requirement_vector"] = self.embeddings_model.encode(
                    update_props["requirement_summary"]
                )
            if update_props:
                req_count += 1
                update_codepiece_node_properties(  # TODO optimize this into one big call at the end
                    node_id=leaf_id,
                    props=update_props,
                )
        logger.info(f"Found {req_count} requirements")

    def scan_policy(self):
        sections = get_all_privacy_policy_sections()
        for s in sections:
            if s.get("hypothetical_requirements"):
                continue
            # generate hypothetical requirements
            hypothetical_requirements = self.llm(
                agent_prompts.hypothetical_req.format(
                    policy_section_text=s["node"]["text"]
                )
            )
            hypothetical_requirements = json.loads(hypothetical_requirements)
            # embed the hypothetical requirements
            hypothetical_requirement_vectors = self.embeddings_model.encode(
                hypothetical_requirements
            )
            create_hypothetical_requirements_nodes_for_privacy_policy_section(
                section=s,
                hypothetical_requirements_vectors=list(
                    zip(hypothetical_requirements, hypothetical_requirement_vectors)
                ),
            )

    def check_for_fullfilled_requirements(self):
        requirements = get_unfulfilled_codepiece_requirements()
        for req in requirements:
            # find matching sections
            relevant_sections = hypothetical_requirement_similarity_search(
                req["node"]["requirement_vector"]
            )
            visited_node_ids = set()
            for rs in relevant_sections:
                if rs["node"]["id"] in visited_node_ids:
                    continue
                # if (
                #     rs["fulfilled_node"]["id"] == req["node"]["id"]
                #     or rs["unfulfilled_node"]["id"] == req["node"]["id"]
                # ):
                #     continue
                # check if it's fulfilled against actual law
                is_fulfilled = self.llm(
                    agent_prompts.check_req_fulfilled.format(
                        policy_section_text=rs["node"]["text"],
                        path_text=req["node"]["path_text"],
                    )
                )
                time.sleep(2)  # avoid rate limiting
                if is_fulfilled == "YES":
                    # mark requirement as fulfilled by this
                    mark_fulfilled_by(
                        req_id=req["node"]["id"],
                        section_id=rs["node"]["id"],
                    )
                else:
                    # mark requirement as not fulfilled by this
                    mark_not_fulfilled_by(
                        req_id=req["node"]["id"],
                        section_id=rs["node"]["id"],
                    )

    def suggest_changes(self):
        pass
