from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"message": "Hello from Cloud Run via CI/CD berhasil!"}


@app.get("/health")
def health():
    return {"status": "ok"}
