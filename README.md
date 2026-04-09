
# second-project

[![CI Pipeline](https://github.com/YOUR-USERNAME/second-project/actions/workflows/ci.yml/badge.svg)](https://github.com/YOUR-USERNAME/second-project/actions/workflows/ci.yml)

A beginner-friendly DevOps portfolio project that demonstrates how to build a real CI pipeline for a small Python application using **GitHub Actions**, with automated testing, linting, formatting checks, security scanning, artifact creation, and Docker image builds.

---

## Project Overview

This project was built step by step to demonstrate practical CI/CD and DevOps fundamentals in a simple, easy-to-understand way.

At this stage of the project, the repository includes:

- Git and GitHub version control
- a small Python application
- automated testing with `pytest`
- linting with `flake8`
- formatting validation with `black`
- basic security scanning with `bandit`
- dependency caching in GitHub Actions
- artifact creation and upload
- Docker image build support
- GitHub Container Registry preparation

The goal of this project is not to build a large application.  
The goal is to show that I understand how to structure a project properly and automate quality checks and build processes the way real teams do.

---

## What This Project Demonstrates

This project is designed to show practical experience with:

- source control using Git and GitHub
- CI pipeline creation with GitHub Actions
- automated code validation on push and pull request
- repeatable dependency installation
- faster pipeline runs through caching
- artifact generation in CI
- containerization with Docker
- container build automation in GitHub Actions
- registry-ready image publishing workflow design

---

## Current Project Structure

```text
second-project/
├── .github/
│   └── workflows/
│       └── ci.yml
├── app/
│   ├── __init__.py
│   └── main.py
├── scripts/
│   └── build_artifact.sh
├── tests/
│   └── test_main.py
├── .dockerignore
├── .gitignore
├── Dockerfile
├── requirements.txt
├── requirements-dev.txt
└── README.md
````

---

## Application

The application is intentionally simple.

It contains a small Python function that returns a greeting, which makes it easy to test, lint, scan, package, and containerize.

### `app/main.py`

```python
def greet(name: str) -> str:
    return f"Hello, {name}!"


def main() -> None:
    print(greet("DevOps"))


if __name__ == "__main__":
    main()
```

---

## Testing

The project uses `pytest` for automated testing.

### `tests/test_main.py`

```python
from app.main import greet


def test_greet():
    assert greet("Owais") == "Hello, Owais!"
```

This gives the CI pipeline a real test to run on every push and pull request.

---

## Development Tools Used

Development and CI tools are listed in `requirements-dev.txt`.

### `requirements-dev.txt`

```txt
pytest
flake8
black
bandit
```

### What each tool does

* **pytest**: runs automated tests
* **flake8**: checks code style and common issues
* **black**: validates code formatting
* **bandit**: performs basic Python security scanning

---

## Local Setup

### 1. Clone the repository

```bash
git clone https://github.com/YOUR-USERNAME/second-project.git
cd second-project
```

### 2. Create a virtual environment

```bash
python3 -m venv venv
```

### 3. Activate the virtual environment

On macOS/Linux:

```bash
source venv/bin/activate
```

On Windows PowerShell:

```powershell
venv\Scripts\Activate.ps1
```

### 4. Install development dependencies

```bash
pip install -r requirements-dev.txt
```

---

## Run the Application Locally

```bash
python app/main.py
```

Expected output:

```text
Hello, DevOps!
```

---

## Run Quality Checks Locally

### Run tests

```bash
pytest
```

### Run linting

```bash
flake8 app tests
```

### Check formatting

```bash
black --check app tests
```

### Run security scan

```bash
bandit -r app
```

---

## Build Local Project Artifact

This project includes a small shell script to simulate a basic build output.

### Run the build script

```bash
./scripts/build_artifact.sh
```

This creates a `dist/` folder containing selected project files.

### `scripts/build_artifact.sh`

```bash
#!/usr/bin/env bash
set -e

mkdir -p dist

cp -r app dist/app
cp README.md dist/README.md
cp requirements-dev.txt dist/requirements-dev.txt

echo "Build artifact created successfully."
```

### Why this exists

This helps demonstrate that CI can do more than just run tests.
It can also produce a reusable output.

---

## Docker Support

This phase of the project includes Docker support.

### Build the Docker image locally

```bash
docker build -t second-project:local .
```

### Run the Docker container

```bash
docker run --rm second-project:local
```

Expected output:

```text
Hello, DevOps!
```

---

## Dockerfile

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY app/ /app/app/

CMD ["python", "app/main.py"]
```

### Why this Dockerfile is simple

This project is focused on learning CI/CD and Docker basics clearly.

The Dockerfile is intentionally minimal so the important concepts are easy to understand:

* choosing a base image
* setting a working directory
* copying application code
* defining a default startup command

---

## GitHub Actions CI Workflow

This repository uses **GitHub Actions** to automate checks and builds.

The CI pipeline runs on:

* pushes to `main`
* pull requests targeting `main`

### The pipeline currently performs

* repository checkout
* Python setup
* pip dependency caching
* dependency installation
* test execution
* linting
* formatting validation
* security scanning
* artifact creation
* artifact upload
* Docker image build
* GHCR-ready publish workflow logic

---

## GitHub Actions Workflow File

### `.github/workflows/ci.yml`

```yaml
name: CI Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test-build-and-check:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    steps:
      - name: Checkout repository code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v6
        with:
          python-version: "3.11"
          cache: "pip"
          cache-dependency-path: requirements-dev.txt

      - name: Install development dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements-dev.txt

      - name: Run tests
        run: pytest

      - name: Run linting
        run: flake8 app tests

      - name: Check formatting
        run: black --check app tests

      - name: Run security scan
        run: bandit -r app

      - name: Build project artifact
        run: ./scripts/build_artifact.sh

      - name: Upload build artifact
        uses: actions/upload-artifact@v4
        with:
          name: python-app-build
          path: dist/

      - name: Set image name
        run: echo "IMAGE_NAME=ghcr.io/${{ github.repository_owner }}/second-project" >> $GITHUB_ENV

      - name: Log in to GitHub Container Registry
        if: github.event_name == 'push'
        uses: docker/login-action@v4
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build Docker image
        uses: docker/build-push-action@v7
        with:
          context: .
          push: false
          tags: ${{ env.IMAGE_NAME }}:latest

      - name: Build and push Docker image to GHCR
        if: github.event_name == 'push'
        uses: docker/build-push-action@v7
        with:
          context: .
          push: true
          tags: ${{ env.IMAGE_NAME }}:latest
```

---

## Artifact Output

The workflow uploads a build artifact named:

```text
python-app-build
```

This artifact contains the generated `dist/` folder.

This demonstrates a real CI/CD idea:
a pipeline can produce useful outputs, not only pass or fail.

---

## Container Registry Design

The workflow is prepared to use **GitHub Container Registry (GHCR)**.

Expected image format:

```text
ghcr.io/YOUR-USERNAME/second-project:latest
```

This means the project is moving from simple CI into real build and packaging workflows.

---

## Why This Project Matters

This project demonstrates a practical DevOps learning journey from a very simple Python app to a repository with real automation.

It shows that I understand how to:

* structure a repository cleanly
* use Git and GitHub properly
* automate validation checks
* improve CI speed with caching
* produce workflow artifacts
* build container images
* prepare images for registry publishing

Even though the application itself is small, the delivery workflow around it reflects real DevOps thinking.

---
