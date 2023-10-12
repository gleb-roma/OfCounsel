import os

from dotenv import load_dotenv

load_dotenv()

import openai

openai.api_key = os.environ["OPENAI_API_KEY"]


def get_chat_completion(send_prompt):
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[{"role": "user", "content": send_prompt}],
        max_tokens=200,
        temperature=0,
    )
    return response["choices"][0]["message"]["content"]


def classify_message_as_request(message):
    classification_prompt_template = f"""
    Determine whether the provided message text should be classified as a request for assistance. If it is, return TRUE. If it is not, return FALSE.

    Here are some examples of messages that should be classified as a request for assistance:
    Hey team, I'm having trouble with the inventory management system. I scanned in some new items, but they're not showing up in the system.
    Need help ASAP! The picking app is acting up again. It keeps crashing whenever I try to select a new order. Can someone from IT take a look at this?
    Urgent help needed with the forklift tracking system. It's not updating the locations in real-time, and I can't locate Forklift #27. Is there a workaround until this gets resolved?
    I'm having a data mismatch between the inventory database and the sales software. Our records show we have more stock of Product X than what's listed in the sales app.

    Here are some examples of messages that should NOT be classified as a request for assistance:
    Hey team, I'm going to be out sick today. I'll be back tomorrow.
    Good job on the new inventory management system! It's working great so far.
    Did anyone catch the game last night?

    Message: {message}
    Classified as a request for assistance:
    """

    classification_prompt = classification_prompt_template.format(message=message)

    result = get_chat_completion(classification_prompt)
    return result.lower() == "true"


actions = {
    "ask for more information",
    "say hello",
}
# "other" as fallback


def classify_action_required(message):
    classify_action_prompt_template = f"""
    You are a helpful legal assistant. You are reading a message from a client in a Slack channel. Determine whether the message requires action. If it does, return the appropriate action from the following list of actions. If the client wants you to do something that is not on the list, return "other".
    {str(list(actions))}

    Here are some examples:
    
    Message: Hello there!
    Action: say hello

    Message: I've received a complaint. What should I do?
    Action: ask for more information

    Message: Can you send me an email with the details?
    Action: other

    Now it's your turn. What action should you take?
    Message: {message}
    Action: """

    classify_action_prompt = classify_action_prompt_template.format(message=message)

    result = get_chat_completion(classify_action_prompt).lower()
    if result not in actions and result != "other":
        result = None
    return result