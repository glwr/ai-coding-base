# ai-coding-base

> A workflow template for AI-powered development with Claude Code. Includes specialized skills for Requirements, Architecture, Frontend, Backend, QA, Security, and Deployment. Tech-agnostic — define your stack per project.

## Getting Started

1. **Use this template** to create a new repository
2. Run `/requirements` with a description of your project to initialize PRD + feature specs
3. Run `/architecture project` to design the system architecture
4. Follow the skill workflow: `/frontend` → `/backend` → `/qa` → `/security` → `/deploy`

## What's Included

### Skills (Slash Commands)

| Skill | Description |
|-------|-------------|
| `/requirements` | Create feature specs or initialize a new project (PRD + features) |
| `/architecture` | Design architecture — `project` mode (system-wide) or feature mode |
| `/frontend` | Build UI components using the project's frontend stack |
| `/backend` | Build APIs, database schemas, server-side logic |
| `/qa` | Test features against acceptance criteria + security audit |
| `/security` | OWASP Top 10 security review |
| `/deploy` | Deploy with production-ready checks |
| `/remember` | Save decisions, patterns, or learnings to project context |
| `/help` | Context-aware guide — shows where you are and what to do next |

### Agents

| Agent | Model | Purpose |
|-------|-------|---------|
| Frontend Developer | opus | Builds UI components |
| Backend Developer | opus | Builds APIs and database |
| QA Engineer | opus | Tests features, finds bugs |
| Security Reviewer | sonnet | OWASP security audits |

### Rules (Auto-Activated)

| Rule | Activated When |
|------|---------------|
| `general.md` | Always loaded |
| `security.md` | Always loaded |
| `frontend.md` | Editing frontend files (components, pages, hooks, styles) |
| `backend.md` | Editing backend files (API routes, database, server) |

### Hooks

| Hook | Trigger | Purpose |
|------|---------|---------|
| Lock file protection | Before Write/Edit | Prevents editing lock files and .git/ |
| Secret scanner | After Write/Edit | Warns about hardcoded secrets, credentials, connection strings |

### Documentation Templates

| File | Purpose |
|------|---------|
| `docs/PRD.md` | Product Requirements Document |
| `docs/architecture.md` | System architecture overview |
| `docs/api.md` | API endpoint reference |
| `docs/development.md` | Local development guide |
| `docs/deployment.md` | Deployment & infrastructure |
| `docs/design-system.md` | Brand, colors, typography, design tokens |
| `docs/production/security-headers.md` | Security headers guide |
| `docs/production/performance.md` | Performance monitoring |
| `docs/production/error-tracking.md` | Error tracking setup |
| `docs/production/rate-limiting.md` | Rate limiting guide |
| `docs/production/database-optimization.md` | Database optimization |
| `docs/production/containerization.md` | Docker & container best practices |

### Project Context (Git-Versioned)

| File | Purpose |
|------|---------|
| `context/decisions.md` | Architecture & design decisions (ADR-style) |
| `context/patterns.md` | Code patterns & conventions |
| `context/learnings.md` | Gotchas & debugging insights |
| `context/stack.md` | Tech stack details & infrastructure |

## Security

- **`.claude/settings.json`** — Deny rules for `.env` files, secrets, and credentials
- **`.claude/settings.local.json.example`** — Example allow-list for bash commands (copy to `.claude/settings.local.json` and customize)
- **`.claude/hooks/check-secrets.sh`** — Post-edit secret scanner (passwords, API keys, connection strings, cloud credentials, JWT secrets)
- **`.claude/rules/security.md`** — Security rules for all skills

## Customization

1. **Fill in `CLAUDE.md`** — Tech stack, build commands, project structure
2. **Adapt path patterns** in `.claude/rules/frontend.md` and `.claude/rules/backend.md` to match your structure
3. **Copy `.claude/settings.local.json.example`** to `.claude/settings.local.json` and adjust the allow-list
4. **Fill in doc templates** as you build — architecture, API, development, deployment, design system

## License

MIT
