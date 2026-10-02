#!/usr/bin/env bash
set -euo pipefail
go mod tidy
go build -trimpath -ldflags='-s -w' -o arduino-manager-gui .
echo "Built: ./arduino-manager-gui"
