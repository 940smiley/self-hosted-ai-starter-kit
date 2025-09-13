#!/usr/bin/env bash
set -e

# Load environment variables from .env if present
if [ -f "./.env" ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Check for required commands
for cmd in n8n qdrant ollama; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Warning: $cmd is not installed or not in PATH" >&2
  fi
done

# Start n8n
exec n8n start
