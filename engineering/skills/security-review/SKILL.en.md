---
name: security-review
description: Use when scanning code for common vulnerabilities such as SQL injection, XSS, exposed secrets and weak access control, with a suggested fix.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Security review

## When to use
- A security review before merging or launching code that handles external input, authentication or sensitive data.
- Scanning a repository for exposed secrets or dangerous patterns.
- Verifying the permissions of API endpoints.

Do not use when: the request is a general code review (`code-review`) or a review of a whole pull request (`pr-review`).

## Workflow
1. Define the scope and the attack surface: entry points (HTTP, messages, files), untrusted data sources, sensitive assets.
2. Check injection: building SQL queries, system commands or file paths by concatenating user text. Fix: parameterized queries, allow-lists, avoiding command execution through a shell.
3. Check XSS: putting user data into HTML without encoding or using `innerHTML`/`dangerouslySetInnerHTML`. Fix: output encoding by context, trusted sanitization where needed, a Content Security Policy (CSP).
4. Check secrets: keys, passwords and tokens in code, logs, committed configuration files or git history. Fix: environment variables or a secrets manager, and rotating any secret that was exposed.
5. Check access control: verifying identity and permission on every endpoint and on every resource (not only hiding buttons), and preventing access to others' resources by changing the identifier (IDOR).
6. Check authentication and sessions: storing passwords with a dedicated slow hashing algorithm, token integrity, session expiry, CSRF protection where needed.
7. Check dependencies and configuration: versions with known vulnerabilities (a dependency scanning tool), overly broad CORS, debug modes enabled in production, leaky error messages.
8. Classify the findings by well-known category names such as the OWASP Top 10 (verify the current version of its list) or CWE, and order them by severity and exploitability.

## Output format
For each finding: the location (file:line), the category (OWASP/CWE), the severity, the description and impact, the suggested fix with a code snippet, then a summary and what was not checked.

## Rules and limits
- Limit yourself to detection and fixes; do not write exploit code or ready-made attack payloads.
- Do not show the full value of a discovered secret in the report; show its location and hide the value, and recommend rotation.
- Do not claim that the code is "secure"; state what was checked and what was not.
- Do not scan systems that the user is not authorized to scan.
- Do not execute the suspicious code.

## Checklist
- Every external input has a validation and encoding path.
- No secrets in the code or the logs.
- Every sensitive endpoint checks the permission on the resource itself.

## Edge cases
- A secret appeared in git history: removing it from the file is not enough; recommend rotation and then cleaning the history by the owner's decision.
- A sanitization/validation library handles the protection: verify that it is actually used on every path.
- False positives: explain why there is no real path from an external input to the spot.

## Full example
### Input
```js
app.get("/users", (req, res) => {
  db.query("SELECT * FROM users WHERE name = '" + req.query.name + "'", (e, rows) => res.json(rows));
});
```
### Output
- Location: `server.js:2`
- Category: SQL injection (OWASP Top 10: the Injection category; CWE-89)
- Severity: high
- Impact: the `name` input is concatenated directly into the query, so an attacker controls its structure.
- Fix:
```js
db.query("SELECT id, name FROM users WHERE name = ?", [req.query.name], (e, rows) => res.json(rows));
```
- Additional note: the `?` placeholder syntax follows the database driver in use (it may be `$1`, for example). And `SELECT *` may return sensitive fields; specify the columns. Not checked: authentication on this endpoint (not visible in the snippet).
