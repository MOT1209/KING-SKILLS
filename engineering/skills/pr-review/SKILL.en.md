---
name: pr-review
description: Use when reviewing a pull request, ordering the findings by severity and separating mandatory ones from suggestions.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Pull request review

## When to use
- Reviewing a Pull Request before merging.
- Writing organized review comments for another developer.
- Assessing merge readiness.

Do not use when: the request is to write the PR description (`pr-description`) or an in-depth security check (`security-review`).

## Workflow
1. Read the PR description and the linked task to understand the intent, then read the whole diff, and open the surrounding files when needed.
2. Check that the change matches the intent: does it solve the stated problem, and are there changes outside the scope.
3. Check correctness: logic, edge cases, error handling, concurrency, database migrations, backward compatibility.
4. Check the tests: do they cover the change and fail if the logic breaks? And were they run, or do CI results appear?
5. Check security and performance quickly (inputs, secrets, queries inside loops) and refer to `security-review` when needed.
6. Check maintainability: naming, duplication, function size, consistency with the repository's patterns, documentation for public changes.
7. Verify each finding by tracing a real path to the defect before writing it; drop what is unconfirmed or mark it a "question".
8. Classify: **mandatory (blocks the merge)**, **important (preferably before the merge)**, **suggestion (nit/optional)**, **question**. For each write: the location, the problem, the reason, the proposed fix.
9. End with a verdict: ready to merge / ready after addressing the mandatory / needs more work, and what you liked.

## Output format
A summary of 2–3 sentences and the verdict, then the findings grouped by classification and ordered by severity, then the questions, then the good aspects.

## Rules and limits
- Every mandatory finding must explain the actual harm, not a stylistic preference.
- Separate style (nit) from bugs and do not block the merge because of it.
- A respectful tone directed at the code, not the person.
- Do not include findings on old code the PR did not touch except as a separate non-blocking note.
- Do not approve or reject the merge on behalf of the decision owner; give a recommendation.

## Edge cases
- A huge PR: start with the major risks and suggest splitting it, and do not claim a detailed review of what you did not read.
- Generated changes (lockfile, built files): check the governing logic, not the lines.
- A conflict between the PR description and the code: ask before judging.
- No tests: state the risk and suggest the minimum required.

## Full example
### Input
A PR adding order cancellation: the `cancelOrder` function updates the status to `cancelled` without checking the current status, with no tests.

### Output
**Verdict:** ready after addressing the mandatory.

**Mandatory**
1. `orders.service.ts:42` — no check of the current status: a `shipped` order can be cancelled. Reason: it creates an inconsistent state and could lead to a refund after shipping. Fix: reject cancellation except from `pending`/`paid` and return 409.

**Important**
2. No tests for the function. Add at least two cases: a successful cancellation, and an attempt to cancel a shipped order.

**Suggestion**
3. (nit) Name the variable `res` something clearer like `updatedOrder`.

**Question**
4. Is a notification sent to the customer upon cancellation? I did not find that in the description.

**Good:** a clear separation between the service and the controller.
