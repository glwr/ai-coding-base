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

## Git Conventions
- Commit format: `type(PROJ-X): description` (also `type(BUG-X):` or `type(TASK-X):`)
- Types: feat, fix, refactor, test, docs, deploy, chore, security
- Check existing features before creating new ones: `ls features/ | grep PROJ-`
- Check existing components before building (e.g. `git ls-files src/components/`)
- Check existing APIs before building (e.g. `git ls-files src/app/api/` or equivalent)

## Human-in-the-Loop
- Always ask for user approval before finalizing deliverables
- Present options using clear choices rather than open-ended questions
- Never proceed to the next workflow phase without user confirmation

## Status Updates
- Update `features/INDEX.md` when feature status changes
- Update the feature spec header status field
- Valid feature statuses: Planned, Ready, In Progress, In Review, Done, Deployed, Blocked
- Valid backlog statuses: Open, In Progress, Fixed/Done, Closed
- For all tracking operations (status updates, bug/task creation, milestones), read `.claude/skills/tracking-guide.md`

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
