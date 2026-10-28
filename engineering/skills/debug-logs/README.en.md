# debug-logs — log analysis

> English translation of [README.md](README.md).

## What the skill does
Traces a single request through the logs and the services, identifies the first abnormal point, and suggests hypotheses ranked by evidence and what is missing to confirm them.

## When to use it
- A production error whose logs are your only evidence.
- You are tracing a request across multiple services.

## Example requests
1. "These are the logs of three services for a failed request (id r-42), where is the problem? [paste logs]"
2. "This log file contains thousands of errors, what are the main patterns and the likeliest cause?"

## What to expect
| Item | What you get |
|---|---|
| The conclusion | The likeliest cause with a confidence level |
| The path | A table of time, service, event and the first abnormal point |
| Limits | Sensitive data hidden and no invented lines |
