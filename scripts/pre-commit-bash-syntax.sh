#!/usr/bin/env bash
set -euo pipefail
for f in "$@"; do
  bash -n "$f"
done
