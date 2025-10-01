from fastapi.testclient import TestClient
from app import app


client = TestClient(app)



def test_health():
    r = client.get("/health")
    assert r.status_code == 200
    assert r.json().get("status") == "ok"



def test_root():
    r = client.get("/")
    assert r.status_code == 200
    assert "message" in r.json()
