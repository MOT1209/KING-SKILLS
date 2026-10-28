---
name: bug-reproduction
description: Use when reproducing a bug with exact steps and writing a failing test that proves it before any fix.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Bug reproduction

## When to use
- A vague or non-repeatable bug report.
- Before fixing a bug: you want to prove it exists and protect the future from its return.
- Turning a user report into a test case.

Do not use when: the request is to determine the cause of a production bug from the logs (`debug-logs`), or to fix the bug itself.

## Workflow
1. Gather the information: what happens, what is expected, the environment and version, the inputs, the logs, the error messages, and how often it occurs.
2. Read the relevant code and identify the possible hypotheses for the cause, ordered by likelihood.
3. Reproduce with the simplest possible steps: start from the original report and then remove everything unnecessary until what remains is the minimum that brings back the bug.
4. Write the numbered reproduction steps: the initial state, the commands or actions, the actual result, the expected result.
5. Write an automated test that fails because of the bug itself (not because of a mistake in the test), at the lowest level at which it can be shown (unit before integration before E2E).
6. Run the test and make sure it fails with the expected message, and attach the output.
7. If you cannot reproduce it: record what you tried, what you lack (data, version, logs), and suggest additional logging.
8. Do not fix the bug within this skill unless asked; hand the failing test to the next step (the fix), and after the fix the same test must pass.

## Output format
```
# Reproduction: <title>
Environment / version:
Steps: 1..n
Actual:   Expected:
Minimum inputs:
Failing test: <code + run output>
Cause hypotheses: ranked
```

## Rules and limits
- Do not claim reproduction without an actual run and output that proves it.
- Do not use real production data or personal data; create anonymous inputs that reproduce the bug.
- Do not hide that the bug is intermittent if it is; state the success rate from actual runs.
- Do not write a test that depends on an internal detail that will change with the fix.

## Checklist
- The test fails before the fix and for the same reason as the bug.
- The minimum inputs are documented.
- The test name describes the faulty behavior that was corrected.

## Edge cases
- A race condition: repeat the runs or introduce a deliberate delay in the test to expose it.
- A bug that appears only in production: ask for the environment settings and add temporary logging instead of guessing.
- A bug that depends on old data: design a synthetic dataset that reproduces its shape.
- A report that does not describe the expected behavior: ask about it before judging that it is a bug.

## Full example
### Input
"Report: the first page in the product list starts from the third item (pages start at 1, and the page size is 2)."

### Output
```
# Reproduction: page 1 skips the first items
Environment: Node, function paginate(items, page, size)
Steps: 1) paginate([1,2,3,4,5], 1, 2)  2) inspect the output
Actual: [3,4]   Expected: [1,2]
Minimum: a list of 5 items, page=1, size=2
```
```ts
it("returns the first items for page 1 (pages are 1-based)", () => {
  expect(paginate([1, 2, 3, 4, 5], 1, 2)).toEqual([1, 2]);
});
```
Run output: `FAIL ... expected [3,4] to equal [1,2]` (it fails for the intended reason, and the function was actually run to verify the output `[3,4]`).
Cause hypothesis: the function uses `page * size` as the slice start, which assumes numbering from 0 while the interface sends numbering from 1. Next: a fix after your approval (`(page - 1) * size`) with a `page >= 1` range check.
