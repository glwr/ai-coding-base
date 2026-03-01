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
| `/security` | OWASP Top 10 security review (5-phase audit) |
| `/deploy` | Deploy with production-ready checks, error tracking, security headers |
| `/remember` | Save decisions, patterns, or learnings to project context (ADD, SEARCH, REVIEW modes) |
| `/help` | Context-aware guide — shows where you are and what to do next |

Skills include supporting files (checklists, templates) in `.claude/skills/<skill>/`.

### Agents

| Agent | Model | Purpose |
|-------|-------|---------|
| Frontend Developer | opus | Builds UI components |
| Backend Developer | opus | Builds APIs and database |
| QA Engineer | opus | Tests features, finds bugs |
| Security Reviewer | sonnet | OWASP security audits (with project memory) |

Agents are defined in `.claude/agents/` and invoked by their respective skills.

### Rules (Auto-Activated)

| Rule | Activated When |
|------|---------------|
| `general.md` | Always loaded |
| `security.md` | Always loaded |
| `frontend.md` | Editing frontend files (components, pages, hooks, styles) |
| `backend.md` | Editing backend files (API routes, database, server) |

Key rules enforced by `general.md`:
- **No command chaining** — Never use `&&`, `||`, or `;` in Bash calls (permission checks may reject chained commands). Use separate Bash calls instead.
- **Git conventions** — Commit format `type(PROJ-X): description`, sequential feature IDs
- **Context management** — Skills read/write `context/` files, decisions are append-only
- **English only** — All written output in English (code, docs, commits, specs, UI text)

### Hooks

| Hook | Trigger | Purpose |
|------|---------|---------|
| Lock file protection | Before Write/Edit | Prevents editing lock files and `.git/` |
| Secret scanner | After Write/Edit | Warns about hardcoded secrets, credentials, connection strings |

### Tracking & Backlog

Two tracking variants — set via the `Tracking` field in `CLAUDE.md`:

| Variant | How it works |
|---------|-------------|
| **File-based** (default) | Features in `features/INDEX.md`, bugs/tasks as files in `backlog/` |
| **GitHub Issues** | Labels + milestones via `gh` CLI, `features/INDEX.md` as local mirror |

Both variants use:
- `features/INDEX.md` — Central feature index with status tracking
- `backlog/` — Bug reports (`BUG-X`) and technical tasks (`TASK-X`) with templates
- `.claude/skills/tracking-guide.md` — Shared reference for all tracking operations

Skills automatically create bug entries for Critical/High findings (`/qa`, `/security`).

### Documentation Templates

| File | Purpose |
|------|---------|
| `docs/PRD.md` | Product Requirements Document |
| `docs/architecture.md` | System architecture overview |
| `docs/api.md` | API endpoint reference |
| `docs/development.md` | Local development guide |
| `docs/deployment.md` | Deployment & infrastructure |
| `docs/design-system.md` | Brand, colors, typography, design tokens |
| `docs/local-memory-guide.md` | Guide for personal vs shared context |
| `docs/production/security-headers.md` | Security headers guide |
| `docs/production/performance.md` | Performance monitoring |
| `docs/production/error-tracking.md` | Error tracking setup |
| `docs/production/rate-limiting.md` | Rate limiting guide |
| `docs/production/database-optimization.md` | Database optimization |
| `docs/production/containerization.md` | Docker & container best practices |

### Project Context (Git-Versioned)

| File | Purpose |
|------|---------|
| `context/decisions.md` | Architecture & design decisions (ADR-style, append-only) |
| `context/patterns.md` | Code patterns & conventions |
| `context/learnings.md` | Gotchas & debugging insights |
| `context/stack.md` | Tech stack details & infrastructure |
| `context/archive/` | Archived entries when context files exceed 150 lines |

Context files are read on demand by skills (not loaded into every conversation). Use `/remember` to manage them.

### Security Reports

Security audit results are persisted to `reports/security/YYYY-MM-DD-scope.md` so findings survive subprocess boundaries.

## Security

- **`.claude/settings.json`** — Deny rules for `.env` files, secrets, and credentials
- **`.claude/settings.local.json.example`** — Example allow-list for bash commands (copy to `.claude/settings.local.json` and customize)
- **`.claude/hooks/check-secrets.sh`** — Post-edit secret scanner (passwords, API keys, connection strings, cloud credentials, JWT secrets)
- **`.claude/rules/security.md`** — Security rules for all skills

## Project Structure

```
.claude/
  agents/             Agent definitions (frontend-dev, backend-dev, qa-engineer, security-reviewer)
  hooks/              Pre/Post tool-use hooks (secret scanner, lock file protection)
  rules/              Auto-activated rules (general, security, frontend, backend)
  skills/             Skill definitions with templates and checklists
  settings.json       Shared permission deny rules and hooks
  settings.local.json.example  Example allow-list (copy and customize)
features/
  INDEX.md            Central feature tracking
  PROJ-X-name.md      Feature specifications
context/
  decisions.md        Architecture decisions (ADR-style)
  patterns.md         Code patterns & conventions
  learnings.md        Gotchas & debugging insights
  stack.md            Tech stack details
  archive/            Archived context entries
docs/
  PRD.md              Product Requirements Document
  architecture.md     System architecture overview
  api.md              API endpoint reference
  development.md      Local development guide
  deployment.md       Deployment & infrastructure guide
  design-system.md    Brand, colors, typography, design tokens
  local-memory-guide.md  Personal vs shared context guide
  production/         Production guides (security, performance, etc.)
backlog/
  bug-template.md     Template for bug reports (BUG-X)
  task-template.md    Template for technical tasks (TASK-X)
reports/
  security/           Security audit reports (YYYY-MM-DD-scope.md)
src/                  Source code (structure depends on framework)
```

## Customization

1. **Fill in `CLAUDE.md`** — Tech stack, build commands, tracking variant
2. **Adapt path patterns** in `.claude/rules/frontend.md` and `.claude/rules/backend.md` to match your structure
3. **Copy `.claude/settings.local.json.example`** to `.claude/settings.local.json` and adjust the allow-list
4. **Fill in doc templates** as you build — architecture, API, development, deployment, design system
5. **For monorepos** — See the monorepo structure section in `CLAUDE.md` and adapt paths accordingly

## License

MIT
