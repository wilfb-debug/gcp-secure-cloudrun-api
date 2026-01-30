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
