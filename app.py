from fastapi import FastAPI 
from app.main import app 
# noqa: F401 

app = FastAPI() 


@app.get("/") 
def read_root(): 
    return {"message": "Hello from Cloud Run via CI/CD!"} 


@app.get("/health") 
def health(): 
    return {"status": "ok"}
