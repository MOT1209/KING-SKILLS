---
name: refactor-safely
description: Use when restructuring code in small steps, testing after each step and without changing external behavior.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Safe refactoring

## When to use
- Simplifying a long function, a bloated class or duplication.
- Renaming, moving or separating responsibilities.
- Preparing the code for a new feature without mixing the cleanup with functional change.

Do not use when: the request is to change behavior, add a feature or fix a bug (for a bug: `bug-reproduction`).

## Workflow
1. Define the goal precisely: what the problem is in the current structure and what shape is wanted. Read the code and everything that calls it.
2. Identify the behavior that must stay constant (inputs, outputs and side effects).
3. Run the existing tests and keep the result as a baseline. If coverage is absent from the target area, write characterization tests that pin the current behavior before any change.
4. Split the work into very small steps, each reversible (extract a function, rename, move, remove duplication).
5. Perform one step, then run the tests and the build. Do not move to the next before it passes.
6. Make a separate commit for each logical step if asked, and do not mix bug fixes or features into it.
7. If you discover a defect during the work, record it and report it, and do not fix it as part of the refactoring unless the user agrees.
8. Finish with a comparison: the behavior did not change (the same tests pass), and what improved (line count, complexity, naming).

## Output format
The numbered plan of steps, then for each step: the change and the test result, then a before/after summary, then notes on what was not addressed.

## Rules and limits
- Do not change visible behavior or public interfaces without explicit approval.
- Do not delete a test to make a change pass; if the test checks an internal detail, explain and suggest replacing it.
- Do not refactor code that has no tests and no means of verification without warning the user of the risk.
- Do not add dependencies or features "while you're at it".
- Do not modify files outside the stated scope.

## Checklist
- The tests pass before starting and after each step.
- Each step changes the structure only, not the behavior.
- No tests were deleted or modified to pass the change without explanation.
- The public interfaces did not change, or changed with approval.
- At least one measure improved (complexity, duplication, naming clarity) and can be stated.

## Edge cases
- Brittle tests that fail sometimes: pin the baseline with multiple runs before starting.
- A public interface used outside the repository: keep the old signature with a deprecation warning.
- Conflict with another team's work on the same file: tell the user before a large move.
- Hidden side effects (global state, execution order): pin them with a test first.
- A file with no tests and no possible automated verification: ask the user to accept the risk or start with a documented manual check, and do not move large parts.

## Full example
### Input
"The `calculateTotal` function is long (90 lines) with discount, tax and shipping. Simplify it without changing the output. The existing tests cover 3 cases."

### Output
```
Baseline: 3 tests pass.
Step 1: characterization tests for two uncovered cases (zero discount, free shipping). Result: 5 pass.
Step 2: extract applyDiscount(subtotal, code). Result: 5 pass.
Step 3: extract calculateTax(amount, region). Result: 5 pass.
Step 4: extract calculateShipping(order). Result: 5 pass.
Step 5: rename variables t1/t2 to subtotal/taxAmount. Result: 5 pass.
```
Before/after: 90 lines in a single function → a main function of 12 lines + 3 helper functions. Behavior: unchanged. Note not addressed: rounding is done by two different functions, which needs a decision from you.
