#!/bin/bash
set -euo pipefail
tag=thavlik/kind-test-runner:latest
docker build -t $tag .