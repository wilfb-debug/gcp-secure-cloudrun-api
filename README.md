# Secure Cloud Run API on Google Cloud (IAM-Protected)

## Overview
This project demonstrates how to design, deploy, and secure a containerised API on Google Cloud Run using modern cloud-native security principles.

The focus is on:
- Secure-by-default serverless architecture
- IAM-based access control
- Token-based authentication
- Cost-efficient, production-ready design

---

## Architecture Overview
This solution uses a serverless architecture built around Cloud Run and Artifact Registry.

High-level components:
- Flask API (Python)
- Docker container
- Artifact Registry
- Cloud Run (fully managed)
- IAM (Identity & Access Management)

---

## Architecture Diagram
> Diagram created using Lucidchart (Google Cloud official icons)

![Architecture Diagram](screenshots/architecture/architecture-diagram.png)

---

## Goals

This project demonstrates a secure-by-default serverless API on Google Cloud using Cloud Run and IAM.
Key goals:

- Deploy a containerized API to Cloud Run
- Enforce authentication using IAM (no public access)
- Validate access patterns (403 without token, 200 with token)
- Keep infrastructure cost-safe with teardown steps

---

## Architecture Overview

**High-level flow:**
1. Developer builds the container image locally with Docker
2. Image is pushed to **Artifact Registry**
3. **Cloud Run** deploys a new revision referencing that image
4. Public (unauthenticated) requests return **403 Forbidden**
5. Authenticated requests with a valid **OIDC identity token** return **200 OK**

**Security posture:**
- Cloud Run is **NOT** configured for public access
- Access is controlled via **IAM role `roles/run.invoker`**
- Token-based authentication is required for invocation

---

## Security Model (Why this is secure)

### Authentication
Cloud Run requires a valid identity token (OIDC) to invoke the service.
- Without token → **403 Forbidden**
- With token → **200 OK**

### Authorization (Least Privilege)
Access is granted only to specific principals via:
- `roles/run.invoker`

No broad “allUsers” access is permitted.

### Threats addressed
- Prevents anonymous/public invocation
- Reduces accidental exposure of endpoints
- Enforces least privilege by default

---

## Verification Evidence

This project includes screenshots proving:

- Local Flask API running
- Docker container running locally
- Cloud Run deployment successful
- IAM locked down (403 without token)
- Successful invocation using token (200)
- Artifact Registry image present
- Cost-safe teardown completed

Screenshots are stored in `./screenshots/`.

---

## Operations Runbook

### Deploy (high level)
1. Build Docker image
2. Push image to Artifact Registry
3. Deploy to Cloud Run with IAM enforced

### Test endpoints
- `/health` returns `{"status":"ok"}`
- `/` returns service status JSON

### Cost-safe teardown
Cloud Run service + Artifact Registry repo are deleted after validation.

---

## Limitations

- Token auth is tested using `gcloud auth print-identity-token` (developer identity)
- No CI/CD pipeline yet (added in Phase 4)
- No automated vulnerability scanning enabled for the registry (optional enhancement)

---

## Roadmap / Next Improvements

Planned upgrades:

- CI/CD with GitHub Actions
- Workload Identity Federation (no long-lived service account keys)
- Automated deploy to Cloud Run on merge to main
- Container image scanning + policy checks
- Structured logging and monitoring (Cloud Logging + Error Reporting)

---

## Local Development
The API is developed and tested locally using Python virtual environments and Docker.

### Local Flask Test
![Local Flask Running](screenshots/01-local/local-flask-running.png)

---

## Containerisation with Docker
The application is packaged as a Docker container to ensure environment consistency across local and cloud environments.

### Docker Image Build & Run
![Docker Local Run](screenshots/02-docker/docker-local-run.png)

---

## Deployment to Cloud Run
The container image is pushed to Google Artifact Registry and deployed to Cloud Run.

### Cloud Run Service
![Cloud Run Service](screenshots/03-cloudrun/cloudrun-service.png)

---

## Security & IAM Enforcement
Public access is explicitly disabled. Requests require a valid identity token issued by Google IAM.

### Unauthenticated Request (403 Forbidden)
![Unauthenticated 403](screenshots/04-iam-security/unauthenticated-403.png)

### Authenticated Request (200 OK)
![Authenticated 200](screenshots/04-iam-security/authenticated-200.png)

---

## Artifact Registry
Docker images are stored securely in Artifact Registry.

### Stored Container Image
![Artifact Registry Image](screenshots/05-artifact-registry/artifact-image.png)

---

## Cost Management
The project is designed to be cost-safe:
- Serverless infrastructure
- Zero idle compute
- Services can be fully torn down without losing code or evidence

---

## Cost-Safe Teardown & Cleanup

To prevent unnecessary cloud costs after testing and validation, all deployed resources were safely removed.

### Cloud Run Service Cleanup
The Cloud Run service was deleted to stop any active or idle compute usage.

```bash
REGION=europe-west2
SERVICE=gcp-secure-cloudrun-api

gcloud run services delete $SERVICE \
  --region $REGION \
  --quiet
---

## Key Learnings
- Secure Cloud Run services using IAM
- Use identity tokens for zero-trust API access
- Build cost-efficient serverless architectures
- Structure production-ready cloud projects

---

## Technologies Used
- Google Cloud Run
- Google Artifact Registry
- Google IAM
- Docker
- Python (Flask)
- gcloud CLI
