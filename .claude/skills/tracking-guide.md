# Tracking Guide

> Shared reference for all skills that create or update tracked items. NOT an always-loaded rule — read on demand.

## Variant Detection

Read the `Tracking` field from `CLAUDE.md` (Tech Stack section):
- `File-based` or `_TBD_` → Use **File-based** instructions below
- `GitHub Issues` → Use **GitHub Issues** instructions below

---

## Operations

### Update Feature Status

**File-based:**
Update the feature's row in `features/INDEX.md` Features table. Valid statuses: Planned, Ready, In Progress, In Review, Done, Deployed, Blocked.

**GitHub Issues:**
1. Find the issue number for the feature: `gh issue list --label "type:feature" --search "PROJ-X" --json number,title`
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
1. Create issue: `gh issue create --title "BUG-X: [title]" --label "type:bug,priority:pX,status:open" --milestone "vX.Y" --body "..."`
2. Also create the local file `backlog/BUG-X-short-name.md` for detailed tracking
3. Add row to Backlog table in `features/INDEX.md` with issue link
4. Increment "Next Bug ID" counter

---

### Create Task

**File-based:**
1. Determine next task ID from `features/INDEX.md` → "Next Task ID: TASK-X"
2. Create `backlog/TASK-X-short-name.md` from `backlog/task-template.md`
3. Add row to Backlog table in `features/INDEX.md`
4. Increment "Next Task ID" counter

**GitHub Issues:**
1. Create issue: `gh issue create --title "TASK-X: [title]" --label "type:task,priority:pX,status:open" --milestone "vX.Y" --body "..."`
2. Also create the local file `backlog/TASK-X-short-name.md` for detailed tracking
3. Add row to Backlog table in `features/INDEX.md` with issue link
4. Increment "Next Task ID" counter

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

## GitHub Issues: Label Set

Create these labels during project init (`/requirements` Init Mode, Phase 5b):

```bash
# Status labels
gh label create "status:planned" --color "e4e669" --description "Requirements written"
gh label create "status:ready" --color "0e8a16" --description "Architecture done, ready for dev"
gh label create "status:in-progress" --color "1d76db" --description "Currently being built"
gh label create "status:in-review" --color "5319e7" --description "QA testing in progress"
gh label create "status:done" --color "0e8a16" --description "Passed QA"
gh label create "status:deployed" --color "006b75" --description "Live in production"
gh label create "status:blocked" --color "b60205" --description "Blocked by dependency"

# Type labels
gh label create "type:feature" --color "a2eeef" --description "Feature implementation"
gh label create "type:bug" --color "d73a4a" --description "Bug report"
gh label create "type:task" --color "d4c5f9" --description "Technical task"

# Priority labels
gh label create "priority:p0" --color "b60205" --description "Critical - must fix now"
gh label create "priority:p1" --color "e4e669" --description "High - fix soon"
gh label create "priority:p2" --color "0e8a16" --description "Normal - fix when possible"
```

## GitHub Issues: Milestone Creation

```bash
gh api repos/{owner}/{repo}/milestones -f title="v1.0" -f description="MVP Release" -f due_on="YYYY-MM-DDT00:00:00Z"
```
