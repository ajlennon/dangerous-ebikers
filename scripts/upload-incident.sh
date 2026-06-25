#!/usr/bin/env bash
# Upload incident PUBLISH.mp4 to YouTube using *_UPLOAD.json (private by default).
# Review in Studio before public. --public requires --confirm-public-bypass.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INCIDENT="${1:?Usage: upload-incident.sh DEB-..._001 | path/to/_UPLOAD.json [--public] [--dry-run]}"

resolve_youtube_python() {
  local py
  for py in "${YOUTUBE_PYTHON:-}" \
    "${HOME}/anaconda3/bin/python3" \
    "$(command -v python3.10 2>/dev/null || true)" \
    "$(command -v python3 2>/dev/null || true)"; do
    [[ -n "$py" && -x "$py" ]] || continue
    if "$py" -c "import google.auth" 2>/dev/null; then
      echo "$py"
      return 0
    fi
  done
  echo "No Python with google-auth found. Install: pip3 install --user -r requirements-youtube.txt" >&2
  return 1
}

YOUTUBE_PY="$(resolve_youtube_python)"

shift || true
exec "$YOUTUBE_PY" "$ROOT/scripts/youtube-upload.py" "$INCIDENT" "$@"
