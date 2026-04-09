# second-project

A beginner-friendly but portfolio-grade DevOps project that demonstrates how to build a real CI/CD pipeline for a Python application using GitHub Actions, Docker, GitHub Container Registry, semantic versioning, and release-aware automation.

## Overview

This project was built to demonstrate practical CI/CD skills in a way that reflects real team workflow discipline rather than a toy example. It starts with a small Python application and evolves into a complete GitHub-based automation pipeline that validates code quality, packages artifacts, builds container images, publishes versioned releases, and introduces controlled deployment flow.

The project is designed to show understanding of:

* source control with Git and GitHub
* continuous integration with GitHub Actions
* testing, linting, formatting, and security checks
* repeatable builds and artifact packaging
* Docker image creation and registry publishing
* semantic versioning and release tagging
* multi-platform container release builds
* controlled production deployment flow using GitHub Environments

## Tech stack

* Python 3.11
* Git and GitHub
* GitHub Actions
* pytest
* flake8
* black
* bandit
* Docker
* GitHub Container Registry (GHCR)

## Project structure

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
```

## Application

The application is intentionally small because the focus of this repository is the CI/CD pipeline, not application complexity.

`app/main.py`

```python
def greet(name: str) -> str:
    return f"Hello, {name}!"


def main() -> None:
    print(greet("DevOps"))


if __name__ == "__main__":
    main()
```

## Local setup

Create and activate a virtual environment:

```bash
python3 -m venv venv
source venv/bin/activate
```

Install development dependencies:

```bash
pip install -r requirements-dev.txt
```

## Run locally

Run the app:

```bash
python app/main.py
```

Expected output:

```text
Hello, DevOps!
```

## Run quality checks locally

Run tests:

```bash
pytest
```

Run linting:

```bash
flake8 app tests
```

Check formatting:

```bash
black --check app tests
```

Run security scan:

```bash
bandit -r app
```

Build local artifact:

```bash
./scripts/build_artifact.sh
```

## Docker

Build the image locally:

```bash
docker build -t second-project:local .
```

Run the container:

```bash
docker run --rm second-project:local
```

## CI pipeline

This project uses GitHub Actions to automatically validate the application and build outputs.

The workflow runs on:

* pushes to `main`
* pull requests targeting `main`
* semantic version tags such as `v1.0.0`

### CI checks included

On every push and pull request, the pipeline can perform:

* Python environment setup
* dependency installation with pip caching
* test execution with `pytest`
* linting with `flake8`
* formatting validation with `black --check`
* security scanning with `bandit`
* artifact creation and upload
* Docker image build validation

## Artifact packaging

The project includes a small build script:

```bash
./scripts/build_artifact.sh
```

This creates a simple build output under `dist/` and uploads it in GitHub Actions as a workflow artifact.

This demonstrates that the pipeline does more than just pass or fail. It also produces a reusable build output.

## Container registry publishing

This project is designed to publish Docker images to GitHub Container Registry.

Example registry path:

```text
ghcr.io/YOUR-USERNAME/second-project
```

For normal pushes, the workflow can publish SHA-based tags for traceability.

Example:

```text
ghcr.io/YOUR-USERNAME/second-project:sha-<shortsha>
```

## Semantic versioning and release tags

This project uses semantic versioning with Git tags in the format:

```text
vMAJOR.MINOR.PATCH
```

Example:

```text
v1.0.0
```

Create and push a release tag:

```bash
git tag v1.0.0
git push origin v1.0.0
```

On version tags, the workflow can publish release-aware Docker tags such as:

```text
ghcr.io/YOUR-USERNAME/second-project:1.0.0
ghcr.io/YOUR-USERNAME/second-project:1.0
ghcr.io/YOUR-USERNAME/second-project:latest
```

## Multi-platform release builds

For versioned releases, the workflow is designed to build multi-platform Docker images for:

* `linux/amd64`
* `linux/arm64`

This makes the project more realistic and closer to modern deployment practices.

## GitHub Releases

When a semantic version tag is pushed, the workflow can also create a GitHub Release automatically with generated release notes.

This helps make release history easier for humans to understand and review.

## Deployment flow

The workflow includes a production deployment job tied to a GitHub Environment named `production`.

This is designed to demonstrate controlled delivery flow rather than immediate uncontrolled deployment.

GitHub Environment rules can be configured to require:

* manual approval
* required reviewers
* wait timers
* environment-specific secrets

This introduces a more realistic production release pattern.

## Recommended GitHub branch protection

To complete the team workflow discipline side of the project, configure branch protection for `main` in GitHub:

* require pull requests before merging
* require status checks to pass before merging
* restrict direct pushes to `main`

This turns the repository from a simple CI demo into a more realistic team-ready workflow.

## Why this project matters

This project demonstrates practical DevOps skills that appear frequently in modern job descriptions:

* building CI pipelines as code
* creating repeatable validation workflows
* enforcing quality gates automatically
* packaging artifacts in CI
* building and publishing Docker images
* using semantic versioning and release tags
* improving traceability through SHA-based image tagging
* introducing protected deployment flow

It is intentionally small in application size so the DevOps workflow remains the main focus.

## Suggested future improvements

Strong next steps for this project could include:

* real deployment to a VM, EC2 instance, or Kubernetes cluster
* branch protection screenshots in the repo docs
* test coverage reporting
* dependency vulnerability scanning
* staging and production environment separation
* rollback documentation
* infrastructure provisioning with Terraform

## Author note

This repository was built as a hands-on DevOps portfolio project to demonstrate practical CI/CD understanding beyond basic tool usage. The focus is on source control discipline, automation design, validation quality, release handling, and delivery readiness.
