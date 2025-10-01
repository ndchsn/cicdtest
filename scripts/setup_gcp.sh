#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-your-gcp-project-id}"
REGION="${REGION:-asia-southeast2}"
REPO="${REPO:-hello-api}"
SA_NAME="${SA_NAME:-github-actions-deployer}"
SA_EMAIL="${SA_EMAIL:-${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com}"

echo ">>> Setting project"
gcloud config set project "$PROJECT_ID"

echo ">>> Enabling APIs"
gcloud services enable run.googleapis.com artifactregistry.googleapis.com iamcredentials.googleapis.com cloudresourcemanager.googleapis.com

echo ">>> Creating Artifact Registry (Docker) if not exists"
gcloud artifacts repositories create "$REPO" --repository-format=docker --location="$REGION" --description="CI/CD demo repo" || true

echo ">>> Creating Service Account (if not exists)"
gcloud iam service-accounts create "$SA_NAME" --display-name "GitHub Actions deployer" || true

echo ">>> Granting roles to SA"
gcloud projects add-iam-policy-binding "$PROJECT_ID" --member="serviceAccount:${SA_EMAIL}" --role="roles/run.admin"
gcloud projects add-iam-policy-binding "$PROJECT_ID" --member="serviceAccount:${SA_EMAIL}" --role="roles/artifactregistry.writer"
gcloud projects add-iam-policy-binding "$PROJECT_ID" --member="serviceAccount:${SA_EMAIL}" --role="roles/iam.serviceAccountUser"

echo ">>> Creating key.json for GitHub secret"
gcloud iam service-accounts keys create key.json --iam-account="${SA_EMAIL}"
echo "Upload key.json into your GitHub repo as secret: GCP_SA_KEY"
echo "Also add secret: GCP_PROJECT_ID=${PROJECT_ID}"