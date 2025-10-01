from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from Cloud Run via CI/CD!"}

@app.get("/health")
def health():
    return {"status": "ok"}