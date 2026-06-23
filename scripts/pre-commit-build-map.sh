#!/usr/bin/env bash
# Run map builder (same as GitHub Pages CI) and require incidents.geojson to stay in sync.
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"
GEOJSON="docs/data/incidents.geojson"

python3 scripts/build-map-data.py

if [[ -f "$GEOJSON" ]] && ! git diff --quiet -- "$GEOJSON" 2>/dev/null; then
  echo "build-map-data.py updated $GEOJSON — stage it before committing:" >&2
  echo "  git add $GEOJSON" >&2
  exit 1
fi
