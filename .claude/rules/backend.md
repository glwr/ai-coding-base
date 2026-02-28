---
paths:
  # Single app
  - "src/app/api/**/*"
  - "src/lib/db/**/*"
  - "src/server/**/*"
  - "api/**/*"
  - "server/**/*"
  - "db/**/*"
  - "prisma/**/*"
  - "drizzle/**/*"
  - "supabase/**/*"
  # Monorepo (adapt 'api'/'middleware' to your app name)
  - "apps/api/**/*"
  - "apps/middleware/**/*"
  - "packages/shared/**/*"
  - "packages/db/**/*"
---

# Backend Development Rules

## Database
- Enable row-level security or equivalent access control on every table
- Create access control policies for SELECT, INSERT, UPDATE, DELETE
- Add indexes on columns used in WHERE, ORDER BY, and JOIN clauses
- Use foreign keys with ON DELETE CASCADE where appropriate
- Never skip access control — security first

## API Routes
- Validate all inputs using a schema validation library before processing
- Always check authentication: verify user session exists
- Return meaningful error messages with appropriate HTTP status codes
- Use limits on all list queries to prevent unbounded results

## Query Patterns
- Use joins instead of N+1 query loops
- Cache rarely-changing data using the framework's caching mechanism
- Always handle errors from database responses

## Security
- Use parameterized queries to prevent SQL injection
- See `.claude/rules/security.md` for full security rules
