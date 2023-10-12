import tiktoken


def count_tokens_in_file(file_path):
    with open(file_path, "r") as f:
        text = f.read()
    return count_tokens_in_text(text)


def count_tokens_in_text(text, model="gpt-4"):
    encoding = tiktoken.encoding_for_model(model)
    tokens = encoding.encode(text)
    return len(tokens)
