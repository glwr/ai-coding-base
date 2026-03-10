# Development Guide

> Local development setup, project structure, and common tasks.

## Prerequisites

- **Node.js:** >= 20 _(adjust to your project)_
- **Package Manager:** npm / pnpm / yarn _(pick one)_
- **Database:** _if applicable_
- **Docker:** _if applicable_

## Quick Start

```bash
# 1. Clone the repository
git clone <repo-url>
cd <project-name>

# 2. Install dependencies
npm install

# 3. Set up environment
cp .env.local.example .env.local
# Edit .env.local with your values

# 4. Start development server
npm run dev
```

## Project Structure

```
src/
├── app/              # Pages and routing
├── components/       # UI components
│   └── ui/           # Component library primitives
├── hooks/            # Custom React hooks
├── lib/              # Utilities and helpers
├── styles/           # Global styles
└── types/            # TypeScript type definitions
features/             # Feature specifications
context/              # Shared project memory
docs/                 # Documentation
  ├── PRD.md          # Product Requirements Document
  └── production/     # Production guides
```

_Adjust the tree above to match your actual project structure._

## Available Scripts

| Command | Description |
|---------|-------------|
| `npm run dev` | Start development server with hot reload |
| `npm run build` | Production build |
| `npm run lint` | Run linter |
| `npm run test` | Run tests |
| `npm run typecheck` | TypeScript type checking |

## Environment Variables

| Variable | Required | Build/Runtime | Description |
|----------|----------|--------------|-------------|
| `DATABASE_URL` | Yes | Runtime | Database connection string |
| `AUTH_SECRET` | Yes | Runtime | Authentication secret |
| `NEXT_PUBLIC_*` | Varies | Build time | Client-side variables (baked into bundle) |

See `.env.local.example` for all variables with example values.

### Build-time vs Runtime Variables

- **Build-time:** Baked into the JavaScript bundle during `npm run build`. Changes require a rebuild. Typically prefixed with `NEXT_PUBLIC_` or framework equivalent.
- **Runtime:** Read from the environment at request time. Can be changed without rebuilding.

## Key Patterns

### Data Fetching
_Describe the established data fetching pattern (e.g. TanStack Query, SWR, server components):_

```typescript
// Example pattern here
```

### API Client
_Describe how API calls are made (e.g. fetch wrapper, ky, axios):_

```typescript
// Example pattern here
```

### Adding a New API Endpoint
1. _Step 1_
2. _Step 2_
3. _Step 3_

### Adding a New Page / Route
1. _Step 1_
2. _Step 2_

### Styling Conventions
_Describe the CSS approach (Tailwind, CSS Modules, inline styles, etc.):_

- _Convention 1_
- _Convention 2_

## Docker (Local Development)

_If using Docker for local development:_

```bash
# Start all services
docker compose up -d

# View logs
docker compose logs -f

# Stop all services
docker compose down
```

## Testing

_Describe the testing approach:_

```bash
# Run all tests
npm run test

# Run tests in watch mode
npm run test:watch

# Type checking
npm run typecheck
```

## Common Tasks

### Clear Cache
```bash
# Clear local cache (adjust to your setup)
```

### Reset Database
```bash
# Reset and re-seed database (adjust to your setup)
```

### Check Logs
```bash
# View application logs (adjust to your setup)
```

## Troubleshooting

### Port already in use
```bash
lsof -ti:3000 | xargs kill
```

### Dependencies out of sync
```bash
rm -rf node_modules && npm install
```

## Recommended MCP Servers

_Optional MCP servers that enhance the development workflow. Configure per project as needed._

### Playwright MCP (Visual Design Review)

Enables automated screenshot capture for the `/design-review` skill. Claude Code can navigate the running app, take screenshots, and visually verify UI against the design system.

```bash
claude mcp add playwright -- npx @playwright/mcp@latest
```

**Requires:** Node.js (no project dependency needed — npx handles it)
**Used by:** `/design-review` skill

### Figma MCP (Design Token Sync)

Gives Claude Code direct access to Figma design data — variables, tokens, components, and variants. Useful for syncing design tokens into `docs/design-system.md`.

```bash
# Remote (recommended — no local install)
claude mcp add figma --url https://mcp.figma.com/mcp

# Or via Figma Desktop app
claude mcp add figma --launch "Figma Desktop MCP"
```

**Requires:** Figma account with file access
**Used by:** Manual token sync to `docs/design-system.md`, `/design-review` (optional Figma comparison)

---

_Last updated: YYYY-MM-DD_
