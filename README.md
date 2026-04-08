# second-project

A beginner-friendly DevOps portfolio project that demonstrates how to build a real CI pipeline for a Python application using GitHub Actions.

## Project goals

This project is designed to show practical CI/CD skills, including:

- source control with Git and GitHub
- automated testing with pytest
- code linting with flake8
- formatting checks with black
- basic Python security scanning with bandit
- dependency caching in GitHub Actions
- artifact creation and upload
- future Docker image builds and release automation

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
