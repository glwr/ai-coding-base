# Security Rules

## Secrets Management
- NEVER commit secrets, API keys, or credentials to git
- Use `.env.local` for local development (already in .gitignore)
- Use a public prefix (if applicable) ONLY for values safe to expose in the browser
- Document all required env vars in `.env.local.example` with dummy values

## Input Validation
- Validate ALL user input on the server side with a schema validation library
- Never trust client-side validation alone
- Sanitize data before database insertion

## Authentication
- Always verify authentication before processing API requests
- Use the project's access control (e.g. RLS, middleware guards) as a second line of defense
- Implement rate limiting on authentication endpoints

## Security Headers
- X-Frame-Options: DENY
- X-Content-Type-Options: nosniff
- Referrer-Policy: origin-when-cross-origin
- Strict-Transport-Security with includeSubDomains

## Code Review Triggers
- Any changes to access control policies require explicit user approval
- Any changes to authentication flow require explicit user approval
- Any new environment variables must be documented in .env.local.example
