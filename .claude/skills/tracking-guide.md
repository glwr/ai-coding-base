# Tracking Guide

> Shared reference for all skills that create or update tracked items. NOT an always-loaded rule — read on demand.

## Variant Detection

Read the `Tracking` field from `CLAUDE.md` (Tech Stack section):
- `File-based` or `_TBD_` → Use **File-based** instructions below
- `GitHub Issues` → Use **GitHub Issues** instructions below

---

## Linking: Commits, Branches, and PRs (GitHub Issues variant)

**CRITICAL:** Every commit, branch, and PR MUST reference the related issue number. This creates automatic traceability in GitHub.

### Branch Naming
Create branches that reference the issue number:
```
feat/PROJ-1-feature-name      # for features (issue #3)
fix/BUG-5-login-crash          # for bugs (issue #12)
task/TASK-2-setup-ci           # for tasks (issue #7)
```

### Commit Messages
Always include the GitHub issue number in commits:
```
feat(PROJ-1): add user registration form (#3)
fix(BUG-5): resolve login crash on empty email (#12)
refactor(PROJ-2): extract validation logic (#5)
```
- The `#N` at the end links the commit to issue N in GitHub
- Use the project ID (PROJ-X, BUG-X, TASK-X) AND the GitHub issue number

### Pull Requests
Link PRs to issues using closing keywords in the PR body:
```
Closes #3
Fixes #12
Resolves #7
```
- This automatically closes the issue when the PR is merged
- For partial work (issue stays open): use `Related to #3` instead

### How to Find the Issue Number
```bash
gh issue list --label "type:feature" --search "PROJ-1" --json number,title
```

---

## GitHub Issue Lifecycle (GitHub Issues variant only)

Each skill progressively updates the GitHub Issue body as work progresses. This keeps issues as a living document — not a stale snapshot from requirements.

### Per-Skill Updates — Features

| Skill | Issue Body Update |
|-------|------------------|
| `/requirements` | Create issue with full spec (user stories, ACs, tech notes) |
| `/architecture` | Add or update Tech Design section in the issue body |
| `/frontend` / `/backend` | Update Tech Notes if implementation differs from design |
| `/qa` | Add QA Results section (pass/fail, bugs found) |
| `/security` | Add Security Audit section (findings summary, report link) |
| `/release` | Final update: check all AC/story checkboxes, add implementation notes, close issue |

### Per-Skill Updates — Bugs and Tasks

| Step | Issue Body Update |
|------|------------------|
| Creation / Reopen | Create or reopen issue with description, steps to reproduce (bugs), scope (tasks) |
| `/frontend` / `/backend` | Add comment with fix details, files changed |
| `/qa` | Add comment with verification result (pass/fail, regression check) |
| `/security` | Add comment with security impact assessment (if applicable) |
| `/release` | Close issue with summary comment of what was fixed/done |

### Why Every Skill Updates the Issue Body
GitHub Issues are the primary view for the team. Feature specs and backlog files (`.md` files) are the detailed source of truth, but the issue body/comments must stay current so anyone can check status without opening the repo.

### What "Final Update" Means at `/release`
Before closing an issue at release time:
- Check all user story checkboxes as completed
- Check all AC checkboxes
- Update Tech Notes with actual implementation (remove speculation)
- Add "Implementation Notes" section with key decisions or surprises
- Add "Files Changed" section listing major files
- Remove any outdated information

---

## Operations

### Create Feature

**File-based:**
1. Determine next ID from `features/INDEX.md` → "Next Available ID: PROJ-X"
2. Create feature spec `features/PROJ-X-feature-name.md`
3. Add row to Features table in `features/INDEX.md`
4. Increment "Next Available ID" counter

**GitHub Issues:**
1. Determine next ID from `features/INDEX.md` → "Next Available ID: PROJ-X"
2. Create feature spec `features/PROJ-X-feature-name.md`
3. Create GitHub issue with full content from the feature spec:
   ```bash
   gh issue create --title "PROJ-X: [feature name]" --label "type:feature,priority:pX,status:planned" --milestone "vX.Y" --body "$(cat <<'EOF'
   ## Description
   [Brief description of the feature and why it matters]

   ## User Stories
   - [ ] As a [user], I want to [action] so that [goal]
   - [ ] ...

   ## Acceptance Criteria
   - [ ] AC-1: [criterion]
   - [ ] AC-2: [criterion]
   - [ ] ...

   ## Tech Notes
   [Key technical decisions, constraints, or dependencies — if known]

   ---
   📄 Full spec: `features/PROJ-X-feature-name.md`
   EOF
   )"
   ```
   Populate each section from the feature spec. The issue should be self-contained — readers should not need to open the spec file to understand the feature.
