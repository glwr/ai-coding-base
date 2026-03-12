---
name: security
description: Run a comprehensive security audit on recent changes or a specific feature. Checks OWASP Top 10, secrets, dependencies, and access control.
argument-hint: [feature-spec-path or "all" for full audit]
user-invocable: true
context: fork
agent: security-reviewer
model: opus
---

# Security Audit

Run a comprehensive security review of the codebase.

## Before Starting
1. Read `features/INDEX.md` for project context
2. Read `context/learnings.md` for known security issues
3. Read `.claude/rules/security.md` for project security rules

## Determine Scope

If arguments specify a feature (e.g., `features/PROJ-X-name.md`):
- Read the feature spec
- Focus review on files related to that feature
- Use `git log --oneline --grep="PROJ-X" --name-only` to find relevant files

If arguments say "all" or no arguments:
- Review all source files: `git ls-files src/`
- Focus on recent changes: `git diff HEAD~5 --name-only`

## Audit Phases

### Phase 1: Static Analysis
1. Search for hardcoded secrets:
   ```bash
   grep -rn "password\|secret\|api_key\|token\|apiKey\|API_KEY\|PRIVATE_KEY" src/ --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx" | grep -v "node_modules\|.env.example\|test\|spec\|mock"
   ```
2. Check for dangerous patterns:
   ```bash
   grep -rn "dangerouslySetInnerHTML\|eval(\|innerHTML\|document.write\|exec(\|spawn(" src/ --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx"
   ```
3. Check for unparameterized queries:
   ```bash
   grep -rn "query(\`\|query('" src/ --include="*.ts" --include="*.js"
   ```

### Phase 2: Authentication & Authorization Review
1. Find all API routes: `git ls-files src/ | grep -i "api\|route\|endpoint"`
2. For each route, verify:
   - Authentication check exists (session/token verification)
   - Authorization check exists (ownership/role verification)
   - Input validation exists (schema validation on write endpoints)
   - Rate limiting is configured (on auth endpoints)

### Phase 3: Dependency Audit
1. Run dependency vulnerability check:
   ```bash
   npm audit 2>/dev/null || yarn audit 2>/dev/null || pnpm audit 2>/dev/null || echo "No package manager audit available"
   ```
2. Check for overly permissive versions in package.json

### Phase 4: Configuration Review
1. Check `.env.local.example` exists and documents all required env vars
2. Verify no secrets in committed files: `git log --all -p -- "*.env" "*.env.*" | head -50`
3. Check security headers configuration exists
4. Verify CORS configuration if applicable

### Phase 5: Data Flow Analysis
For each user-facing endpoint:
1. Trace input from request to database
2. Verify sanitization at each step
3. Check output encoding before sending to client
4. Verify error responses don't leak sensitive information

### Phase 6: Apple Platform Security (when Platform = Apple)
Skip this phase if Platform is not Apple.

1. Check Keychain usage (secrets must not be in UserDefaults):
   ```bash
   grep -rn "UserDefaults.*password\|UserDefaults.*token\|UserDefaults.*secret\|UserDefaults.*key" --include="*.swift"
   ```
2. Check App Transport Security exceptions:
   ```bash
   grep -rn "NSAppTransportSecurity\|NSAllowsArbitraryLoads\|NSExceptionDomains" --include="*.plist"
   ```
3. Check Privacy Manifest exists and covers required reason APIs:
   ```bash
   ls **/PrivacyInfo.xcprivacy 2>/dev/null
   grep -rn "NSPrivacyAccessedAPIType\|NSPrivacyTracking" --include="*.xcprivacy"
   ```
4. Check for hardcoded secrets in Swift code:
   ```bash
   grep -rn 'let.*[Kk]ey.*=.*"\|let.*[Ss]ecret.*=.*"\|let.*[Tt]oken.*=.*"' --include="*.swift" | grep -v "test\|spec\|mock\|preview"
   ```
5. Check entitlements for unnecessary capabilities:
   ```bash
   cat *.entitlements 2>/dev/null
   ```
6. Verify data protection on sensitive files:
   - Check for `FileProtectionType` usage on file writes
   - Verify `NSFileProtectionComplete` for sensitive data

## Output

### Step 1: Write Full Report
Write the complete audit report to `reports/security/YYYY-MM-DD-[scope].md` using the template from [report-template.md](report-template.md). Include every finding with severity, file:line, OWASP category, risk, fix, and code example.

### Step 2: Update Feature Spec (if scoped to a feature)
Add a brief Security Audit section to the feature spec file:
```markdown
## Security Audit
**Date:** YYYY-MM-DD
**Report:** [reports/security/YYYY-MM-DD-PROJ-X.md](../reports/security/YYYY-MM-DD-PROJ-X.md)
**Result:** X findings (Y critical, Z high)
**Recommendation:** Fix critical/high findings | Ready for QA
```

### Step 3: Create Bug Entries for ALL Findings
For EVERY finding (all severities — Critical, High, Medium, and Low):
1. Read `features/INDEX.md` to find the "Next Bug ID: BUG-X" counter
2. Read `.claude/skills/tracking-guide.md` for tracking operations (variant detection: File-based or GitHub Issues)
3. Create a bug file in `backlog/BUG-X-name.md` using `backlog/bug-template.md`
   - Set Source to `/security` and reference the security report in the "Related Report" field
4. If Tracking = GitHub Issues, create a GitHub Issue:
   ```bash
   gh issue create --title "BUG-X: [title]" --label "type:bug,priority:pX,status:open" --body "[description, OWASP category, risk, fix suggestion]"
   ```
5. Add the bug to the Backlog table in `features/INDEX.md` (include issue link if GitHub Issues)
6. Increment the "Next Bug ID" counter in `features/INDEX.md`
7. If a finding is immediately fixed in the same session, set status to Fixed/Done and close the GitHub Issue

**IMPORTANT:** Process findings sequentially — read the "Next Bug ID" counter fresh before each finding to avoid ID collisions.

### Step 4: Git Commit
```
security(PROJ-X): Add security audit report

- Report: reports/security/YYYY-MM-DD-scope.md
- Findings: X total (Y critical, Z high)
```

### Step 5: Context Updates
If findings are relevant for future development, draft entries for `context/learnings.md`:
```markdown
### [IMPORTANT] [Security Finding Title]
- **Date:** YYYY-MM-DD
- **Feature:** PROJ-X (or "General")
- **Skill:** /security
- **Learning:** [What was found and what to watch for]
- **Rationale:** Prevent this vulnerability pattern in future features
```

Show context updates to the user for approval before writing.

## Handoff
After completion:
> "Security audit complete. [X findings: Y critical, Z high, ...]"
> "Full report: `reports/security/YYYY-MM-DD-scope.md`"
> If issues found: "Fix these issues, then re-run `/qa` to verify nothing broke, and `/security` to confirm fixes."
> If clear: "No security issues found. Ready for `/release`."
