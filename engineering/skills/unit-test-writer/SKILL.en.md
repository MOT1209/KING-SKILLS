---
name: unit-test-writer
description: Use when writing unit tests for normal cases, edge cases and errors without testing the internal details of the implementation.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Writing unit tests

## When to use
- Adding tests for a new or uncovered function or class.
- Covering missing edge cases or errors in existing tests.
- Turning a discovered defect into a regression test (for details on reproduction use `bug-reproduction`).

Do not use when: the request is to test a complete flow through the interface (`e2e-test-plan`), or to prove a specific bug before fixing it (`bug-reproduction`).

## Workflow
1. Read the target code and its public contract: inputs, outputs, thrown errors, side effects, dependencies.
2. Read the project's existing tests to learn the test framework (Jest, Vitest, pytest, JUnit…) and the style of naming, organization and mocks, and follow it.
3. List the cases: normal (the happy path), edge (empty, zero, maximum/minimum, category boundaries), and errors (invalid input, a dependency failing).
4. Test the visible behavior, not the internal implementation: do not verify calls to private functions or internal order unless it is part of the contract.
5. Follow the Arrange / Act / Assert structure, one logical case per test, and a name that describes the expected behavior (`returns_zero_for_empty_cart`).
6. Use test doubles (mocks/stubs/fakes) for external boundaries only (network, time, randomness, files), and prefer a simple Fake over a Mock with many expectations.
7. Make the tests deterministic: no reliance on real time, order, or data shared between tests.
8. Run the tests and make sure they pass, then temporarily disable the behavior (or invert a condition) to make sure the test really fails when the logic breaks.

## Output format
The test file or files in the adopted framework, a list of the cases covered, the run result, and what was not covered and why.

## Rules and limits
- Do not change the code under test to make testing easier without approval, and state it.
- Do not write a test that always passes (with no real assertions).
- Do not put real data or secrets in the test data.
- Do not depend on the results of other tests.
- Do not invent undocumented behavior; if the contract is ambiguous, ask or document the assumption.

## Checklist
- Every important conditional branch has a case.
- Every thrown error has a test.
- The names describe the behavior, not the function.
- The test fails when we deliberately break the logic.

## Edge cases
- A time-dependent function: inject a fake clock.
- An impure function that is hard to isolate: suggest separating the logic from the dependency instead of a heavy mock.
- Asynchronous code: await the result explicitly and test the rejection too.
- Arabic/Unicode inputs: add a case of text with Arabic and Latin letters if the function processes text.

## Full example
### Input
```ts
export function applyDiscount(price: number, percent: number): number {
  if (price < 0 || percent < 0 || percent > 100) throw new RangeError("invalid input");
  return Math.round(price * (1 - percent / 100) * 100) / 100;
}
```
### Output
```ts
import { describe, it, expect } from "vitest";
import { applyDiscount } from "./discount";

describe("applyDiscount", () => {
  it("reduces the price by the given percent", () => {
    expect(applyDiscount(200, 10)).toBe(180);
  });
  it("returns the same price for 0 percent", () => {
    expect(applyDiscount(99.99, 0)).toBe(99.99);
  });
  it("returns 0 for 100 percent", () => {
    expect(applyDiscount(50, 100)).toBe(0);
  });
  it("rounds to two decimals", () => {
    expect(applyDiscount(10, 33)).toBe(6.7);
  });
  it.each([[-1, 10], [10, -1], [10, 101]])("throws RangeError for (%s, %s)", (p, d) => {
    expect(() => applyDiscount(p, d)).toThrow(RangeError);
  });
});
```
Cases covered: normal, edge (0 and 100), rounding, errors. Not covered: `NaN`/`Infinity` values (the contract does not define them; question: should they be rejected?).
