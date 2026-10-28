# performance-audit — performance audit

> English translation of [README.md](README.md).

## What the skill does
Analyzes the cause of slowness by measurement, tries optimizations one at a time, and compares before and after in the same way.

## When to use it
- An API endpoint, page or query is slow.
- You want to be sure an optimization really improved performance.

## Example requests
1. "The reporting query takes a long time, this is the query and its EXPLAIN plan: [paste]. What is the cause?"
2. "The product list page is slow in the interface, analyze it and tell me where the bottleneck is."

## What to expect
| Item | What you get |
|---|---|
| The diagnosis | The bottleneck with measured evidence |
| The measurements | A before/after table filled with your actual measurements |
| Limits | No invented numbers and no optimization without measurement |
