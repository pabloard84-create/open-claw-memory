#!/bin/zsh
set -euo pipefail

REPO="/Users/pabloagent/.openclaw/workspace"
cd "$REPO"

if ! git diff --quiet || ! git diff --cached --quiet; then
  git add MEMORY.md MEMORY_SYSTEM.md STYLE.md BACKUP_PLAN.md AGENTS.md memory .gitignore 2>/dev/null || true
  if ! git diff --cached --quiet; then
    git commit -m "Memory snapshot: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
  fi
fi
