# AI Coding Base

> A workflow template with an AI-powered development process using specialized skills for Requirements, Architecture, Frontend, Backend, QA, and Deployment. Tech-agnostic — define your stack per project.

## Tech Stack

_Fill in when starting a new project:_

- **Framework:** _TBD_
- **Language:** _TBD_
- **Styling:** _TBD_
- **Component Library:** _TBD_
- **Backend/DB:** _TBD_
- **Auth:** _TBD_
- **Deployment:** _TBD_
- **Validation:** _TBD_
- **State Management:** _TBD_

## Project Structure

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
  production/       Production guides (security, performance, etc.)
```

## Development Workflow

1. `/requirements` - Create feature spec from idea
2. `/architecture` - Design tech architecture (PM-friendly, no code)
3. `/frontend` - Build UI components
4. `/backend` - Build APIs, database, access control
5. `/qa` - Test against acceptance criteria + security audit
6. `/deploy` - Deploy + production-ready checks
7. `/remember` - Save decisions, patterns, or learnings to project context

## Feature Tracking

All features tracked in `features/INDEX.md`. Every skill reads it at start and updates it when done. Feature specs live in `features/PROJ-X-name.md`.

## Key Conventions

- **Feature IDs:** PROJ-1, PROJ-2, etc. (sequential)
- **Single Responsibility:** One feature per spec file

## Safety Boundaries

- NEVER modify, delete, or overwrite files outside the current project directory
- NEVER change system configuration, environment variables outside the project, or global packages
- NEVER run destructive commands (rm -rf, drop database, force push to main, etc.) without explicit confirmation
- NEVER install global packages or tools — only project-local dependencies
- If a task requires tools, packages, or system changes not already present: stop and ask before proceeding

## Coding Principles

- Use only dependencies already in the project. If a new dependency is needed: ask first, explain why, and suggest alternatives
- Don't refactor unrelated code while working on a task — stay focused
- When fixing bugs: fix the root cause, not the symptom. Add a regression test

## Output Language

- All code, comments, commit messages, and documentation: English
- Conversation with me: German is fine

## Build & Test Commands

_Fill in when starting a new project:_

```bash
# npm run dev        # Development server
# npm run build      # Production build
# npm run lint       # Linting
# npm run test       # Tests
```

## Product Context

@docs/PRD.md

## Feature Overview

@features/INDEX.md

## Project Context

Context files in `context/` (decisions, patterns, learnings, stack) are read on demand by skills — not loaded here to save tokens. Use `/remember` to manage them.
