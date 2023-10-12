```
poetry run uvicorn research_copilot.slackbot.app:api --reload --port 3006 --log-level warning
ngrok http --domain=knolo.ngrok.app 3006
```
