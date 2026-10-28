# security-review — security review

> English translation of [README.md](README.md).

## What the skill does
Scans code for common vulnerabilities (injection, XSS, exposed secrets, weak access control) and suggests a fix for each finding.

## When to use it
- Before merging or launching code that handles external input or authentication.
- You are scanning a repository for exposed secrets.

## Example requests
1. "Review this endpoint for security before merging: [code]"
2. "Search the repository for exposed secrets and SQL injection patterns."

## What to expect
| Item | What you get |
|---|---|
| The findings | Ordered by severity: location, category (OWASP/CWE), impact, fix |
| The scan | What was checked and what was not, stated explicitly |
| Limits | Detection and fixing only: no exploit code and no printing of secret values |
