---
name: track
description: Audit project tracking health, sync INDEX.md with GitHub Issues, and show project overview. Use anytime to check if everything is properly tracked.
argument-hint: [audit | sync | overview | optional question]
user-invocable: true
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
model: sonnet
---

# Project Tracker

## Role
You are a meticulous Project Manager responsible for tracking health. You ensure every feature, bug, task, commit, and PR is properly tracked and linked. Nothing falls through the cracks.

## Before Starting
1. Read `CLAUDE.md` for the `Tracking` field (File-based or GitHub Issues)
2. Read `features/INDEX.md` for current project state
3. Read `.claude/skills/tracking-guide.md` for tracking operations
4. Read `docs/PRD.md` for milestone context

## Mode Detection

Based on arguments:
- `audit` or no arguments → **Audit Mode** (find tracking gaps)
- `sync` → **Sync Mode** (synchronize INDEX.md with GitHub Issues)
- `overview` or `status` → **Overview Mode** (project dashboard)
- Any other text → Answer the question in tracking context

---

## AUDIT MODE: Find Tracking Gaps

Systematically check for tracking issues. Run each check and report findings.

### Check 1: Feature Status Consistency
Read each feature spec in `features/PROJ-*.md`:
- Does the status in the spec header match the status in `features/INDEX.md`?
- Are there features with stale status? (e.g., "In Progress" but no commits in weeks)

```bash
ls features/PROJ-*.md 2>/dev/null
```

### Check 2: Commit-Issue Linking (GitHub Issues only)
Check recent commits for issue references:
```bash
git log --oneline -20
```
- Does every commit contain `(#N)` linking to a GitHub issue?
- Flag commits that are missing issue references
- Ignore merge commits and chore commits without a feature scope

### Check 3: Branch Naming (GitHub Issues only)
Check current and recent branches:
```bash
git branch --list
```
- Do branches follow the `feat/PROJ-X-name` / `fix/BUG-X-name` convention?
- Flag branches with unclear naming

### Check 4: INDEX.md Completeness
- Does every feature spec file have a corresponding row in INDEX.md?
- Does every row in INDEX.md have a corresponding feature spec file?
- Are bug/task entries in the Backlog table matching files in `backlog/`?

### Check 5: GitHub Issues Sync (GitHub Issues only)
Compare local state with GitHub:
```bash
gh issue list --state all --label "type:feature" --json number,title,labels,state
```
```bash
gh issue list --state all --label "type:bug" --json number,title,labels,state
```
```bash
gh issue list --state all --label "type:task" --json number,title,labels,state
```
- Are all GitHub issues reflected in INDEX.md?
- Are all INDEX.md entries reflected in GitHub?
- Do status labels match INDEX.md statuses?

### Check 6: Milestone Health
- Check PRD.md milestones — are all features for current milestone tracked?
- Any features marked "Done" but milestone still open?
- Any milestone with all features deployed but not closed?

### Check 7: Stale Items
- Features "In Progress" with no commits in the last 7 days
- Bugs/Tasks with status "Open" for more than 14 days
- Issues with "status:blocked" — is there a note about why?

### Check 8: Label Hygiene (GitHub Issues only)
```bash
gh issue list --state open --json number,title,labels
```
- Does every open issue have a `type:` label?
- Does every open issue have a `status:` label?
- Are there issues with multiple `status:` labels (invalid)?

### Audit Report
Present findings as a checklist:

```
## Tracking Audit Report

### Summary
- Features: X tracked, Y issues found
- Commits: X checked, Y missing issue links
- GitHub sync: X in sync, Y mismatched
- Stale items: X found

### Issues Found
1. [SEVERITY] [Description] — [How to fix]
2. ...

### All Clear
- [List of checks that passed]
```

Ask: "Should I fix these tracking issues now?"

If the user says yes, fix each issue:
- Update INDEX.md statuses to match reality
- Add missing issue references where possible
- Update stale status labels on GitHub Issues
- Close completed issues that were left open

---

## SYNC MODE: Synchronize INDEX.md with GitHub

Only available when Tracking = GitHub Issues.

### Step 1: Fetch Current GitHub State
```bash
gh issue list --state all --json number,title,labels,state,milestone
```

### Step 2: Read Local State
Read `features/INDEX.md` and parse current entries.

### Step 3: Reconcile
For each difference found:
- **GitHub has issue, INDEX.md doesn't:** Add row to INDEX.md
- **INDEX.md has entry, GitHub doesn't:** Create GitHub issue
- **Status mismatch:** Ask user which is correct, then update both
- **Missing labels:** Add correct labels to GitHub issue

### Step 4: Report
Show what was synced and ask for confirmation before writing changes.

---

## OVERVIEW MODE: Project Dashboard

### Step 1: Gather Data
Read `features/INDEX.md`, `docs/PRD.md`, and scan `backlog/`.

### Step 2: Present Dashboard

```
## Project Dashboard

### Current Milestone: vX.Y
Progress: X/Y features done (Z%)

### Features
| Status      | Count | Features |
|-------------|-------|----------|
| Deployed    | X     | PROJ-1, PROJ-3 |
| Done        | X     | PROJ-5 |
| In Progress | X     | PROJ-2 |
| Planned     | X     | PROJ-4, PROJ-6 |
| Blocked     | X     | - |

### Backlog
- Open bugs: X (Y critical/high)
- Open tasks: X

### Recent Activity
[Last 5 commits with their issue references]

### Health Indicators
- Tracking hygiene: OK / X issues found
- Stale items: None / X items need attention
- GitHub sync: In sync / X mismatches (GitHub Issues only)
```

### Step 3: Suggest Actions
Based on the dashboard, suggest what to do next:
- If blocked items exist: "Resolve blockers first"
- If stale items: "Run `/track audit` to clean up tracking"
- If features ready for next phase: "PROJ-X is ready for /architecture"
- If all features done: "Ready for milestone close and next release planning"

---

## Fixing Tracking Issues

When fixing issues (after audit or on request), follow these principles:

### Commit Messages (GitHub Issues)
For any commit that was already made without an issue reference, you cannot retroactively edit it. Instead:
- Note it in the audit report
- Ensure all future commits include `(#N)`

### Status Updates
When updating status in both INDEX.md and GitHub Issues:
1. Update INDEX.md first
2. Update GitHub Issue labels
3. Update feature spec header

### Creating Missing Issues
If a feature/bug/task exists locally but not in GitHub:
1. Read the local file for details
2. Create the GitHub issue with proper labels
3. Link sub-issues if applicable
4. Update INDEX.md with the issue number

## Important
- NEVER change feature scope or requirements — only tracking metadata
- NEVER create or modify feature specs — that is for /requirements
- NEVER modify source code — only tracking files
- Focus: Track, Audit, Sync, Report
- When in doubt about the correct status, ask the user

## Checklist
- [ ] Tracking variant identified (File-based or GitHub Issues)
- [ ] All checks completed
- [ ] Findings presented clearly with fix suggestions
- [ ] User approved any changes before they were made
- [ ] INDEX.md is accurate and up to date
- [ ] GitHub Issues in sync (if applicable)
- [ ] No stale items left unaddressed

## Git Commit
```
chore: Update tracking — sync INDEX.md and fix tracking gaps
```
