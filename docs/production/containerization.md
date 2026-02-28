# Containerization Guide

> Best practices for Docker builds, multi-stage patterns, and local development with containers.

## When to Containerize

- **MVP / Prototyping:** Use your platform's native deployment (Vercel, Netlify, etc.) — no Docker needed
- **Production with custom infra:** Docker when deploying to Azure Container Apps, AWS ECS, GCP Cloud Run, or self-hosted
- **Team consistency:** Docker Compose for local development when the stack has multiple services (app + database + cache)

## Dockerfile Best Practices

### Multi-Stage Builds

Use multi-stage builds to keep production images small:

```dockerfile
# Stage 1: Install dependencies
FROM node:22-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production

# Stage 2: Build
FROM node:22-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# Stage 3: Production runner
FROM node:22-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

# Copy only what's needed to run
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

EXPOSE 3000
CMD ["node", "server.js"]
```

### Key Principles

1. **Minimal final image:** Only copy built artifacts and production dependencies into the runner stage
2. **Layer caching:** Copy `package.json` before source code so dependency installs are cached
3. **Alpine base:** Use `-alpine` variants for smaller images
4. **Non-root user:** Run as a non-root user in production
5. **Build args for build-time vars:** Use `ARG` for variables needed at build time (e.g. `NEXT_PUBLIC_*`)

### Build-Time vs Runtime Variables in Docker

```dockerfile
# Build-time: baked into the image
ARG NEXT_PUBLIC_API_URL
ENV NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL

# Runtime: set when starting the container
ENV DATABASE_URL=""
# Passed via: docker run -e DATABASE_URL=...
```

## .dockerignore

Always create a `.dockerignore` to keep the build context small:

```
node_modules
.git
.github
.next
dist
*.md
docs/
features/
context/
.env*
!.env.example
```

## Docker Compose (Local Development)

```yaml
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgresql://postgres:postgres@db:5432/app
      - REDIS_URL=redis://cache:6379
    depends_on:
      - db
      - cache

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: app
      POSTGRES_PASSWORD: postgres
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data

  cache:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  pgdata:
```

### Useful Commands

| Command | Description |
|---------|-------------|
| `docker compose up -d` | Start all services in background |
| `docker compose logs -f app` | Follow app logs |
| `docker compose down` | Stop all services |
| `docker compose down -v` | Stop and remove volumes (reset data) |
| `docker compose build --no-cache` | Rebuild without cache |

## Monorepo Considerations

For monorepos with multiple apps sharing packages:

1. **Copy the entire monorepo** into the builder stage (not just one app)
2. **Use workspace deploy commands** to extract a single app with its dependencies:
   ```dockerfile
   # pnpm example
   RUN pnpm deploy --filter @org/app-name --prod /deploy
   ```
3. **Copy only the deployed output** into the runner stage:
   ```dockerfile
   COPY --from=builder /deploy /app
   ```
4. **Avoid symlinks** in the runner stage — workspace tools create symlinks that break outside the monorepo context

## Container Registry

Push built images to a container registry:

```bash
# Build and tag
docker build -t your-registry.io/app-name:latest .

# Push
docker push your-registry.io/app-name:latest
```

Common registries: Docker Hub, GitHub Container Registry (ghcr.io), Azure Container Registry (ACR), AWS ECR, Google Artifact Registry.

## Health Checks

Add a health check to your Dockerfile or container orchestrator:

```dockerfile
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -qO- http://localhost:3000/api/health || exit 1
```

## Image Size Targets

| Image Type | Target Size |
|-----------|-------------|
| Node.js app (Alpine) | < 200 MB |
| Static site (nginx) | < 50 MB |
| API server (Alpine) | < 150 MB |

Check with: `docker images | grep app-name`
