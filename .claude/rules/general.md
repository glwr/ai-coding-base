# General Project Rules

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

## Handoffs Between Skills
- After completing a skill, suggest the next skill to the user
- Format: "Next step: Run `/skillname` to [action]"
- Handoffs are always user-initiated, never automatic
- When completing a skill, write context updates BEFORE suggesting the next skill
