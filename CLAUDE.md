# AI Coding Base

> A workflow template with an AI-powered development process using specialized skills for Requirements, Architecture, Frontend, Backend, QA, Security, and Release. Tech-agnostic — define your stack per project.

## Tech Stack

_Fill in when starting a new project:_

- **Platform:** _TBD_ _(Web | Apple | Cross-platform)_
- **Framework:** _TBD_
- **Language:** _TBD_
- **Styling:** _TBD_
- **Component Library:** _TBD_
- **Backend/DB:** _TBD_
- **Auth:** _TBD_
- **Deployment:** _TBD_
- **Validation:** _TBD_
- **State Management:** _TBD_
- **Tracking:** _TBD_ _(File-based | GitHub Issues)_

_Apple-specific (fill in when Platform = Apple):_

- **Min Deployment Target:** _TBD_ _(e.g., iOS 17.0, macOS 14.0)_
- **UI Framework:** _TBD_ _(SwiftUI | AppKit | UIKit)_
- **Data Persistence:** _TBD_ _(SwiftData | Core Data | UserDefaults)_
- **Architecture Pattern:** _TBD_ _(MVVM | TCA | MV)_

## Project Structure

### Single App (default)
```
src/                Source code (structure depends on framework)
features/           Feature specifications (PROJ-X-name.md)
  INDEX.md          Feature status overview
context/            Shared project memory (git-versioned)
  decisions.md      Architecture & design decisions (ADR-style)
  patterns.md       Code patterns & conventions
  learnings.md      Gotchas & debugging insights
  stack.md          Tech stack details & infrastructure
docs/
  PRD.md            Product Requirements Document
  architecture.md   System architecture overview
  api.md            API endpoint reference
  development.md    Local development guide
  deployment.md     Deployment & infrastructure guide
  design-system.md  Brand, colors, typography, design tokens
  production/       Production guides (security, performance, etc.)
backlog/            Bug reports and technical tasks (BUG-X, TASK-X)
reports/
  security/         Security audit reports (YYYY-MM-DD-scope.md)
```

### Monorepo (optional)
_If your project uses a monorepo structure (pnpm workspaces, npm workspaces, Turborepo, Nx):_
```
apps/
  web/              Frontend application
  api/              Backend / API server
packages/
  shared/           Shared types, schemas, utilities
  ui/               Shared UI component library
features/           Feature specifications (same as above)
context/            Shared project memory (same as above)
docs/               Documentation (same as above)
backlog/            Bug reports and technical tasks (same as above)
reports/            Audit reports (same as above)
```

_When using a monorepo, adapt the path patterns in `.claude/rules/frontend.md` and `.claude/rules/backend.md` to match your actual structure (e.g. `apps/web/src/**` instead of `src/**`)._

### Apple App (when Platform = Apple)
```
AppName/
  App.swift           App entry point
  Features/           Feature modules (grouped by feature)
    FeatureName/
      Views/           SwiftUI views
      ViewModels/      ViewModels or @Observable models
      Models/          Data models
  Shared/
    Services/          Networking, persistence, utilities
    Extensions/        Swift extensions
    Resources/         Assets, localization
  AppName.entitlements Capabilities
  Info.plist           App configuration
  PrivacyInfo.xcprivacy Privacy manifest
AppNameTests/          Unit tests
AppNameUITests/        UI tests
Package.swift          Dependencies (SPM)
features/              Feature specifications (same as above)
context/               Shared project memory (same as above)
docs/                  Documentation (same as above)
backlog/               Bug reports and technical tasks (same as above)
reports/               Audit reports (same as above)
```

## Development Workflow

### Web (Platform = Web)
1. `/requirements` - Create feature spec from idea (or initialize new project)
2. `/architecture project` - Design system-wide architecture (once, after init)
3. `/architecture features/PROJ-X.md` - Design tech architecture for a feature
4. `/frontend` - Build UI components
5. `/backend` - Build APIs, database, access control
6. `/simplify` - Review code for quality, reuse, and efficiency (optional, recommended)
7. `/qa` - Test against acceptance criteria
8. `/security` - OWASP security audit + vulnerability scan
9. `/release` - Pre-release checks, documentation sync, git tag, CI/CD verification, status updates

