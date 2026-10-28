# unit-test-writer — unit tests

> English translation of [README.md](README.md).

## What the skill does
Writes unit tests in your project's framework for normal, edge and error cases, without coupling to internal details.

## When to use it
- You are covering a new or uncovered function or class.
- You are turning a discovered defect into a regression test.

## Example requests
1. "Write tests for this `calculateTax` function with Jest: [function]"
2. "The file `cart.service.ts` has no tests, cover its public behavior and its edge cases."

## What to expect
| Item | What you get |
|---|---|
| The tests | A file in your project's framework: normal, edge and error cases |
| Verification | They pass now and fail when the logic is deliberately broken |
| Limits | No real data and no changes to the code under test without your permission |
