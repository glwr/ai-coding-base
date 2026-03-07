# General Project Rules

## Workflow Awareness

At the start of every task, detect the project context by reading `CLAUDE.md`:
- **Platform** (Web, Apple, Cross-platform) → determines which skills apply
- **Tracking** (File-based, GitHub Issues) → determines how to track work

### Mandatory skill sequences (in order, do not skip)

**Web:** `/requirements` → `/architecture` → `/frontend` → `/backend` → `/qa` → `/security` → `/release`
**Apple:** `/requirements` → `/architecture` → `/apple-ui` → `/apple-data` → `/qa` → `/security` → `/hig-review` → `/apple-build` → `/release` → `/appstore`

### Available anytime (not sequential)

`/track` · `/remember` · `/help`

### Enforcement rules
- **Never skip steps.** Each skill has prerequisites. Check the feature spec and INDEX.md to see what has been done:
  - No `/frontend` or `/apple-ui` without a Tech Design section in the feature spec (added by `/architecture`)
  - No `/backend` or `/apple-data` without UI implementation (or explicit skip by user)
  - No `/qa` without implementation done
  - No `/release` without QA passed (no Critical/High bugs)
  - No `/security` without implementation to audit
- **If a prerequisite is missing:** Tell the user what's missing and suggest the correct skill. Example: "This feature doesn't have a tech design yet. Run `/architecture features/PROJ-X-name.md` first."
- **If the user asks to do something out of order:** Warn them once, explain the risk, but allow it if they explicitly confirm
- **When the user gives a general task** (e.g., "build feature X"): Check INDEX.md for the feature's current status and suggest the correct next skill — don't just start coding
- **When the project is not initialized** (PRD is empty template): Direct to `/requirements` first
- **Platform-specific skills are NOT interchangeable:** Never use `/frontend` for Apple projects or `/apple-ui` for web projects

## Feature Tracking
- All features are tracked in `features/INDEX.md` - read it before starting any work
- Feature specs live in `features/PROJ-X-feature-name.md`
- Feature IDs are sequential: check INDEX.md for the next available number
- One feature per spec file (Single Responsibility)
- Never combine multiple independent functionalities in one spec

## Language
- ALL written output must be in English: code, comments, commits, docs, specs, context entries, UI text
- No exceptions — even if the user writes in another language, all artifacts are English

## Bash Commands
- NEVER chain shell commands with `&&`, `||`, or `;` — permission checks may reject chained commands
- Run each command in a separate Bash call instead
- Parallel independent calls (multiple Bash tool uses in one message) are fine and encouraged

## Git Conventions
- Commit format: `type(PROJ-X): description` (also `type(BUG-X):` or `type(TASK-X):`)
- Types: feat, fix, refactor, test, docs, deploy, chore, security
- **GitHub Issues linking (when Tracking = GitHub Issues):**
  - Append `(#N)` with the GitHub issue number to every commit: `feat(PROJ-1): add login form (#3)`
  - Branch names reference the issue: `feat/PROJ-1-login-form`
  - PR bodies use closing keywords: `Closes #3` (auto-closes on merge) or `Related to #3` (stays open)
  - Look up issue numbers via: `gh issue list --search "PROJ-X" --json number,title`
- Check existing features before creating new ones: `ls features/ | grep PROJ-`
- Check existing components before building (e.g. `git ls-files src/components/`)
- Check existing APIs before building (e.g. `git ls-files src/app/api/` or equivalent)

## Human-in-the-Loop
- Always ask for user approval before finalizing deliverables
- Present options using clear choices rather than open-ended questions
- Never proceed to the next workflow phase without user confirmation

## Status Updates
- Read the `Tracking` field from `CLAUDE.md` Tech Stack to determine the variant: `File-based` or `GitHub Issues`
- For all tracking operations (status updates, bug/task creation, milestones), read `.claude/skills/tracking-guide.md` and follow the matching variant
- **File-based:** All tracking happens in markdown files only (`features/INDEX.md`, `backlog/`, feature specs)
- **GitHub Issues:** Create/update GitHub Issues via `gh` CLI AND keep `features/INDEX.md` as a local mirror in sync
- Always update `features/INDEX.md` when feature status changes (both variants)
- Update the feature spec header status field
- Valid feature statuses: Planned, Ready, In Progress, In Review, Done, Deployed, Blocked
- Valid backlog statuses: Open, In Progress, Fixed/Done, Closed

## Context Management
- All skills read relevant `context/` files before starting work
- Skills write context updates after completing work (with user approval)
- Decisions are append-only (supersede, never delete)
- Patterns and learnings can be updated/removed with user approval
- After context compaction, re-read `context/` files to restore project knowledge
- Before implementing anything, check `context/patterns.md` for established approaches
- Use `/remember` for ad-hoc entries outside a skill's workflow
- When context files exceed 150 lines, suggest `/remember review` to archive stale entries
- Superseded decisions are moved to `context/archive/`
- Resolved learnings (with regression tests in place) can be removed

## File Handling
- ALWAYS read a file before modifying it - never assume contents from memory
- After context compaction, re-read files before continuing work
- When unsure about current project state, read `features/INDEX.md` first
- Run `git diff` to verify what has already been changed in this session
- Never guess at import paths, component names, or API routes - verify by reading

## Tracking Verification (every skill, before commit)
Every skill MUST verify tracking before committing. Read the `Tracking` field from `CLAUDE.md`:

**Both variants:**
- Feature status in `features/INDEX.md` matches the feature spec header
- Feature spec has been updated with the skill's output section

**GitHub Issues only (additional checks):**
- Commit message includes the GitHub issue number: `type(PROJ-X): description (#N)`
- Branch name follows convention: `feat/PROJ-X-name`, `fix/BUG-X-name`, `task/TASK-X-name`
- If the feature status changed, update the GitHub Issue label too: `gh issue edit <N> --remove-label "status:old" --add-label "status:new"`
- If work is done on a PR, the PR body references the issue: `Closes #N`
- Look up issue numbers via: `gh issue list --search "PROJ-X" --json number,title`

If any tracking is incomplete, fix it before committing. If the issue number is unknown, look it up or ask the user.

## Handoffs Between Skills
- After completing a skill, suggest the next skill to the user
- Format: "Next step: Run `/skillname` to [action]"
- Handoffs are always user-initiated, never automatic
- When completing a skill, write context updates BEFORE suggesting the next skill