4. Add row to Features table in `features/INDEX.md` (include issue number)
5. Increment "Next Available ID" counter
6. If the feature has user stories, create sub-issues (see below)

### Create User Stories as Sub-Issues

**File-based:**
User stories are listed in the feature spec file — no separate tracking.

**GitHub Issues:**
After creating the parent feature issue, create sub-issues for each user story:
```bash
gh issue create --title "Story: [user story title]" --label "type:story,status:planned" --body "$(cat <<'EOF'
**Parent:** PROJ-X (#N)

As a [user], I want to [action] so that [goal].

## Acceptance Criteria
- [ ] AC-1: [criterion]
- [ ] AC-2: [criterion]

## Notes
[Implementation hints, edge cases, or constraints — if any]
EOF
)"
```
Then link as sub-issue to the parent:
```bash
gh issue edit <parent-number> --add-sub-issue <story-number>
```

---

### Update Feature Status

**File-based:**
Update the feature's row in `features/INDEX.md` Features table. Valid statuses: Planned, Ready, In Progress, In Review, Done, Deployed, Blocked.

**GitHub Issues:**
1. Find the issue number: `gh issue list --label "type:feature" --search "PROJ-X" --json number,title`
2. Update labels: `gh issue edit <number> --remove-label "status:planned" --add-label "status:in-progress"`
3. Update `features/INDEX.md` as local mirror (keep in sync)

---

### Create Bug

**File-based:**
1. Determine next bug ID from `features/INDEX.md` → "Next Bug ID: BUG-X"
2. Create `backlog/BUG-X-short-name.md` from `backlog/bug-template.md`
3. Add row to Backlog table in `features/INDEX.md`
4. Increment "Next Bug ID" counter

**GitHub Issues:**
1. Determine next bug ID from `features/INDEX.md` → "Next Bug ID: BUG-X"
2. Create issue:
   ```bash
   gh issue create --title "BUG-X: [title]" --label "type:bug,priority:pX,status:open" --milestone "vX.Y" --body "[description]

   **Steps to reproduce:**
   1. ...

   **Expected:** ...
   **Actual:** ...

   Related feature: PROJ-Y (#N)"
   ```
3. Also create the local file `backlog/BUG-X-short-name.md` for detailed tracking
4. Add row to Backlog table in `features/INDEX.md` with issue link
5. Increment "Next Bug ID" counter

---

### Create Task

**File-based:**
1. Determine next task ID from `features/INDEX.md` → "Next Task ID: TASK-X"
2. Create `backlog/TASK-X-short-name.md` from `backlog/task-template.md`
3. Add row to Backlog table in `features/INDEX.md`
4. Increment "Next Task ID" counter

**GitHub Issues:**
1. Determine next task ID from `features/INDEX.md` → "Next Task ID: TASK-X"
2. Create issue with full context:
   ```bash
   gh issue create --title "TASK-X: [title]" --label "type:task,priority:pX,status:open" --milestone "vX.Y" --body "$(cat <<'EOF'
   ## Description
   [What needs to be done and why]

   ## Details
   - [Specific steps, files to change, or technical approach]

   ## Related
   - Feature: PROJ-Y (#N) _(if applicable)_
   EOF
   )"
   ```
3. Also create the local file `backlog/TASK-X-short-name.md` for detailed tracking
4. Add row to Backlog table in `features/INDEX.md` with issue link
5. Increment "Next Task ID" counter

---

### Update Milestone

**File-based:**
Update the milestone status in `docs/PRD.md` Milestones table and the milestone header in `features/INDEX.md`.

**GitHub Issues:**
1. Update milestone: `gh api repos/{owner}/{repo}/milestones/{number} -f state="closed"` (or update due date, description)
2. Update `docs/PRD.md` Milestones table to match
3. Update `features/INDEX.md` milestone header to match

---

### Get Next Feature ID

Both variants: Read `features/INDEX.md` → "Next Available ID: PROJ-X" and use that number. After creating the feature, increment the counter.

---

### Close Bug/Task

**File-based:**
1. Update status in the backlog file header to `Closed` or `Fixed`
2. Update status in `features/INDEX.md` Backlog table

