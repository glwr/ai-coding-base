# Security Audit Report Template

Write the full report to `reports/security/YYYY-MM-DD-[scope].md` where scope is the feature ID (e.g., `PROJ-1`) or `full-audit`.

```markdown
# Security Audit Report

**Date:** YYYY-MM-DD
**Scope:** PROJ-X ([Feature Name]) | Full Codebase Audit
**Auditor:** Security Reviewer (AI)
**OWASP Top 10 Version:** 2021

## Summary

| Severity | Count |
|----------|-------|
| Critical | 0     |
| High     | 0     |
| Medium   | 0     |
| Low      | 0     |
| Info     | 0     |

**Overall Risk Level:** Critical | High | Medium | Low | Clean
**Recommendation:** Fix critical/high findings before deployment | Ready for deployment

## Findings

### FINDING-1: [Finding Title]
- **Severity:** Critical | High | Medium | Low | Info
- **OWASP Category:** A01:2021 Broken Access Control | A02:2021 Cryptographic Failures | A03:2021 Injection | A04:2021 Insecure Design | A05:2021 Security Misconfiguration | A06:2021 Vulnerable Components | A07:2021 Auth Failures | A08:2021 Data Integrity Failures | A09:2021 Logging Failures | A10:2021 SSRF
- **Location:** `src/path/to/file.ts:42`
- **Description:** What the vulnerability is and why it matters
- **Risk:** What an attacker could do if this is exploited
- **Fix:** Step-by-step instructions to remediate
- **Code Example:**
  ```typescript
  // Before (vulnerable)
  const data = req.body.input;
  db.query(`SELECT * FROM users WHERE id = ${data}`);

  // After (fixed)
  const data = req.body.input;
  db.query('SELECT * FROM users WHERE id = $1', [data]);
  ```

### FINDING-2: [Finding Title]
_(same structure as above)_

## Dependency Audit

| Package | Current | Vulnerability | Severity | Fix |
|---------|---------|--------------|----------|-----|
| example | 1.0.0   | CVE-XXXX-XXXX | High    | Upgrade to 1.0.1 |

## Configuration Review
- [ ] `.env.local.example` exists and documents all env vars
- [ ] No secrets in committed files
- [ ] Security headers configured
- [ ] CORS properly configured (if applicable)

## Action Items
- [ ] **[Critical]** Fix FINDING-1: [brief description]
- [ ] **[High]** Fix FINDING-2: [brief description]
- [ ] **[Medium]** Address FINDING-3: [brief description]
```
