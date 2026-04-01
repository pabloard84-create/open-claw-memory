#!/bin/zsh
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <media-file> [language|auto]" >&2
  exit 1
fi

INPUT="$1"
LANGUAGE="${2:-auto}"
ROOT="/Users/pabloagent/.openclaw/workspace"
MODEL="$ROOT/models/whisper/ggml-base.bin"
OUTDIR="$ROOT/tmp/media"
BASENAME="$(basename "$INPUT")"
STEM="${BASENAME%.*}"
WORKDIR="$OUTDIR/$STEM"

mkdir -p "$WORKDIR"

AUDIO="$WORKDIR/audio.wav"
TRANSCRIPT_BASE="$WORKDIR/transcript"
FRAMES_DIR="$WORKDIR/frames"
mkdir -p "$FRAMES_DIR"

# Extract mono 16k wav for robust transcription
ffmpeg -y -i "$INPUT" -vn -ac 1 -ar 16000 "$AUDIO" >/dev/null 2>&1

# Transcribe
whisper-cli -m "$MODEL" -l "$LANGUAGE" -f "$AUDIO" -otxt -osrt -ovtt -oj -of "$TRANSCRIPT_BASE" >/dev/null

# Try to extract a few representative frames if the input is a video
if ffprobe -v error -select_streams v:0 -show_entries stream=codec_type -of csv=p=0 "$INPUT" 2>/dev/null | grep -q video; then
  ffmpeg -y -i "$INPUT" -vf "fps=1/5" -frames:v 12 "$FRAMES_DIR/frame_%03d.jpg" >/dev/null 2>&1 || true
fi

echo "TRANSCRIPT_TXT=$TRANSCRIPT_BASE.txt"
echo "TRANSCRIPT_SRT=$TRANSCRIPT_BASE.srt"
echo "TRANSCRIPT_VTT=$TRANSCRIPT_BASE.vtt"
echo "TRANSCRIPT_JSON=$TRANSCRIPT_BASE.json"
echo "FRAMES_DIR=$FRAMES_DIR"
