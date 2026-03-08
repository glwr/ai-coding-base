# Feature Specifications

This folder contains detailed feature specs created by `/requirements`.

## Naming Convention

`PROJ-X-feature-name.md` — where X is the sequential feature ID from `INDEX.md`.

## Lifecycle

1. **Planned** — Spec created by `/requirements`, ready for `/architecture`
2. **Ready** — Tech design added by `/architecture`, ready for implementation
3. **In Progress** — Being built by `/frontend` + `/backend`
4. **In Review** — QA testing by `/qa`
5. **Done** — Passed QA + security, ready for `/release`
6. **Deployed** — Live in production

## Creating New Features

Run `/requirements` with your feature idea. It handles:
- Assigning the next PROJ-X ID
- Creating the spec file from the template
- Updating `INDEX.md`
- Creating a GitHub Issue (if tracking variant = GitHub Issues)

## Spec Structure

Each spec file contains (added progressively by skills):
- **Header** — ID, status, created date
- **User Stories** — As a [user], I want to [action] so that [goal]
- **Acceptance Criteria** — Testable checkboxes
- **Edge Cases** — Error handling, boundary conditions
- **Dependencies** — Other features this depends on
- **Tech Design** — Added by `/architecture` (component tree, data model, tech decisions)
- **QA Test Results** — Added by `/qa` (pass/fail per AC, bugs found)
- **Security Audit** — Added by `/security` (findings summary, report link)

## Tracking

All features are tracked in `INDEX.md`. See the Status Legend there for details.
Git is the source of truth — `git log --grep="PROJ-X"` shows all changes for a feature.
