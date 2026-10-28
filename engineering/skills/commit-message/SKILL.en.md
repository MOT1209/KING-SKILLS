---
name: commit-message
description: Use when writing concise, clear commit messages in the Conventional Commits format.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Commit messages

## When to use
- Writing a commit message for a finished change.
- Improving vague messages such as "fix stuff" or "update".
- Splitting a large change into logical commits.

Do not use when: the request is to describe a whole pull request (`pr-description`).

## Workflow
1. Read the actual changes (`git diff --staged` or equivalent) and do not write the message from file names.
2. Inspect the recent repository history to learn the conventions in use (language, scopes, format), and follow them.
3. Follow the Conventional Commits 1.0.0 specification: `type(scope)!: description`, then a blank line, then an optional body, then optional footers.
4. Choose the type: `feat` for a new feature, `fix` for a bug fix (these two are from the specification itself), and other common types adopted by convention (such as `docs`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `style`) if the repository uses them.
5. Write the description in the imperative or direct present form, concise, with no period at the end, and by convention preferably no longer than about 72 characters.
6. In the body explain "why", not only "what", if the reason is not clear from the description.
7. For a breaking change put `!` after the type/scope and/or a `BREAKING CHANGE: ...` footer describing the impact and the migration path.
8. Link the tasks in the footer if the repository uses that (such as `Refs: ORD-123`).
9. If the change mixes two different things, suggest splitting it into commits.

## Output format
```
<type>(<scope>)<!>: <description>

<body: why + notes>

<footer: BREAKING CHANGE / Refs>
```
And if several options are requested, give one main option and one alternative.

## Rules and limits
- Do not describe what did not actually change.
- Do not put secrets or personal data in the message.
- Do not use `fix` for a new intended behavior change, nor `feat` for an internal cleanup.
- Do not mix several types in one message; split the change.
- Follow the repository's language (English usually); ask if it is not clear.

## Checklist
- The message describes the actual change.
- The type is correct, and the scope matches the repository's conventions.
- A breaking change is explicitly marked.

## Edge cases
- A commit touching several scopes: drop the scope or split the commit.
- Reverting a previous commit: use `revert:` or git's default format with a reference to the identifier.
- A change with no clear reason: ask for the reason instead of guessing.
- A temporary WIP commit: suggest not pushing it as is and squashing it before the merge.

## Full example
### Input
A change in `orders.service.ts` that prevents cancelling shipped orders, with two tests, returning 409 instead of 200. Task ORD-123.

### Output
```
fix(orders): reject cancellation of shipped orders

Cancelling a shipped order previously returned 200 and left the order in an
inconsistent state. Return 409 Conflict for any status other than pending or paid.

Refs: ORD-123
```
The alternative (if the new behavior breaks clients that depend on 200):
```
fix(orders)!: return 409 when cancelling shipped orders

BREAKING CHANGE: POST /orders/{id}/cancellation now returns 409 for shipped orders instead of 200.
```
