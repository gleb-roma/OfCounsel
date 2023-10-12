
from ragas import evaluate
from datasets import Dataset
import os

# os.environ["OPENAI_API_KEY"] = "your-openai-key"

print(os.environ["OPENAI_API_KEY"])

# prepare your huggingface dataset in the format
# Dataset({
#     features: ['question', 'contexts', 'answer'],
#     num_rows: 25
# })

# data
from datasets import load_dataset

fiqa_eval = load_dataset("explodinggradients/fiqa", "ragas_eval")
# print(fiqa_eval)


result = evaluate(
    fiqa_eval["baseline"],
    metrics=[
        context_precision,
        faithfulness,
        answer_relevancy,
        context_recall,
        # harmfulness,
    ],
)

print(result)