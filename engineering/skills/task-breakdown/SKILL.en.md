---
name: task-breakdown
description: Use when splitting a feature or project into small ordered tasks, each with a clear definition of done.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Task breakdown

## When to use
- You have specifications or a feature and want an execution plan that can be distributed.
- A task looks huge and its size is hard to estimate.
- Preparing tickets for a tracking tool.

Do not use when: there are no clear specifications yet (start with `feature-spec`).

## Workflow
1. Read the specifications or the request, and if there are no specifications suggest using `feature-spec` first or record the assumptions.
2. Read the existing code to identify what can be reused and what must be built.
3. Split the work into small vertical slices that produce verifiable value, not horizontal layers that wait on each other (avoid "all the interfaces, then the whole backend").
4. Make every task completable in one work session or about a day, and if not, split it further.
5. For each task write: a title with a verb, a brief description, a checkable definition of done, the dependencies, and the tests needed.
6. Order the tasks: the least risky and most instructive first, and put forward the tasks that uncover the unknown early.
7. Put risk tasks (a technical experiment, a Spike) under a clear time cap and a defined output.
8. Highlight the critical path and the tasks that run in parallel.

## Output format
A numbered list T1..Tn, for each task: the title, the description, the definition of done, the dependencies, a relative estimate (small/medium/large) marked as an estimate, then a diagram or list of the order and parallelism.

The template for a single task:
```
T<n>: <verb + object>
Description: <two lines at most>
Definition of done: <a checkable sentence>
Depends on: <T..|—>
Tests: <unit/integration/manual>
Estimate: <small|medium|large> (a relative estimate)
```

## Rules and limits
- Estimates are relative and marked as an assumption; do not give days or hours as facts.
- Do not add tasks outside the scope of the request without a warning.
- The definition of done must be checkable by a trial or a test, not "worked on".
- Do not name real people; use roles.

## Edge cases
- The task cannot be split because the unknown is large: make the first task a bounded Spike.
- Tasks depend on a decision not yet made: list it as a "decision" task with a role owner.
- The feature touches the database schema: put the migration as a separate task that can be deployed before the code.
- A feature that can be released gradually: add a task for a feature flag and a task to remove it after stabilization.
- A task that cannot be tested in the development environment: state how it will be verified (a staging environment, post-deploy monitoring).

## Full example
### Input
"Feature: export an invoice to PDF (specifications AC-1..AC-4 as in the previous analysis)."

### Output
| # | Task | Definition of done | Depends on | Estimate |
|---|---|---|---|---|
| T1 | Spike: choose a PDF library that supports Arabic RTL | A short document with the result of trying actual Arabic text | — | small |
| T2 | A PDF generation service for an invoice with few items | A unit test produces a file containing the invoice number and the total (AC-2) | T1 | medium |
| T3 | API endpoint `GET /invoices/{id}/pdf` | Returns 200 for confirmed ones and 409 for drafts (AC-3) | T2 | small |
| T4 | The export button in the interface | The button appears for confirmed invoices only and downloads the file (AC-1) | T3 | small |
| T5 | Multi-page invoices and RTL text | A visual/text test for AC-4 and an invoice with a large number of items | T2 | medium |

Parallelism: T4 and T5 after T3 and T2 respectively. Critical path: T1→T2→T3→T4. The estimates are relative and not a commitment.
