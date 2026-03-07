#!/usr/bin/env bash
set -euo pipefail

# sync-base.sh — Sync ai-coding-base into a target project
#
# Usage:
#   /path/to/ai-coding-base/sync-base.sh [target-dir]
#   (defaults to current directory)
#
# What it syncs (base files):
#   .claude/skills/       All skill definitions
#   .claude/agents/       All agent definitions
#   .claude/rules/        All rule files
#   .claude/hooks/        Hook scripts
#   .claude/settings.json Base permission settings
#   backlog/bug-template.md, task-template.md
#   docs/production/      Production guide templates
#   sync-base.sh          This script itself
#
# What it NEVER touches (project-specific):
#   CLAUDE.md             Tech stack, build commands, project config
#   .claude/settings.local.json  Local overrides
#   features/             Feature specs, INDEX.md (after init)
#   context/              Decisions, patterns, learnings, stack
#   docs/PRD.md           Product requirements (after init)
#   docs/architecture.md  System architecture
#   docs/api.md, docs/development.md, docs/deployment.md, docs/design-system.md
#   backlog/*.md          Actual bug/task files (not templates)
#   reports/              Security audit reports
#   src/, apps/, packages/ Source code

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-.}"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

if [ "$SCRIPT_DIR" = "$TARGET_DIR" ]; then
  echo "Error: Target directory is the same as source. Run this from your project directory."
  echo "Usage: /path/to/ai-coding-base/sync-base.sh [target-dir]"
  exit 1
fi

# Track version
BASE_VERSION=$(cd "$SCRIPT_DIR" && git rev-parse --short HEAD 2>/dev/null || echo "unknown")
BASE_DATE=$(date +%Y-%m-%d)

echo "=== ai-coding-base sync ==="
echo "Source:  $SCRIPT_DIR ($BASE_VERSION)"
echo "Target:  $TARGET_DIR"
echo ""

# --- Sync functions ---

sync_dir() {
  local src="$1"
  local dst="$2"
  local label="$3"

  if [ ! -d "$src" ]; then
    return
  fi

  mkdir -p "$dst"

  local changed=0
  while IFS= read -r -d '' file; do
    local rel="${file#$src/}"
    local target_file="$dst/$rel"
    mkdir -p "$(dirname "$target_file")"

    if [ ! -f "$target_file" ]; then
      cp "$file" "$target_file"
      echo "  + $label/$rel (new)"
      changed=$((changed + 1))
    elif ! diff -q "$file" "$target_file" > /dev/null 2>&1; then
      cp "$file" "$target_file"
      echo "  ~ $label/$rel (updated)"
      changed=$((changed + 1))
    fi
  done < <(find "$src" -type f -not -name '.DS_Store' -print0)

  if [ "$changed" -eq 0 ]; then
    echo "  = $label/ (no changes)"
  fi
}

sync_file() {
  local src="$1"
  local dst="$2"
  local label="$3"

  if [ ! -f "$src" ]; then
    return
  fi

  mkdir -p "$(dirname "$dst")"

  if [ ! -f "$dst" ]; then
    cp "$src" "$dst"
    echo "  + $label (new)"
  elif ! diff -q "$src" "$dst" > /dev/null 2>&1; then
    cp "$src" "$dst"
    echo "  ~ $label (updated)"
  else
    echo "  = $label (no changes)"
  fi
}

init_file() {
  local src="$1"
  local dst="$2"
  local label="$3"

  if [ ! -f "$dst" ]; then
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo "  + $label (initialized)"
  else
    echo "  - $label (exists, skipped)"
  fi
}

# --- Base files (always synced) ---

echo "Syncing base files..."
sync_dir "$SCRIPT_DIR/.claude/skills" "$TARGET_DIR/.claude/skills" ".claude/skills"
sync_dir "$SCRIPT_DIR/.claude/agents" "$TARGET_DIR/.claude/agents" ".claude/agents"
sync_dir "$SCRIPT_DIR/.claude/rules"  "$TARGET_DIR/.claude/rules"  ".claude/rules"
sync_dir "$SCRIPT_DIR/.claude/hooks"  "$TARGET_DIR/.claude/hooks"  ".claude/hooks"
sync_file "$SCRIPT_DIR/.claude/settings.json" "$TARGET_DIR/.claude/settings.json" ".claude/settings.json"
sync_dir "$SCRIPT_DIR/docs/production" "$TARGET_DIR/docs/production" "docs/production"

# Backlog templates only (not actual backlog files)
sync_file "$SCRIPT_DIR/backlog/bug-template.md"  "$TARGET_DIR/backlog/bug-template.md"  "backlog/bug-template.md"
sync_file "$SCRIPT_DIR/backlog/task-template.md"  "$TARGET_DIR/backlog/task-template.md"  "backlog/task-template.md"

# Sync this script itself
sync_file "$SCRIPT_DIR/sync-base.sh" "$TARGET_DIR/sync-base.sh" "sync-base.sh"

# --- Project-specific files (only created if missing, never overwritten) ---

echo ""
echo "Checking project scaffolding..."
init_file "$SCRIPT_DIR/CLAUDE.md"          "$TARGET_DIR/CLAUDE.md"          "CLAUDE.md"
init_file "$SCRIPT_DIR/docs/PRD.md"        "$TARGET_DIR/docs/PRD.md"        "docs/PRD.md"
init_file "$SCRIPT_DIR/features/INDEX.md"  "$TARGET_DIR/features/INDEX.md"  "features/INDEX.md"
init_file "$SCRIPT_DIR/.claude/settings.local.json.example" "$TARGET_DIR/.claude/settings.local.json.example" ".claude/settings.local.json.example"

# Ensure directories exist
for dir in context backlog reports/security; do
  if [ ! -d "$TARGET_DIR/$dir" ]; then
    mkdir -p "$TARGET_DIR/$dir"
    echo "  + $dir/ (created)"
  fi
done

# Ensure .gitkeep files
for dir in context backlog reports/security; do
  if [ ! -f "$TARGET_DIR/$dir/.gitkeep" ] && [ -z "$(ls -A "$TARGET_DIR/$dir" 2>/dev/null)" ]; then
    touch "$TARGET_DIR/$dir/.gitkeep"
  fi
done

# --- Write version marker ---

cat > "$TARGET_DIR/.claude/.base-version" << EOF
base-repo: ai-coding-base
version: $BASE_VERSION
synced: $BASE_DATE
EOF
echo ""
echo "  Version: $BASE_VERSION (synced $BASE_DATE)"

# --- Summary ---

echo ""
echo "=== Sync complete ==="
echo ""
echo "Next steps:"
echo "  1. Review changes: cd $TARGET_DIR && git diff"
echo "  2. Fill in CLAUDE.md Tech Stack (if new project)"
echo "  3. Set Tracking field: 'File-based' or 'GitHub Issues'"
echo "  4. Run /requirements to initialize your project"
