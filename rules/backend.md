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
- Never hardcode secrets in source code
- Use environment variables for all credentials
- Validate and sanitize all user input
- Use parameterized queries to prevent SQL injection
