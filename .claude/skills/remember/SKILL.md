---
name: remember
description: Save decisions, patterns, or learnings to project context. Search and review existing context entries.
argument-hint: [what to remember, or "search <query>", or "review"]
user-invocable: true
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
model: sonnet
---

# Memory Manager

## Role
You manage the project's shared context in `context/`. You help the team capture decisions, patterns, and learnings so knowledge persists across sessions.

## Before Starting
1. Read `context/decisions.md`, `context/patterns.md`, `context/learnings.md`, `context/stack.md`
2. Read `features/INDEX.md` for current project state
3. Determine mode from the user's argument

## Modes

### Mode 1: ADD (default)
User provides something to remember. Examples:
- `/remember We chose Zustand over Redux because the app is small`
- `/remember The Stripe webhook needs the raw body, not parsed JSON`
- `/remember Pattern: all modals use DialogPrimitive from the component library`

**Workflow:**
1. Parse the user's input to determine:
   - **Type:** Decision, Pattern, Learning, or Stack detail
   - **Related feature:** PROJ-X (if applicable, ask if unclear)
   - **Category:** (for patterns: Components, API, Database, State, Error Handling, Testing)

2. If the type is ambiguous, ask:
   > "Should I save this as:"
   > 1. **Decision** — architectural/design choice with rationale
   > 2. **Pattern** — reusable code convention to follow
   > 3. **Learning** — gotcha/pitfall to avoid
   > 4. **Stack detail** — tech/config/infrastructure info

   Use `AskUserQuestion` with clear options.

3. Draft the entry in the correct format:
   ```markdown
   ### [Short Title]
   - **Date:** YYYY-MM-DD
   - **Feature:** PROJ-X (or "General")
   - **Skill:** /remember
   - **[Decision/Pattern/Learning]:** [Description]
   - **Rationale:** [Why this matters]
   ```

4. Show the draft to the user for approval:
   > "I'll add this to `context/[file].md`:"
   > [show formatted entry]
   > Approve?

5. After approval:
   - For `decisions.md` and `learnings.md`: Prepend entry below the `<!-- New ... -->` marker (newest first)
   - For `patterns.md`: Add entry under the matching category heading
   - For `stack.md`: Add entry under the matching section heading

### Mode 2: SEARCH
User wants to find existing context. Examples:
- `/remember search authentication`
- `/remember search PROJ-3`

**Workflow:**
1. Search across all four context files using Grep
2. Present matching entries grouped by file
3. If no matches, say so and suggest related terms

### Mode 3: REVIEW
User wants to review and clean up context. Examples:
- `/remember review`
- `/remember review decisions`

**Workflow:**
1. Read the specified file (or all files if none specified)
2. Check file sizes: `wc -l context/*.md`
3. Present a summary:
   - Total entries per file
   - Lines per file (flag files >150 lines as needing cleanup)
   - Entries by feature
   - Entries by date range
4. Ask if the user wants to:
   - Mark any decisions as superseded
   - Update outdated patterns
   - Remove resolved learnings
   - **Archive stale entries** (move to `context/archive/`)
5. Apply changes only after user approval

**Archiving (when files exceed 150 lines):**
- Superseded decisions → move to `context/archive/decisions-archive.md`
- Resolved learnings (bug fixed + regression test exists) → move to `context/archive/learnings-archive.md`
- Outdated patterns (replaced by newer patterns) → move to `context/archive/patterns-archive.md`
- Archive files use the same entry format, prefixed with archive date

## Entry Format Rules
- Keep titles short (max 10 words)
- Keep descriptions factual and specific
- Always include rationale (WHY, not just WHAT)
- Reference specific files/paths when relevant
- Use feature IDs (PROJ-X) when the entry relates to a feature

## Important
- NEVER delete entries without user approval
- Decisions are append-only (supersede, never delete)
- Patterns can be updated if conventions change (with user approval)
- Learnings can be removed if the underlying issue is permanently fixed
- Always show the user what will be written before writing

## Git Commit
```
docs: Add [type] to project context — [short title]
```

## Handoff
After saving:
> "Context saved to `context/[file].md`. This will be available to all skills in future sessions."
