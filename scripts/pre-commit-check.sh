#!/usr/bin/env bash
# Run all pre-commit checks without installing the git hook (same as CI-oriented local gate).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if command -v pre-commit >/dev/null 2>&1; then
  exec pre-commit run --all-files "$@"
fi

echo "pre-commit not found; install with: ./scripts/install-pre-commit.sh" >&2
exit 1
