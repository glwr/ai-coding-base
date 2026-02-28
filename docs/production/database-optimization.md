# Database Optimization

## 1. Indexing

Create indexes on columns used in WHERE, ORDER BY, or JOIN clauses:

```sql
-- Without index: ~500ms at 100k rows
SELECT * FROM tasks WHERE user_id = 'abc123' ORDER BY created_at DESC;

-- After creating index: <10ms
CREATE INDEX idx_tasks_user_id_created ON tasks(user_id, created_at DESC);
```

**Rule of thumb:** If a column appears in WHERE or ORDER BY and the table will have >1000 rows, add an index.

Always include indexes in your migration SQL alongside CREATE TABLE.

## 2. Avoid N+1 Queries

The most common performance problem with ORMs and query builders. An N+1 query happens when you:
1. Fetch a list of records (1 query)
2. For each record, fetch related data in a loop (N queries)

**Fix:** Use joins or eager loading to fetch related data in a single query.

```
-- Bad: 1 query for users + N queries for each user's tasks
SELECT * FROM users;
-- then for each user:
SELECT * FROM tasks WHERE user_id = ?;

-- Good: Single query with join
SELECT users.*, tasks.* FROM users
LEFT JOIN tasks ON tasks.user_id = users.id;
```

Check your ORM/query builder docs for the specific join or eager-loading syntax.

## 3. Always Limit Results

Never return unbounded results from the database:

```sql
-- Bad: Returns ALL rows
SELECT * FROM tasks;

-- Good: Returns max 50 rows
SELECT * FROM tasks LIMIT 50;

-- Better: Paginated with offset
SELECT * FROM tasks LIMIT 50 OFFSET 0;
```

Use your ORM's `.limit()`, `.take()`, or equivalent method on all list queries.

## 4. Caching Strategy

For data that changes rarely (dashboard stats, config, categories), use your framework's caching mechanism.

**When to cache:**
- Data that changes less than once per hour
- Expensive aggregation queries
- Data shared across all users (not user-specific)

**When NOT to cache:**
- User-specific data that changes frequently
- Real-time data

## 5. Select Only What You Need

```sql
-- Bad: Fetches all columns
SELECT * FROM users;

-- Good: Fetches only needed columns
SELECT id, name, avatar_url FROM users;
```

Use your ORM's select/projection method to fetch only the columns you need.
