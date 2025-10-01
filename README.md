# DevOps Starter: CI/CD to Cloud Run (Python + FastAPI)

This repo demonstrates a minimal, production-like CI/CD pipeline:
- **CI**: Lint + test + build + push Docker image to Artifact Registry
- **CD**: Deploy to Cloud Run **staging**, manual approval, then deploy to **production**

## Prereqs
- GCP project
- `gcloud` CLI installed and authenticated
- GitHub repo (you will push this folder there)
- Billing enabled

## One-time GCP setup

```bash
export PROJECT_ID=your-project-id
export REGION=asia-southeast2
cd scripts
bash setup_gcp.sh
```

This will:
- Enable necessary APIs
- Create Artifact Registry repo
- Create a deployer Service Account and grant roles
- Generate `key.json` (upload to GitHub as secret **GCP_SA_KEY**)
- Add another repo secret **GCP_PROJECT_ID** with your project id

## GitHub Actions
The workflow lives in `.github/workflows/ci-cd.yml`:
- On push to `main`: run CI, push image, deploy to **staging**
- Then a manual approval step
- After approval: deploy to **production**

## Local run
```bash
pip install -r requirements.txt
uvicorn app:app --reload --port 8080
```

## Docker build (local)
```bash
docker build -t hello-api:local .
docker run -p 8080:8080 hello-api:local
```

## Endpoints
- `/` returns hello message
- `/health` returns `{ "status": "ok" }`