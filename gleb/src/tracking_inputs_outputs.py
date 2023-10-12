import csv
import os
import pandas as pd


class DbInputsOutputs:
    def __init__(self, filename):
        self.filename = filename
        self.headers_written = False
        if os.path.exists(self.filename):
            with open(self.filename, 'r', newline='') as file:
                reader = csv.reader(file)
                self.headers = next(reader)
        else:
            self.headers = None

    def add_data(self, data):
        if not self.headers:
            self.headers = data.keys()

        mode = 'a' if os.path.exists(self.filename) else 'w'
        with open(self.filename, mode, newline='') as file:
            writer = csv.DictWriter(file, fieldnames=self.headers)

            if not self.headers_written:
                writer.writeheader()
                self.headers_written = True

            # Filling missing keys with empty values
            for header in self.headers:
                data.setdefault(header, '')

            writer.writerow(data)

    def print_data(self):
        if not os.path.exists(self.filename):
            print("Database file does not exist.")
            return

        df = pd.read_csv(self.filename)
        print(df)

    def get_headers(self):
        return list(self.headers) if self.headers else None


# Usage
# db = DbInputsOutputs("../data/test_data.csv")
# print(db.get_headers())
#
# # db.add_data({'query': 'How does ML work?', 'retriever': 'Bing', 'answer': 'Through algorithms'})
# # db.add_data({'query': 'What is AI?', 'retriever': 'Google'})
# db.print_data()

# add a timestamp of the current time
import datetime
import time
# current_time = datetime.datetime.now()


