# System Architecture

> Project-wide architecture overview. Created by `/architecture project` and updated as the system evolves.

## System Overview

_Replace with an ASCII diagram showing the main components and data flow:_

```
Browser
  │
  ├── Authentication (e.g. OAuth, OIDC)
  │       │
  │       v
  ├── Frontend App
  │       │
  │       v
  ├── Backend / API
  │       │
  │       ├── Database
  │       └── External Services
  │
  └── Real-Time (WebSocket / SSE / Polling)
```

## Packages / Modules

_Document each major package or module in the project:_

### Package: _name_
- **Purpose:** _What this package does_
- **Key exports:** _Main types, functions, or classes_
- **Dependencies:** _What it depends on_

## Authentication Flow

_Describe the authentication flow step by step:_

1. User navigates to login page
2. _..._
3. Session is created

## Authorization / Roles

_Document user roles and their permissions:_

| Role | Description | Permissions |
|------|-------------|-------------|
| _User_ | _Standard user_ | _Read own data, create items_ |
| _Admin_ | _Administrator_ | _Full access_ |

## Data Model

_Describe the core data entities and their relationships:_

### Entity: _name_
| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique identifier |
| _field_ | _type_ | _description_ |

## API Proxy / Gateway Pattern

_If the frontend proxies API calls through a backend-for-frontend or gateway, document the pattern here:_

```
Browser → Frontend Server → Backend API → Database
```

## Caching Strategy

_Document what is cached, where, and for how long:_

| Key Pattern | TTL | Description |
|-------------|-----|-------------|
| _example_ | _5m_ | _What is cached_ |

## Real-Time Updates

_If the app uses real-time features (SSE, WebSockets, polling), document the architecture:_

- **Transport:** _SSE / WebSocket / Polling_
- **Channel structure:** _How events are routed_
- **Event types:** _What events are published_

## Key Design Decisions

_Link to `context/decisions.md` for the full decision log. Summarize the most important ones here:_

1. **_Decision title_** — _Brief rationale_

---

_Last updated: YYYY-MM-DD_
