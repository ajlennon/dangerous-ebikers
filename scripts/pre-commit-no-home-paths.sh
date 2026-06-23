#!/usr/bin/env bash
set -euo pipefail
failed=0
for f in "$@"; do
  if grep -q '/home/' "$f"; then
    echo "$f: contains absolute /home/ path (use repo-relative paths)" >&2
    failed=1
  fi
done
exit "$failed"
