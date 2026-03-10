# General Project Rules

## Workflow Awareness

At the start of every task, detect the project context by reading `CLAUDE.md`:
- **Platform** (Web, Apple, Cross-platform) → determines which skills apply
- **Tracking** (File-based, GitHub Issues) → determines how to track work

### Mandatory skill sequences (in order, do not skip)

**Features (new functionality):**
- **Web:** `/requirements` → `/architecture` → `/frontend` → `/backend` → `/design-review` → `/simplify` → `/qa` → `/security` → `/release`
- **Apple:** `/requirements` → `/architecture` → `/apple-ui` → `/apple-data` → `/design-review` → `/simplify` → `/qa` → `/security` → `/hig-review` → `/apple-build` → `/release` → `/appstore`

**Bugs and Tasks (fixes, refactors, chores):**
- Create/reopen tracking (detail file + INDEX.md + GitHub Issue) → implement fix → `/simplify` → `/qa` → `/security` → `/release`
- Implementation uses the appropriate skill (`/frontend`, `/backend`, `/apple-ui`, `/apple-data`) — never raw code edits without a skill
- `/simplify` is optional for small fixes but recommended
- `/qa` and `/security` are NEVER optional — even for one-line fixes

### Available anytime (not sequential)

`/track` · `/remember` · `/help` · `/design-review`

### No Code Without Tracking (hard rule)

**NEVER write or modify code without an active tracked work item.** This applies to ALL code changes — features, bug fixes, tasks, refactors, chores. No exceptions.

When the user requests work, BEFORE writing any code:

1. **Classify the work item** — determine the type automatically:
   - **Feature (PROJ-X):** New functionality, new UI, new API endpoint → use `/requirements`
   - **Bug (BUG-X):** Something is broken, incorrect behavior, regression → create bug entry
   - **Task (TASK-X):** Refactor, dependency update, config change, tech debt, chore → create task entry

2. **Check if a tracked item already exists** (including closed/resolved items):
   - Search `features/INDEX.md` for matching features, bugs, or tasks (all statuses)
   - If Tracking = GitHub Issues: search both open AND closed issues:
     - `gh issue list --search "[keywords]" --json number,title,state`
     - `gh issue list --search "[keywords]" --state closed --json number,title,state`
   - **If an active item exists:** use it
   - **If a closed/resolved item matches** (same bug resurfaced, same feature needs rework, same task needs revisiting):
     - Reopen the existing item instead of creating a new one
     - Update the detail file with the new context (what changed, why it resurfaced)
     - Reopen the GitHub Issue: `gh issue reopen <number> --comment "Reopened: [reason]"`
     - Update status in `features/INDEX.md` back to Open/In Progress
     - Link new commits to the same issue number

3. **If no tracked item exists (and no closed item matches), create one FIRST:**
   - Read `.claude/skills/tracking-guide.md` for the correct procedure
   - **Features:** Run `/requirements` — never skip straight to coding
   - **Bugs:** Create `backlog/BUG-X-name.md` from template + add to INDEX.md + create GitHub Issue (if applicable)
   - **Tasks:** Create `backlog/TASK-X-name.md` from template + add to INDEX.md + create GitHub Issue (if applicable)
   - Tell the user what was created and why, then proceed

4. **Only then start the appropriate skill** for the actual work

> The user does NOT need to explicitly say "create an issue" — auto-detect and create it. The user DOES need to confirm before code is written.

### No Direct Code Edits (hard rule)

**ALL code changes MUST go through the appropriate skill** (`/frontend`, `/backend`, `/apple-ui`, `/apple-data`). Never use Edit/Write tools on source code files outside of a skill context.

If the user asks for a direct change (e.g., "change line 42 in app.ts", "fix this typo in the code"):
1. Classify it as Bug or Task (see above)
2. Create/reopen the tracking item
3. Use the appropriate skill to make the change
4. Run `/qa` and `/security` on the result

The ONLY code files exempt from this rule are:
- Configuration files (`.claude/`, `.github/`, `tsconfig.json`, `package.json`, etc.)
- Documentation files (`docs/`, `context/`, `features/`, `backlog/`, `reports/`)
- Build/tooling files that don't affect runtime behavior

### Enforcement rules
- **Never skip steps.** Each skill has prerequisites. Check the feature spec and INDEX.md to see what has been done:
  - No `/frontend` or `/apple-ui` without a Tech Design section in the feature spec (added by `/architecture`)
  - No `/backend` or `/apple-data` without UI implementation (or explicit skip by user)
  - No `/qa` without implementation done
  - No `/release` without QA passed (no Critical/High bugs)
  - No `/security` without implementation to audit
- **`/design-review` is optional but recommended** after `/frontend` or `/apple-ui`. Requires a running app (dev server or simulator). If skipped, proceed without warning
- **`/simplify` is optional but recommended.** If the user skips it, proceed to `/qa` without warning
- **Bug fixes, tasks, and refactors follow the same workflow.** Every work item needs its own tracked item and at least `/qa` and `/security` — no skipping for "small fixes"
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

## Skill Start Hygiene
At the start of every skill, check for stale tracking:
- Features at "Done" that should be "Deployed" (already pushed/released)
- Features at "In Review" with no active QA (stuck status)
- Open milestones where all features are already Deployed (should be closed)
- If stale items are found, fix them before starting the current task

## Tracking Verification (every skill, before commit)
Every skill MUST verify tracking before committing. Read the `Tracking` field from `CLAUDE.md`:

**Both variants:**
- [ ] A tracked work item exists for this change (PROJ-X, BUG-X, or TASK-X)
- [ ] Detail file exists (`features/PROJ-X-name.md` or `backlog/BUG-X-name.md` or `backlog/TASK-X-name.md`)
- [ ] Status in `features/INDEX.md` matches the detail file header
- [ ] Detail file has been updated with the skill's output section
- [ ] Commit message references the work item ID: `type(PROJ-X): description`

**GitHub Issues only (additional checks):**
- [ ] GitHub Issue exists for this work item
- [ ] Commit message includes the GitHub issue number: `type(PROJ-X): description (#N)`
- [ ] Branch name follows convention: `feat/PROJ-X-name`, `fix/BUG-X-name`, `task/TASK-X-name`
- [ ] GitHub Issue label matches current status: `gh issue edit <N> --remove-label "status:old" --add-label "status:new"`
- [ ] GitHub Issue body updated with this skill's output (see tracking-guide.md for per-skill details)
- [ ] If work is done on a PR, the PR body references the issue: `Closes #N`

Do NOT commit until all items pass. If the issue number is unknown, look it up or ask the user.

## Handoffs Between Skills
- After completing a skill, suggest the next skill to the user
- Format: "Next step: Run `/skillname` to [action]"
- Handoffs are always user-initiated, never automatic
- When completing a skill, write context updates BEFORE suggesting the next skill
