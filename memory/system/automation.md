# Automation

## Memory snapshot script
- Script: `tools/memory_snapshot.sh`
- Purpose: commit and push memory changes when present.

## Usage
Run manually:
```bash
zsh /Users/pabloagent/.openclaw/workspace/tools/memory_snapshot.sh
```

## Notes
- Requires GitHub auth already configured.
- Only snapshots tracked memory-related files.
- Generated/heavy artifacts should stay out of git.
