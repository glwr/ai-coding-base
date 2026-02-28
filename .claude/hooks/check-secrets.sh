#!/bin/bash
# PostToolUse hook: Scan written/edited files for hardcoded secrets
# Runs after Write|Edit tool calls

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.filePath // empty')

# Skip non-source files
case "$FILE_PATH" in
  *.md|*.txt|*.json|*.yaml|*.yml|*.lock|*.css|*.svg|*.png|*.jpg|*.ico|*.example)
    exit 0
    ;;
esac

# Skip test/mock files
case "$FILE_PATH" in
  *test*|*spec*|*mock*|*fixture*|*.test.*|*.spec.*)
    exit 0
    ;;
esac

# Skip if file doesn't exist
[ -f "$FILE_PATH" ] || exit 0

# Check for potential secrets (high-confidence patterns only)
FINDINGS=$(grep -nE \
  '(password|secret|api_key|apiKey|API_KEY|PRIVATE_KEY|access_token|auth_token)\s*[:=]\s*["\x27][^"\x27]{8,}' \
  "$FILE_PATH" 2>/dev/null | grep -v '\.env\|process\.env\|example\|placeholder\|TODO\|FIXME\|your_\|changeme\|xxx')

if [ -n "$FINDINGS" ]; then
  echo "WARNING: Potential hardcoded secret detected in $FILE_PATH:" >&2
  echo "$FINDINGS" >&2
  echo "Use environment variables instead of hardcoding secrets." >&2
  # Exit 0 with warning (non-blocking) — shows warning but doesn't prevent the edit
  exit 0
fi

exit 0
