# Error Tracking

Track production errors automatically so you know about issues before your users report them.

## What You Need

An error tracking service should provide:
- **Automatic error capture** (client-side + server-side)
- **Stack traces with source maps** (readable error locations)
- **Error grouping and deduplication** (don't get 1000 alerts for the same bug)
- **Alerts** (email, Slack, etc. for new errors)
- **Performance monitoring** (optional but useful)

## Popular Options

| Service | Free Tier | Notes |
|---------|-----------|-------|
| Sentry | 5k errors/month | Most popular, great integrations |
| LogRocket | 1k sessions/month | Session replay + error tracking |
| Bugsnag | 7.5k events/month | Good for mobile + web |
| Platform built-in | Varies | Some deployment platforms include basic monitoring |

## Setup Steps (General)

1. **Create account** on chosen service
2. **Install SDK** for your framework (most services have framework-specific packages)
3. **Add environment variables** for the service's DSN/API key (to `.env.local` and deployment platform)
4. **Verify setup** by triggering a test error and checking the dashboard
5. **Configure alerts** for new and recurring errors

## What to Look For

- Does it support your framework out of the box?
- Does it support source maps for readable stack traces?
- Is the free tier sufficient for your scale?
- Does it integrate with your team's communication tools (Slack, email)?
