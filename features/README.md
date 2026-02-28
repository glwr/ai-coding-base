# Feature Specifications

This folder contains detailed feature specs created by the Requirements Engineer.

## Naming Convention
`PROJ-X-feature-name.md`

Examples:
- `PROJ-1-user-authentication.md`
- `PROJ-2-kanban-board.md`
- `PROJ-3-file-attachments.md`

## What belongs in a Feature Spec?

### 1. User Stories
Describe what the user wants to do:
```markdown
As a [user type], I want to [action] so that [goal]
```

### 2. Acceptance Criteria
Concrete, testable criteria:
```markdown
- [ ] User can enter email + password
- [ ] Password must be at least 8 characters
- [ ] After registration, user is automatically logged in
```

### 3. Edge Cases
What happens in unexpected situations:
```markdown
- What happens with duplicate email?
- What happens on network error?
- What happens with concurrent edits?
```

### 4. Tech Design (by Solution Architect)
```markdown
## Database Schema
CREATE TABLE tasks (...);

## Component Architecture
ProjectDashboard
├── ProjectList
│   └── ProjectCard
```

### 5. QA Test Results (by QA Engineer)
At the end of the feature document, QA adds the test results:
```markdown
---

## QA Test Results

**Tested:** 2026-01-12
**App URL:** http://localhost:3000

### Acceptance Criteria Status
- [x] AC-1: User can enter email + password
- [x] AC-2: Password at least 8 characters
- [ ] BUG: Duplicate email is not rejected

### Bugs Found
**BUG-1: Duplicate Email Registration**
- **Severity:** High
- **Steps to Reproduce:** 1. Register with email, 2. Try again with same email
- **Expected:** Error message
- **Actual:** Silent failure
```

### 6. Deployment Status (by DevOps Engineer)
```markdown
---

## Deployment

**Status:** Deployed
**Deployed:** 2026-01-13
**Production URL:** https://your-app.example.com
**Git Tag:** v1.0.0-PROJ-1
```

## Workflow

1. **Requirements Engineer** creates Feature Spec
2. **User** reviews Spec and gives feedback
3. **Solution Architect** adds Tech Design
4. **User** approves final design
5. **Frontend/Backend Devs** implement (documented via Git Commits)
6. **QA Engineer** tests and adds Test Results to Feature document
7. **DevOps** deploys and adds Deployment Status to Feature document

## Status Tracking

Feature status is tracked directly in the feature document:
```markdown
# PROJ-1: Feature Name

**Status:** Planned | In Progress | In Review | Deployed
**Created:** 2026-01-12
**Last Updated:** 2026-01-12
```

**Git as Single Source of Truth:**
- All implementation details are in Git commits
- `git log --grep="PROJ-1"` shows all changes for a feature
- No separate FEATURE_CHANGELOG.md needed!
