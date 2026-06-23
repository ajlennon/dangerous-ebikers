#!/usr/bin/env bash
set -euo pipefail
for f in "$@"; do
  python3 -m py_compile "$f"
done
