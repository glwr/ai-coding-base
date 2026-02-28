# API Reference

> Complete API endpoint reference. Updated by `/backend` skill after implementing new endpoints.

## Base URL

- **Local:** `http://localhost:3000/api` _(adjust port to your setup)_
- **Production:** `https://your-app.example.com/api`

## Authentication

_Describe how API authentication works:_

- **Method:** Bearer token / Session cookie / API key
- **Header:** `Authorization: Bearer <token>`
- **Unauthenticated requests:** Return `401 Unauthorized`

## Role Guards

_If endpoints require specific roles:_

| Guard | Required Role | Description |
|-------|--------------|-------------|
| _requireAuth_ | _Any authenticated user_ | _Basic auth check_ |
| _requireAdmin_ | _Admin_ | _Admin-only endpoints_ |

---

## Endpoints

### Auth

#### `POST /api/auth/login`
_Authenticate a user and create a session._

**Request:**
```json
{
  "email": "user@example.com",
  "password": "..."
}
```

**Response:** `200 OK`
```json
{
  "token": "...",
  "user": { "id": "...", "name": "...", "role": "..." }
}
```

**Errors:**
| Status | Description |
|--------|-------------|
| 401 | Invalid credentials |
| 429 | Too many attempts |

---

#### `GET /api/auth/me`
_Get the current authenticated user._

**Response:** `200 OK`
```json
{
  "id": "...",
  "name": "...",
  "email": "...",
  "role": "..."
}
```

---

### Health

#### `GET /api/health`
_Health check endpoint._

**Response:** `200 OK`
```json
{
  "status": "ok",
  "services": {
    "database": "connected",
    "cache": "connected"
  }
}
```

---

### Resources

_Add endpoint documentation for each resource following this pattern:_

#### `GET /api/resources`
_List resources with optional filters._

**Query Parameters:**
| Param | Type | Default | Description |
|-------|------|---------|-------------|
| limit | number | 50 | Max items to return |
| offset | number | 0 | Pagination offset |

**Response:** `200 OK`
```json
{
  "data": [...],
  "total": 100
}
```

---

#### `GET /api/resources/:id`
_Get a single resource by ID._

---

#### `POST /api/resources`
_Create a new resource._

**Auth:** Required
**Body:** _(schema)_

---

#### `PATCH /api/resources/:id`
_Update an existing resource._

**Auth:** Required (owner or admin)

---

#### `DELETE /api/resources/:id`
_Delete a resource._

**Auth:** Required (owner or admin)

---

## Error Format

All errors follow this format:

```json
{
  "error": "Human-readable error message",
  "code": "MACHINE_READABLE_CODE"
}
```

## Common Status Codes

| Status | Meaning |
|--------|---------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request (validation error) |
| 401 | Unauthorized (not logged in) |
| 403 | Forbidden (insufficient permissions) |
| 404 | Not Found |
| 429 | Too Many Requests (rate limited) |
| 500 | Internal Server Error |

---

_Last updated: YYYY-MM-DD_
