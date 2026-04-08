#!/usr/bin/env bash
set -e

mkdir -p dist

cp -r app dist/app
cp README.md dist/README.md
cp requirements-dev.txt dist/requirements-dev.txt

echo "Build artifact created successfully."
