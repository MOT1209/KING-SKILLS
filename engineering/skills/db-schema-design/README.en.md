# db-schema-design — database schema design

> English translation of [README.md](README.md).

## What the skill does
Designs tables, relations and indexes, reviews normalization, and writes a safe, reversible migration plan.

## When to use it
- You are designing tables for a new feature.
- You need a safe migration on a table that holds data.

## Example requests
1. "Design a PostgreSQL schema for a task app: users, projects, tasks and comments."
2. "I want to split the address column in the customers table into fields, write a zero-downtime migration plan."

## What to expect
| Item | What you get |
|---|---|
| The schema | SQL, relations and constraints |
| Indexes | A table linking each index to the query it serves |
| Migration | Small steps and a rollback plan; nothing is run against a real database without your request |
