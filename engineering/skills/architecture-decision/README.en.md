# architecture-decision — architecture decision (ADR)

> English translation of [README.md](README.md).

## What the skill does
Writes an architectural decision as an ADR: the context, the options with their advantages and disadvantages, the decision, and the consequences.

## When to use it
- You are choosing between two technologies or patterns with a long-term impact.
- You want to record the reason for a decision so it is not forgotten.

## Example requests
1. "Write an ADR for choosing Redis or a message queue for background jobs, our context: [description]."
2. "Document our decision to split the application into two services and why we rejected staying a monolith."

## What to expect
| Item | What you get |
|---|---|
| The file | An ADR with context, options, decision, consequences and a clear status |
| Consequences | Positive and negative together |
| Limits | No invented measurements or costs; what is missing is marked [TBD] |
