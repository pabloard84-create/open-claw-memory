#!/bin/zsh
set -euo pipefail

PLIST="$HOME/Library/LaunchAgents/com.pabloai.memory-snapshot.plist"
launchctl unload "$PLIST" 2>/dev/null || true
rm -f "$PLIST"
echo "Removed: $PLIST"
