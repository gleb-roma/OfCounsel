from langchain.schema import (
    AIMessage,
    HumanMessage,
    SystemMessage
)
from langchain.chat_models import ChatOpenAI
from langchain.chains import ConversationChain

from langchain.chains import ConversationChain

chat = ChatOpenAI()

conversation = ConversationChain(llm=chat)
print(conversation.run("Translate this sentence from English to French: I love programming."))


print(conversation.run("Translate it to German."))

