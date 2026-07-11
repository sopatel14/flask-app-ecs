# Flask App — AWS ECS Deployment with GitHub Actions CI/CD

A minimal Flask web application built for learning **containerization, CI/CD automation, Docker, and deployment to AWS ECS (Elastic Container Service)**.

Part of the **TrainWithShubham – DevOps Zero To Hero** course.

---

## Workflow Status

[![PR Pipeline](https://github.com/sopatel14/flask-app-ecs/actions/workflows/pr-pipeline.yml/badge.svg)](https://github.com/sopatel14/flask-app-ecs/actions/workflows/pr-pipeline.yml)
[![Main Pipeline](https://github.com/sopatel14/flask-app-ecs/actions/workflows/main-pipeline.yml/badge.svg)](https://github.com/sopatel14/flask-app-ecs/actions/workflows/main-pipeline.yml)

---

![Python](https://img.shields.io/badge/Python-3.14-blue)
![Flask](https://img.shields.io/badge/Flask-3.1.1-green)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED)
![AWS ECS](https://img.shields.io/badge/AWS-ECS-FF9900)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI/CD-2088FF)

---

## Project Overview

This project demonstrates a production-style DevOps workflow by combining a Flask application with Docker, GitHub Actions, and AWS ECS.

The application includes automated CI/CD pipelines that:

- Validate every Pull Request
- Build and test the application
- Build and push Docker images
- Deploy using GitHub Environments
- Perform scheduled health checks

---

## Features

- Responsive landing page with modern glassmorphism UI
- `/health` endpoint for automated health checks
- Docker support (single-stage & multistage)
- GitHub Actions CI/CD pipeline
- Reusable GitHub Actions workflows
- **DevSecOps: Trivy vulnerability scanning gate before every image push**
- Docker image publishing to Docker Hub
- Production deployment workflow
- Scheduled health monitoring

---

## Security / DevSecOps

Every image built on `main` is scanned **before** it's allowed to reach Docker Hub:

- **Scanner:** [Trivy](https://github.com/aquasecurity/trivy-action) (`aquasecurity/trivy-action`)
- **Severity gate:** `CRITICAL`, `HIGH`
- **Behavior:** `exit-code: 1` — the job fails and the push step is skipped if any critical/high vulnerability is found in the image
- **Where it runs:** the `docker` job in `main-pipeline.yml`, between the build step and the push step

This means a vulnerable image is caught in CI and never reaches Docker Hub or ECS.

---

## Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Flask 3.1.1 |
| Runtime | Python 3.14 (Dockerfile) · 3.13 (CI test job) |
| Container | Docker |
| CI/CD | GitHub Actions |
| Image Registry | Docker Hub |
| Deployment | AWS ECS |

---

## CI/CD Pipeline

### Pull Request Pipeline (`pr-pipeline.yml`)

When a Pull Request is opened or updated:

- Checkout repository
- Build application
- Run tests
- Validate changes

Uses the reusable `reusable-build-test.yml` workflow.

---

### Main Branch Pipeline (`main-pipeline.yml`)

Runs on every push to `main`, as three sequential jobs:

1. **`build-test`** — sets up Python 3.13, installs dependencies, and runs a compile check
2. **`docker`** — builds the Docker image, **scans it with Trivy** (fails the job on any `CRITICAL`/`HIGH` finding), then pushes to Docker Hub only if the scan passes
3. **`deploy`** — runs against the `production` GitHub Environment (currently a placeholder step; real ECS deployment commands go here)

---

### Scheduled Health Check (`health-check.yml`)

Runs every 12 hours (or manually).

The workflow:

- Pulls the latest Docker image
- Starts the container
- Verifies `/health`
- Generates a workflow summary

---

## Project Structure

```text
flask-app-ecs/
├── .github/
│   └── workflows/
│       ├── health-check.yml
│       ├── main-pipeline.yml
│       ├── pr-pipeline.yml
│       ├── reusable-build-test.yml
│       └── reusable-docker.yml
├── templates/
│   └── index.html
├── app.py
├── run.py
├── requirements.txt
├── Dockerfile
├── Dockerfile-multi
└── README.md
```

---

## Quick Start

### Run Locally

```bash
pip install -r requirements.txt
python run.py
```

Application:

```
http://localhost:80
```

---

### Docker

Build

```bash
docker build -t flask-app .
```

Run

```bash
docker run -p 80:80 flask-app
```

---

## Docker Hub

Published images: [`sopatel264/flask-app-ecs`](https://hub.docker.com/repository/docker/sopatel264/flask-app-ecs/general)

---

## Available Endpoints

| Endpoint | Description |
|----------|-------------|
| `/` | Landing Page |
| `/health` | Health Check Endpoint |

---

## AWS ECS Deployment

High-level deployment flow:

1. **Push image to ECR**
   ```bash
   aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
   docker tag flask-app:latest <account-id>.dkr.ecr.<region>.amazonaws.com/flask-app:latest
   docker push <account-id>.dkr.ecr.<region>.amazonaws.com/flask-app:latest
   ```

2. **Create ECS Task Definition** — specify the ECR image, port 80, memory/CPU limits

3. **Create ECS Service** — attach to a cluster, configure desired count, link to a load balancer

4. **Configure ALB** — target group pointing to port 80, use `/health` as the health check path