### Apple (Platform = Apple)
1. `/requirements` - Create feature spec from idea (or initialize new project)
2. `/architecture project` - Design system-wide architecture (once, after init)
3. `/architecture features/PROJ-X.md` - Design tech architecture for a feature
4. `/apple-ui` - Build SwiftUI views and navigation
5. `/apple-data` - Build data models, persistence, networking
6. `/simplify` - Review code for quality, reuse, and efficiency (optional, recommended)
7. `/qa` - Test against acceptance criteria (simulator + accessibility)
8. `/security` - Security audit (OWASP + Apple platform security)
9. `/hig-review` - Human Interface Guidelines compliance review
10. `/apple-build` - Build, test, archive with xcodebuild
11. `/release` - Pre-release checks, documentation sync, git tag, status updates
12. `/appstore` - App Store / TestFlight submission

### Available anytime (not sequential)
`/track` · `/remember` · `/help`

## Feature Tracking

All features tracked in `features/INDEX.md`. Every skill reads it at start and updates it when done. Feature specs live in `features/PROJ-X-name.md`. Bugs and tasks are tracked in `backlog/` with corresponding entries in INDEX.md.

**No Code Without Tracking:** Every code change requires an active tracked work item (PROJ-X, BUG-X, or TASK-X) with a detail file and GitHub Issue (when Tracking = GitHub Issues). Work items are auto-classified and created before any code is written.

## Key Conventions

- **Feature IDs:** PROJ-1, PROJ-2, etc. (sequential)
- **Single Responsibility:** One feature per spec file

## Permissions

### Allowed (no confirmation needed)

- Create, edit, delete, rename, and move files within the project
- Run shell commands that only affect the project directory
- Install project-local dependencies (npm install, pip install in venv, etc.)
- Run build processes, linters, formatters, and tests
- Git operations (commit, branch, merge, rebase, etc.)
- Start dev servers, open local ports
- Create/modify configuration files within the project
- Read files and directories outside the project (read-only)

### Not allowed

- Modify or delete files outside the project directory
- Install global packages or tools (npm install -g, brew install, apt install, etc.)
- Modify system-wide configurations (~/.bashrc, ~/.gitconfig, /etc/*, etc.)
- Run destructive commands (rm -rf, drop database, force push to main) without explicit confirmation
- Start, stop, or configure system services
- Change network or firewall settings
- Set environment variables outside the project

### Rule of thumb

> **Inside the project: everything is allowed. Outside the project: read-only. System-level: nothing.**

If a task requires tools, packages, or system changes not already present: stop and ask before proceeding.

## Coding Principles

- Use only dependencies already in the project. If a new dependency is needed: ask first, explain why, and suggest alternatives
- Don't refactor unrelated code while working on a task — stay focused
- When fixing bugs: fix the root cause, not the symptom. Add a regression test

## Output Language

- IMPORTANT: ALL written output must be in English — no exceptions:
  - Code, comments, variable names
  - Commit messages, PR descriptions
  - Documentation, feature specs, context entries, PRD
  - Error messages, log messages, UI text
- Conversation with the user may be in any language the user prefers

## Build & Test Commands

_Fill in when starting a new project:_

```bash
# Web
# npm run dev        # Development server
# npm run build      # Production build
# npm run lint       # Linting
# npm run test       # Tests

# Apple (uncomment when Platform = Apple)
# xcodebuild build -scheme AppName -destination 'platform=iOS Simulator,name=iPhone 16'
# xcodebuild test -scheme AppName -destination 'platform=iOS Simulator,name=iPhone 16'
# swift build        # SPM build (for packages/CLI tools)
# swift test         # SPM tests
```

## Documentation

| Document | Purpose |
|----------|---------|
| `docs/PRD.md` | Product vision, roadmap, success metrics |
| `docs/architecture.md` | System architecture, data flows, auth, caching |
| `docs/api.md` | API endpoint reference |
| `docs/development.md` | Local development setup, scripts, patterns |
| `docs/deployment.md` | Production deployment, CI/CD, infrastructure |
| `docs/design-system.md` | Brand colors, typography, design tokens |
| `docs/production/*` | Security headers, performance, error tracking, rate limiting, containerization |

## Product Context

@docs/PRD.md

## Feature Overview

@features/INDEX.md

## Project Context

Context files in `context/` (decisions, patterns, learnings, stack) are read on demand by skills — not loaded here to save tokens. Use `/remember` to manage them.
