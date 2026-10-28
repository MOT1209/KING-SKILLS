---
name: performance-audit
description: Use when analyzing slow code or queries, measuring before and after optimizing.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Performance audit

## When to use
- The user complains that an API endpoint, a page, a query or a job is slow.
- Before an early optimization that is not based on measurement.
- Verifying that an optimization really improved performance.

Do not use when: there is no performance complaint and no measurement (a general review: `code-review`), or a proactive optimization without measurement is requested.

## Workflow
1. Define the problem with a measurable metric: what the operation is, the current time or consumption, and the goal set by the user. Do not assume a goal.
2. Reproduce the slowness under fixed conditions (data, environment, multiple runs) and record the baseline with a suitable measuring tool (a profiler, `EXPLAIN` for queries, timing logs).
3. Identify the bottleneck by measurement, not guesswork: processing, memory, input/output, network, database, or locks.
4. Look for the common causes: repeated queries (N+1), a missing index, fetching excess columns and rows, nested loops, repeated work that can be cached, synchronous operations that can be batched or parallelized, excessive memory allocation.
5. Suggest optimizations ordered by expected impact relative to complexity, and try one at a time.
6. After each change repeat the measurement in the same way and compare with the baseline. Keep the change only if performance clearly improved and behavior stayed correct (run the tests).
7. Check the side effects: increased memory consumption, stale data in the cache, maintenance complexity.
8. Record the results: before/after, what was tried and what was dropped, and what needs monitoring in production.

## Output format
A summary of the problem and the goal, a measurement table (the baseline, after each change), the diagnosis with the evidence, the changes applied, the risks, and follow-up recommendations.

## Rules and limits
- Do not claim an improvement without measuring before and after in the same way; do not invent numbers.
- Do not optimize anything not proven to be a bottleneck.
- Do not sacrifice correctness or readability for a marginal gain.
- Do not run load tests against a production environment without explicit permission.
- Measuring on a development machine does not match production; state that.

## Checklist
- The goal and the metric are defined before any change.
- The baseline is recorded over multiple runs.
- Each change is measured on its own.
- The tests pass after the optimization and the outputs are identical.
- The side effects (memory, stale data) were checked.

## Edge cases
- Large variation between runs: repeat the measurement and give the range, not a single value.
- The slowness appears only with a large data volume: create synthetic test data of a suitable size (not real data).
- The optimization requires changing the database schema: route it through `db-schema-design` and a migration plan.
- The source of the slowness is an external service: suggest timeouts, caching and parallelism instead of optimizing the local code.
- An optimization that clearly raises memory consumption: present the trade-off and leave the decision to the user.

## Full example
### Input
"The `GET /orders` endpoint is slow. It fetches the orders and then queries each order's customer. I don't know the numbers."

### Output
```
Baseline (20 runs, synthetic test data): [to be measured: mean and range]. Queries per request: 1 + N.
Diagnosis: the N+1 pattern — the customer query is inside a loop (orders.service.ts).
Change: fetch the customers in one batch with WHERE id IN (...) and join them in memory.
After the change: measure again the same way: [to be measured]. Queries: 2.
Verification: the endpoint's tests pass, and the outputs are identical.
Risks: a large id list may require chunking. Follow-up: an index on orders.customer_id if it does not exist.
```
(The local numbers are filled from your actual measurements; I do not provide numbers that were not measured.)
