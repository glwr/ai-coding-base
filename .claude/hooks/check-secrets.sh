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
  '(password|secret|api_key|apiKey|API_KEY|PRIVATE_KEY|access_token|auth_token|client_secret|clientSecret|signing_key|signingKey|encryption_key)\s*[:=]\s*["\x27][^"\x27]{8,}' \
  "$FILE_PATH" 2>/dev/null | grep -v '\.env\|process\.env\|example\|placeholder\|TODO\|FIXME\|your_\|changeme\|xxx\|FAKE_\|DUMMY_\|STUB_\|<.*>')

# Check for connection strings with embedded credentials
CONN_FINDINGS=$(grep -nE \
  '(postgresql|mysql|mongodb|redis|rediss|amqp|mssql)://[^@\s]+:[^@\s]+@' \
  "$FILE_PATH" 2>/dev/null | grep -v '\.env\|process\.env\|example\|placeholder\|localhost\|your_\|changeme\|FAKE_\|DUMMY_\|STUB_')

# Check for cloud credentials (Azure, AWS, GCP)
CLOUD_FINDINGS=$(grep -nE \
  '(AZURE_CLIENT_SECRET|AWS_SECRET_ACCESS_KEY|GOOGLE_APPLICATION_CREDENTIALS|ACR_PASSWORD|REGISTRY_PASSWORD)\s*[:=]\s*["\x27][^"\x27]{8,}' \
  "$FILE_PATH" 2>/dev/null | grep -v '\.env\|process\.env\|example\|placeholder\|TODO\|FIXME\|your_\|changeme\|FAKE_\|DUMMY_\|STUB_')

# Check for JWT/signing secrets (base64 or hex patterns)
JWT_FINDINGS=$(grep -nE \
  '(jwt|JWT|signing|SIGNING).*(secret|SECRET|key|KEY)\s*[:=]\s*["\x27][A-Za-z0-9+/=]{20,}' \
  "$FILE_PATH" 2>/dev/null | grep -v '\.env\|process\.env\|example\|placeholder\|FAKE_\|DUMMY_\|STUB_')

# Combine all findings
FINDINGS="${FINDINGS}${CONN_FINDINGS:+
$CONN_FINDINGS}${CLOUD_FINDINGS:+
$CLOUD_FINDINGS}${JWT_FINDINGS:+
$JWT_FINDINGS}"

if [ -n "$FINDINGS" ]; then
  echo "WARNING: Potential hardcoded secret detected in $FILE_PATH:" >&2
  echo "$FINDINGS" >&2
  echo "Use environment variables instead of hardcoding secrets." >&2
  # Exit 0 with warning (non-blocking) — shows warning but doesn't prevent the edit
  exit 0
fi

exit 0
