# bug-reproduction — bug reproduction

> English translation of [README.md](README.md).

## What the skill does
Turns a bug report into exact reproduction steps with the minimum inputs, and a failing test that proves the bug before the fix.

## When to use it
- A vague or non-repeatable bug report.
- You want a test that protects against the bug's return after it is fixed.

## Example requests
1. "Users say search sometimes returns no results in Arabic, reproduce the bug and write a test that proves it."
2. "This is a stack trace from production: [paste]. I want reproduction steps and a test case."

## What to expect
| Item | What you get |
|---|---|
| The steps | Numbered, with actual vs. expected and the minimum inputs |
| The test | Fails for the bug's own reason, with actual run output |
| If reproduction fails | What was tried and what is missing instead of a claim of success |
