#!/usr/bin/env bash
# Acta installer (macOS / Linux)
# Copies the acta-* skills and shared resources into your Claude config (~/.claude).
set -euo pipefail

CLAUDE="${HOME}/.claude"
SRC="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "${CLAUDE}/skills"
for d in "${SRC}/skills/"acta-*; do
  cp -R "$d" "${CLAUDE}/skills/"
  echo "installed skill: $(basename "$d")"
done
cp -R "${SRC}/acta" "${CLAUDE}/"
echo "installed shared resources: ~/.claude/acta"
echo
echo "Acta installed. Restart Claude Code, then run /acta-init"
