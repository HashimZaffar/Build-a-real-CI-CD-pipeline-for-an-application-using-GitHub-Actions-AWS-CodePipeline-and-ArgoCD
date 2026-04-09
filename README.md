````md
# second-project

A beginner-friendly DevOps portfolio project that demonstrates how to build a real CI pipeline for a Python application using GitHub Actions.

## Project goals

This project is designed to show practical CI/CD skills, including:

- Source control with Git and GitHub
- Automated testing with `pytest`
- Code linting with `flake8`
- Formatting checks with `black`
- Basic Python security scanning with `bandit`
- Dependency caching in GitHub Actions
- Artifact creation and upload
- Future Docker image builds and release automation

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
├── requirements.txt
├── requirements-dev.txt
├── README.md
└── .gitignore
````

## Docker

Build the image locally:

```bash
docker build -t second-project:local .
```
