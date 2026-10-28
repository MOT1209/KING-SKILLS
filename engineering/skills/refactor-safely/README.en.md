# refactor-safely — safe refactoring

> English translation of [README.md](README.md).

## What the skill does
Refactors code in small reversible steps, running the tests after each step and preserving behavior.

## When to use it
- Long or duplicated code you want to simplify without changing its behavior.
- You are preparing the code for a new feature without mixing the cleanup into it.

## Example requests
1. "Split this huge `OrderManager` class into clearer responsibilities without changing its behavior."
2. "Remove the duplication between these two functions and make sure the tests pass after each step."

## What to expect
| Item | What you get |
|---|---|
| The plan | Small steps with the test result after each |
| The summary | Before/after and what improved |
| Limits | No behavior change; defects found are reported and not silently fixed |
