# Rate Limiting

Prevent abuse, DDoS attacks, and excessive API usage.

## When to Add Rate Limiting
- **MVP:** Optional (focus on features first)
- **Production with users:** Recommended on auth endpoints and public APIs
- **Public-facing APIs:** Required

## How Rate Limiting Works

Rate limiting restricts the number of requests a client can make within a time window. When the limit is exceeded, the server returns HTTP 429 (Too Many Requests).

### Key Concepts
- **Identifier:** What to rate limit by (IP address, user ID, API key)
- **Window:** Time period (e.g. 10 seconds, 1 minute)
- **Limit:** Max requests per window
- **Algorithm:** Fixed window, sliding window, or token bucket

## Recommended Limits

| Endpoint Type | Limit | Window |
|--------------|-------|--------|
| Login/Register | 5 requests | 1 minute |
| Password Reset | 3 requests | 5 minutes |
| General API | 30 requests | 10 seconds |
| File Upload | 5 requests | 1 minute |

## Implementation Options

### In-Memory (Simple, Single Server)
Use an in-memory store (Map/Object) for simple setups. Works for single-server deployments but doesn't scale to multiple instances.

### Redis-Based (Production, Multi-Server)
Use Redis for distributed rate limiting. Popular libraries exist for most frameworks and languages (e.g. `rate-limiter-flexible`, `@upstash/ratelimit`, `express-rate-limit`).

### Middleware / Platform-Level
Some deployment platforms and CDNs offer built-in rate limiting (e.g. Cloudflare, AWS WAF). This is the simplest option if available.

## Response Format

When rate limited, return:
- HTTP status: `429 Too Many Requests`
- Headers: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `Retry-After`
- Body: `{ "error": "Too many requests" }`
