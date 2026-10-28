---
name: architecture-decision
description: Use when writing an architectural decision as an ADR (Architecture Decision Record) documenting the context, options, decision and consequences.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Architecture decision (ADR)

## When to use
- Choosing a technology, a pattern or a service boundary with a long-term impact.
- Recording a decision that was made verbally so its reason is not forgotten.
- Reviewing or superseding an old decision.

Do not use when: the request is to document a feature's requirements (`feature-spec`) or to design a detailed API (`api-design`) or tables (`db-schema-design`).

## Workflow
1. Gather the context: the problem and the forces at play (requirements, team constraints, budget, existing commitments). Read the relevant code or documents if any.
2. State the required decision in one sentence.
3. List two to four real options, including "do nothing" where possible.
4. For each option: the advantages, disadvantages and risks, against the forces listed in step 1.
5. Choose a decision, or leave it "proposed" if it is not settled, with reasoning tied to the forces and not to preference.
6. Write the consequences: the positive ones, the negative ones, what will become harder, and what must be done after the decision.
7. Set the status: proposed, accepted, rejected, superseded, with a link to the superseding decision.
8. Name the file with a sequential number and a short description (such as `0007-use-postgres-for-orders.md`) unless the repository has a different pattern.

## Output format
```
# <number>. <decision title>
Status: <proposed|accepted|rejected|superseded>   Date: <YYYY-MM-DD>
## Context
## Options
### Option A ... advantages / disadvantages
## Decision
## Consequences
```
The format is based on the Architecture Decision Records pattern known from Michael Nygard (title, status, context, decision, consequences) with an extra options section.

## Rules and limits
- Do not invent performance measurements or costs; put [TBD] or ask for the measurement.
- Do not judge an option as "the best" without tying it to this project's constraints.
- Do not hide the disadvantages of the chosen option.
- Decisions are written in the direct present tense and are not edited after acceptance; a change is made through a new decision that supersedes it.

## Edge cases
- The decision is not settled: leave the status "proposed" and state what is needed to settle it.
- Only one option is actually possible: document the reason and that the alternatives are excluded by a specific constraint.
- A decision that affects other teams: name them in the context as needing to review it.

## Full example
### Input
"We need a database for the order system: PostgreSQL or MongoDB? Our team knows SQL, the data is relational, and we need transactions."

### Output
```
# 0007. Use PostgreSQL for order data
Status: proposed   Date: 2026-10-26
## Context
Order data is relational (customers, orders, items), and requires atomic transactions across tables. The team has SQL experience.
## Options
### A. PostgreSQL
+ ACID transactions and referential constraints, team experience. - Horizontal scaling is harder.
### B. MongoDB
+ Schema flexibility. - Multi-document transactions are more complex, and there is no in-house experience.
## Decision
We adopt PostgreSQL.
## Consequences
+ Data integrity through constraints. - A schema that requires migrations. Later: choose a migrations tool.
```
