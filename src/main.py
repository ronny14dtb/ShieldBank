from fastapi import FastAPI

app = FastAPI(title="ShieldBank")

@app.get("/")
def home():
    return {"message": "Welcome to ShieldBank API 🚀"}


