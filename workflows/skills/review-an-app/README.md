# review-an-app

Review a web app that already exists and report what is actually wrong with it — with evidence, not impressions.

## What the skill does

- Checks security against the OWASP Top 10, including input handling, authentication, access control and secrets.
- Checks search and AI discoverability: sitemap, robots.txt, `llms.txt`, structured data and whether the current pages still match what the app claims.
- Looks for claim drift between the landing page, docs and privacy policy and what the product actually does.
- Gathers evidence once, then runs independent review lenses in parallel.
- Re-checks anything uncertain with a command instead of guessing.
- Names every check it could not perform rather than implying it passed.

## When to use

Use it when the user asks to review, audit or check over an app, wants a security review or vulnerability check of a whole codebase rather than a diff, asks whether their sitemap, robots.txt or `llms.txt` are still correct, or suspects their landing page, docs or privacy policy have fallen behind the product.

Do not use it to fix the findings (use the relevant implementation skill), to review a pull request diff (use `code-review`), or to deploy an app (use `deploy-an-app`).

## Example requests

- "Review this app for security holes before we launch."
- "Is our sitemap and llms.txt still accurate after the last release?"
- "Audit the whole codebase, not just this branch."

## What to expect

| Output | Details |
|---|---|
| Findings | Severity-ranked issues with file references and evidence |
| Security review | OWASP Top 10 coverage and exploitability notes |
| Discoverability review | Sitemap, robots, `llms.txt`, metadata and content drift |
| Limitations | Every check that could not be performed, stated explicitly |

## Requirements

Read-only access to the app repository and, when available, a running instance or a URL to verify against. The skill does not change code by default.
