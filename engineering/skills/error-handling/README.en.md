# error-handling — error handling

> English translation of [README.md](README.md).

## What the skill does
Designs consistent error handling: classification, fixed codes, safe user messages, structured logging, and a retry policy.

## When to use it
- You are designing an error strategy for a new service.
- You find an empty catch or errors leaking to the user.

## Example requests
1. "Review the error handling in the payment service and tell me where errors are swallowed or leak to the user."
2. "Design a unified error strategy for the Express backend with a central middleware."

## What to expect
| Item | What you get |
|---|---|
| Classification | A table: type, code, response status, message, log level |
| The code | A sample for the layers with context and the original cause |
| Limits | No secrets or personal data in logs |
