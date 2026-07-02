# Flask App — AWS ECS Deployment with GitHub Actions CI/CD

A minimal Flask web application built for learning **containerization, CI/CD automation, Docker, and deployment to AWS ECS (Elastic Container Service)**.

Part of the **TrainWithShubham – DevOps Zero To Hero** course.

---

## Workflow Status

[![PR Pipeline](https://github.com/sopatel14/flask-app-ecs/actions/workflows/pr-pipeline.yml/badge.svg)](https://github.com/sopatel14/flask-app-ecs/actions/workflows/pr-pipeline.yml)
[![Main Pipeline](https://github.com/sopatel14/flask-app-ecs/actions/workflows/main-pipeline.yml/badge.svg)](https://github.com/sopatel14/flask-app-ecs/actions/workflows/main-pipeline.yml)
[![Scheduled Health Check](https://github.com/sopatel14/flask-app-ecs/actions/workflows/health-check.yml/badge.svg)](https://github.com/sopatel14/flask-app-ecs/actions/workflows/health-check.yml)

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
- Docker image publishing
- Production deployment workflow
- Scheduled health monitoring

---

## Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Flask 3.1.1 |
| Runtime | Python 3.14 |
| Container | Docker |
| CI/CD | GitHub Actions |
| Image Registry | Docker Hub |
| Deployment | AWS ECS |

---

## CI/CD Pipeline

### Pull Request Pipeline

When a Pull Request is opened or updated:

- Checkout repository
- Build application
- Run tests
- Validate changes

---

### Main Branch Pipeline

After merging into `main`:

- Build & Test
- Build Docker image
- Push image to Docker Hub
- Deploy to Production Environment

---

### Scheduled Health Check

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
│       ├── reusable-build-test.yml
│       ├── reusable-docker.yml
│       ├── pr-pipeline.yml
│       ├── main-pipeline.yml
│       └── health-check.yml
├── app.py
├── run.py
├── requirements.txt
├── Dockerfile
├── Dockerfile-multi
└── templates/
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

## Available Endpoints

| Endpoint | Description |
|----------|-------------|
| `/` | Landing Page |
| `/health` | Health Check Endpoint |

---

## AWS ECS Deployment

High-level deployment flow:

1. Build Docker Image
2. Push Image to Amazon ECR
3. Create ECS Task Definition
4. Create ECS Service
5. Configure Application Load Balancer
6. Use `/health` as the health check endpoint

---

## Learning Outcomes

This project helped me learn:

- GitHub Actions
- Reusable Workflows
- Workflow Outputs
- Docker Build & Push
- GitHub Secrets
- GitHub Environments
- Scheduled Workflows
- Health Checks
- CI/CD Best Practices
- AWS ECS Deployment

---

## Future Improvements

- Vulnerability scanning with Trivy
- Slack notifications
- Multi-environment deployments
- Terraform infrastructure
- Kubernetes deployment
- Automatic rollback strategy

---

## Author

**Sourav Patel**

GitHub: https://github.com/sopatel14

---

⭐ If you found this project useful, consider giving it a star!