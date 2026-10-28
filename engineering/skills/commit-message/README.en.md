# commit-message — commit messages

> English translation of [README.md](README.md).

## What the skill does
Writes concise, clear commit messages in the Conventional Commits format, marks breaking changes, and suggests splitting mixed changes.

## When to use it
- You are writing a message for a finished change.
- Your old messages are vague like "fix stuff".

## Example requests
1. "Write a commit message for the staged changes."
2. "These are my messages: 'fix stuff', 'update', 'wip'. Rewrite them according to what actually changed."

## What to expect
| Item | What you get |
|---|---|
| The message | `type(scope): description` and a body when needed |
| Breaking changes | An explicit marker with the impact and migration path |
| Limits | No description of what did not change; a mixed change is suggested for splitting |
