#!/usr/bin/env bash
set -e

# Load environment variables from .env if present
if [ -f "./.env" ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Check for required commands
# Check for required commands
for cmd in n8n qdrant ollama psql; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: $cmd is not installed or not in PATH" >&2
    exit 1
  fi
done

# Wait for PostgreSQL to be ready
until psql -h localhost -U "${POSTGRES_USER:-postgres}" -d "${POSTGRES_DB:-postgres}" -c '\q' 2>/dev/null; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 1
done
done

# Start n8n
exec n8n start