**GitHub Issues:**
1. Close the issue: `gh issue close <number> --reason completed`
2. Update the local backlog file status
3. Update `features/INDEX.md` Backlog table

---

### Reopen Bug/Task/Feature

Use this when a closed item needs rework (bug resurfaced, feature needs changes, task incomplete).

**File-based:**
1. Update status in the detail file header back to `Open` or `In Progress`
2. Add a new section to the detail file documenting why it was reopened and what changed
3. Update status in `features/INDEX.md` (Features table or Backlog table)

**GitHub Issues:**
1. Reopen the issue with context:
   ```bash
   gh issue reopen <number> --comment "Reopened: [reason — e.g., bug resurfaced after X, feature needs rework for Y]"
   ```
2. Update labels: `gh issue edit <number> --remove-label "status:closed" --add-label "status:open"`
3. Update the local detail file (add reopened context)
4. Update `features/INDEX.md` status back to Open/In Progress
5. New commits reference the same issue number: `fix(BUG-X): description (#N)`
6. When resolved again, close the issue with a summary of the additional fix

> **Prefer reopening over creating duplicates.** If the same bug, same feature area, or same task scope applies, reopen the existing item. Only create a new item if the scope is genuinely different.

---

## GitHub Issues: Label Set

Create these labels during project init (`/requirements` Init Mode, Phase 5b).
Run each command separately (no chaining).

### Type labels (what is it)
```bash
gh label create "type:feature" --color "0075ca" --description "Feature implementation"
gh label create "type:story" --color "a2eeef" --description "User story (sub-issue of a feature)"
gh label create "type:bug" --color "d73a4a" --description "Bug report"
gh label create "type:task" --color "d4c5f9" --description "Technical task"
gh label create "type:chore" --color "ededed" --description "Maintenance, dependencies, CI"
```

### Priority labels (how urgent)
```bash
gh label create "priority:critical" --color "b60205" --description "P0 - Must fix immediately"
gh label create "priority:high" --color "d93f0b" --description "P1 - Fix soon"
gh label create "priority:medium" --color "fbca04" --description "P2 - Normal priority"
gh label create "priority:low" --color "0e8a16" --description "P3 - Nice to have"
```

### Status labels (where in the workflow)
```bash
gh label create "status:planned" --color "e4e669" --description "Requirements written, not yet started"
gh label create "status:ready" --color "0e8a16" --description "Architecture done, ready for dev"
gh label create "status:in-progress" --color "1d76db" --description "Currently being built"
gh label create "status:in-review" --color "5319e7" --description "QA / code review in progress"
gh label create "status:done" --color "006b75" --description "Passed QA, ready for deploy"
gh label create "status:deployed" --color "0e8a16" --description "Live in production"
gh label create "status:blocked" --color "b60205" --description "Waiting on a dependency"
```

### Area labels (which part — create as needed for your project)
```bash
gh label create "area:frontend" --color "c5def5" --description "Frontend / UI"
gh label create "area:backend" --color "bfdadc" --description "Backend / API"
gh label create "area:infra" --color "d4c5f9" --description "Infrastructure / CI/CD"
gh label create "area:docs" --color "fef2c0" --description "Documentation"
```

### Effort labels (how big — optional)
```bash
gh label create "effort:small" --color "0e8a16" --description "< 1 day"
gh label create "effort:medium" --color "fbca04" --description "1-3 days"
gh label create "effort:large" --color "d93f0b" --description "3+ days"
```

### Cleanup: Remove GitHub default labels
```bash
gh label delete "bug" --yes
gh label delete "documentation" --yes
gh label delete "duplicate" --yes
gh label delete "enhancement" --yes
gh label delete "good first issue" --yes
gh label delete "help wanted" --yes
gh label delete "invalid" --yes
gh label delete "question" --yes
gh label delete "wontfix" --yes
```

## GitHub Issues: Milestone Creation

```bash
gh api repos/{owner}/{repo}/milestones -f title="v1.0" -f description="MVP Release" -f due_on="YYYY-MM-DDT00:00:00Z"
```

## Labeling Rules

- **Max 3 labels per issue:** one `type:`, one `priority:`, one `status:`
- `area:` and `effort:` are optional extras — use when helpful, skip when obvious
- Every issue MUST have a `type:` label
- Every issue MUST have a `status:` label
- Update `status:` label whenever work progresses (don't leave stale statuses)
- An issue should only have ONE label per category (never two `status:` labels)
