# Deployment Guide

> Production deployment, CI/CD, and infrastructure overview.

## Infrastructure Overview

| Resource | Type | Details |
|----------|------|---------|
| _App hosting_ | _e.g. Vercel, Azure Container Apps, AWS_ | _URL, region_ |
| _Database_ | _e.g. PostgreSQL, Supabase, PlanetScale_ | _Connection details_ |
| _Cache_ | _e.g. Redis, Upstash_ | _If applicable_ |
| _CDN_ | _e.g. Cloudflare, Vercel Edge_ | _If applicable_ |
| _Auth provider_ | _e.g. Entra ID, Auth0, Clerk_ | _If applicable_ |

## CI/CD

### Pipeline Overview

_Describe the CI/CD pipeline:_

```
Push to main → Build → Test → Deploy
```

### Workflow Files

| Workflow | Trigger | What it does |
|----------|---------|-------------|
| _build.yml_ | _Push to main, PR_ | _Build, lint, typecheck_ |
| _deploy.yml_ | _Push to main_ | _Build + deploy to production_ |

### Required Secrets

_Secrets that must be configured in your CI/CD platform:_

| Secret | Description |
|--------|-------------|
| _DATABASE_URL_ | _Production database connection string_ |
| _AUTH_SECRET_ | _Authentication secret for production_ |

### Required Variables

_Non-secret configuration variables:_

| Variable | Value | Description |
|----------|-------|-------------|
| _NEXT_PUBLIC_APP_URL_ | _https://your-app.com_ | _Public app URL_ |

## Manual Deployment

_Steps for deploying manually (if CI/CD is not set up or for hotfixes):_

```bash
# 1. Build
npm run build

# 2. Deploy (adjust to your platform)
# e.g. vercel --prod
# e.g. docker build + docker push + az containerapp update
```

## Environment Configuration

### Production
| Variable | Value | Notes |
|----------|-------|-------|
| `NODE_ENV` | `production` | _Set by platform_ |
| _..._ | _..._ | _..._ |

### Staging (optional)
| Variable | Value | Notes |
|----------|-------|-------|
| _..._ | _..._ | _..._ |

## Domain & DNS

- **Production URL:** _https://your-app.example.com_
- **DNS provider:** _e.g. Cloudflare, Route53_
- **SSL:** _Managed by platform / Let's Encrypt_

## Rollback

### Quick Rollback
_Use your platform's rollback feature to revert to the previous deployment:_

```bash
# Platform-specific rollback command
```

### Manual Rollback
```bash
# 1. Find the last working commit
git log --oneline -10

# 2. Deploy a specific commit
git checkout <commit-sha>
npm run build
# Deploy...
```

## Monitoring

- **Error tracking:** _e.g. Sentry — see docs/production/error-tracking.md_
- **Logs:** _Where to find production logs_
- **Health check:** `GET /api/health`
- **Uptime monitoring:** _e.g. UptimeRobot, Checkly_

## Cost Estimate

| Resource | Plan | Monthly Cost |
|----------|------|-------------|
| _Hosting_ | _Free / Pro_ | _$0–20_ |
| _Database_ | _Free / Pro_ | _$0–25_ |
| _Cache_ | _Free / Pro_ | _$0–10_ |
| **Total** | | **$0–55** |

---

_Last updated: YYYY-MM-DD_
