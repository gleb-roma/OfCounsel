# from sentence_transformers import SentenceTransformer

# OPENAI_EMBEDDING_MODELS = {"ada"}


# def embed_text(text, model=""):
#     if model in OPENAI_EMBEDDING_MODELS:
#         return embed_with_openai(text, model)
#     return embed_with_sentence_transformer(text, model)


# def embed_with_openai(text, model):
#     pass

# def embed_with_sentence_transformer(text, model):
#     embedding_model = SentenceTransformer(model)
#     return embedding_model.encode(text)
