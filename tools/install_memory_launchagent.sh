#!/bin/zsh
set -euo pipefail

PLIST="$HOME/Library/LaunchAgents/com.pabloai.memory-snapshot.plist"
SCRIPT="/Users/pabloagent/.openclaw/workspace/tools/memory_snapshot.sh"

cat > "$PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.pabloai.memory-snapshot</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/zsh</string>
    <string>$SCRIPT</string>
  </array>
  <key>StartInterval</key>
  <integer>1800</integer>
  <key>RunAtLoad</key>
  <true/>
  <key>StandardOutPath</key>
  <string>/tmp/com.pabloai.memory-snapshot.out</string>
  <key>StandardErrorPath</key>
  <string>/tmp/com.pabloai.memory-snapshot.err</string>
</dict>
</plist>
PLIST

launchctl unload "$PLIST" 2>/dev/null || true
launchctl load "$PLIST"
echo "Installed: $PLIST"
