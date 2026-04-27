# Secure Cloud Run Flask Application

![GCP](https://img.shields.io/badge/GCP-Cloud%20Run-4285F4?logo=google-cloud)
![Python](https://img.shields.io/badge/Python-Flask-3776AB?logo=python)
![Security](https://img.shields.io/badge/Security-Secret%20Manager%20%2B%20IAM-blue)
![CI/CD](https://img.shields.io/badge/CI%2FCD-Cloud%20Build-4285F4?logo=google-cloud)
![Observability](https://img.shields.io/badge/Observability-Cloud%20Logging-brightgreen)

## Architecture Overview

This project demonstrates the transformation of an intentionally insecure cloud-native application into a secure, observable, and scalable architecture using Google Cloud managed services.

The initial version intentionally demonstrated common cloud anti-patterns — hardcoded secrets, exposed credentials via HTTP responses, and no observability. These were then systematically identified and remediated using cloud-native best practices.

---

## Architectural Evolution Summary

This project begins with an insecure baseline to demonstrate common cloud anti-patterns, including hardcoded secrets, public unauthenticated access, and manual deployments. The final architecture applies cloud-native security and reliability principles using managed Google Cloud services, resulting in a secure, observable, and scalable production-ready design.

### Before: Insecure Baseline

![Architecture Before](diagrams/architecture-before.png)

### After: Hardened Cloud-Native Architecture

![Architecture After](diagrams/architecture-after.png)

---

## Before vs After Comparison

| Area | Before (Insecure) | After (Secure) |
|---|---|---|
| Secrets Management | Hardcoded in source code, exposed via HTTP | Stored in Secret Manager, accessed at runtime |
| IAM & Access Control | Default permissions, no restrictions | Dedicated service account with least privilege |
| Configuration | Static, embedded in application code | Environment-based, managed by Cloud Run |
| Observability | None | Cloud Logging and Cloud Monitoring enabled |
| Deployment | Manual and error-prone | Automated CI/CD via Cloud Build |
| Scalability | Unmanaged | Serverless autoscaling with Cloud Run |
| Security Posture | High risk of credential exposure | Production-aligned cloud security best practices |

---

## Live Deployment Proof

- **Platform:** Google Cloud Run (europe-west1)
- **CI/CD:** GitHub → Cloud Build → Cloud Run
- **Container:** Docker
- **Runtime:** Python (Flask)
- **Port:** Uses `$PORT` as required by Cloud Run
- **Scaling:** Auto-scaling with scale-to-zero
- **Observability:** Cloud Logging enabled and verified

Validated by:
- Successful Cloud Build pipeline execution
- Active Cloud Run service with public URL
- Verified request logs in Cloud Logging

---

## Threat Model

| Threat | Risk | Mitigation | GCP Service |
|---|---|---|---|
| Hardcoded secrets | Credential leakage | Store and access secrets at runtime | Secret Manager |
| Secrets exposed via HTTP | Data breach | Never return secrets in responses | Secret Manager + App code |
| Over-privileged access | Unauthorized resource access | Dedicated least-privilege service account | IAM |
| Misconfigured port | Service outage | Bind to `0.0.0.0`, read `PORT` env var | Cloud Run |
| Lack of observability | Slow incident response | Centralized logs and metrics | Cloud Logging / Monitoring |
| Manual deployments | Drift & human error | Automated CI/CD | Cloud Build |
| Supply chain compromise | Malicious container deployed | Controlled source + build logs | Cloud Build |

---

## Project Structure

```
.
├── app.py                  # Flask application
├── Dockerfile              # Container build definition
├── requirements.txt        # Python dependencies
├── diagrams/
│   ├── architecture-before.png
│   └── architecture-after.png
└── README.md
```

---

## Core Components

### Cloud Run (Serverless Runtime)
- Hosts the Flask application
- Automatically scales based on incoming traffic, scales to zero when idle
- Reads application port from `PORT` environment variable

### Cloud Build (CI/CD)
- Builds and deploys the container image automatically on every GitHub push
- Ensures consistent, repeatable deployments

### Secret Manager
- Stores sensitive values (database hostnames, passwords)
- Secrets accessed at runtime only — never hardcoded or returned in responses

### IAM
- Dedicated service account for Cloud Run
- Granted only `secretmanager.versions.access`
- Follows principle of least privilege

### Observability
- Cloud Logging captures all application and request logs
- Cloud Monitoring provides runtime metrics
- `/crash` endpoint for error simulation
- `/slow` endpoint for latency simulation

---

## Resume Highlights

- Designed and deployed a secure serverless application on Google Cloud Run with HTTPS ingress and autoscaling
- Implemented secret management using Google Secret Manager, eliminating hardcoded credentials
- Built an automated CI/CD pipeline using Cloud Build triggered by GitHub commits
- Applied threat modeling to identify cloud security risks and implemented least-privilege IAM mitigations
- Enabled centralized logging and monitoring using Cloud Logging and Cloud Monitoring
