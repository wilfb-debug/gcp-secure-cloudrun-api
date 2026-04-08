# Contributing to GCP Secure Cloud Run API

This project demonstrates a secure-by-default Cloud Run API on GCP with modular Terraform IaC and GitHub Actions CI/CD. Contributions that improve security posture, extend the API, or refine the infrastructure are welcome.

---

## Project Structure

```
.
├── main.py                    # Flask application
├── requirements.txt           # Python dependencies
├── Dockerfile                 # Container build
├── .github/workflows/
│   ├── ci.yml                 # Lint + test + docker build
│   └── deploy.yml             # Deploy to Cloud Run
└── infra/terraform/
    ├── b1-bootstrap/          # GCP project + APIs
    ├── b2-foundation/         # VPC, networking
    ├── b3-cloudrun/           # Cloud Run service
    └── b4-iam/                # IAM bindings
```

---

## Local Setup

**Prerequisites:** Python 3.11+, Terraform 1.5+, Docker (optional)

```bash
git clone https://github.com/wilfb-debug/gcp-secure-cloudrun-api.git
cd gcp-secure-cloudrun-api

# Install Python dependencies
pip install -r requirements.txt
```

**Run the API locally:**

```bash
export PORT=8080
python main.py
# → http://localhost:8080/        {"status": "Sentinal API running"}
# → http://localhost:8080/health  {"status": "ok"}
```

---

## Running Tests

```bash
# Install dev dependencies
pip install pytest pytest-cov flake8

# Run tests
python -m pytest tests/ -v

# Run with coverage
python -m pytest tests/ --cov=. --cov-report=term-missing
```

---

## Terraform

Each module is applied in order. They are intentionally isolated — each stage only manages what it owns.

```bash
cd infra/terraform/b1-bootstrap
terraform init
terraform plan -var="project_id=your-project-id"
terraform apply

# Repeat for b2, b3, b4 in sequence
```

**Do not combine modules.** The staged approach is intentional — it mirrors real-world separation of concerns between platform, networking, workload, and IAM teams.

---

## Adding a New Endpoint

1. Add the route to `main.py`
2. Add a test in `tests/test_main.py` (see existing tests for pattern)
3. If the endpoint changes security posture (e.g. new ingress rule, IAM binding), update the relevant Terraform module
4. Update the README if the endpoint is user-facing

---

## Code Style

- Max line length: **100 characters**
- All endpoints must return JSON
- Environment variables for all config (no hardcoded values)

```bash
flake8 . --max-line-length=100 --exclude=venv,infra
```

---

## CI

Every push to `main` and every pull request runs:
1. **Import check** — verifies the app loads without errors
2. **Docker build** — confirms the image builds cleanly

PRs that fail CI will not be merged.
