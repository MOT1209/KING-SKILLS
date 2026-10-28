---
name: db-schema-design
description: Use when designing relational database tables, relations and indexes, reviewing normalization, and writing a safe migration plan.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Database schema design

## When to use
- Designing tables for a new feature.
- Reviewing an existing schema for normalization and indexes.
- Writing a migration that changes tables containing real data.

Do not use when: the problem is a slow query that needs no schema change (`performance-audit`).

## Workflow
1. Identify the database system (PostgreSQL, MySQL, SQLite…), the ORM and the migration tool in use; read the current schema before designing.
2. Extract the entities and relationships (one-to-one, one-to-many, many-to-many via a join table) from the requirements.
3. Define the primary keys, and the foreign keys with their delete behavior (`RESTRICT`, `CASCADE`, `SET NULL`) by a reasoned decision.
4. Choose the right types: money as an exact decimal type, not floating point; dates with an explicit time zone; and statuses as `CHECK` constraints or an enum type.
5. Set the constraints: `NOT NULL`, `UNIQUE`, `CHECK`, so that the database itself is the last line of defense.
6. Review normalization: no duplicated facts, and if you choose to denormalize for performance, document it.
7. Design the indexes from the actual queries (conditions, joins, ordering), not from guesswork, and watch the column order in a composite index and the write cost.
8. Write a migration plan: small reversible steps, the expand/contract pattern for breaking changes, backfilling data in batches, a backup before execution, and a rollback plan.

## Output format
A textual ER diagram or Mermaid, then `CREATE TABLE`/the migration, then an index table with the query each index serves, then the migration and rollback plan, then assumptions.

## Rules and limits
- Do not run a migration on a real database without an explicit request and a backup.
- Do not add an index without a query that justifies it; ask for the execution plan (`EXPLAIN`) when possible.
- Do not put real data or secrets in the migration examples.
- Do not rely on system-specific SQL syntax without naming the system.

## Edge cases
- A huge table: avoid long locks; use non-blocking index creation if the system supports it, and verify that in its documentation.
- Renaming a live column: add the new one, copy the data, update the code, then drop the old one.
- Soft delete: flag its effect on `UNIQUE` constraints and on queries.

## Full example
### Input
"PostgreSQL. I need tables for orders and their items, every order has a customer. We mostly search by customer and status."

### Output
```sql
CREATE TABLE orders (
  id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_id BIGINT NOT NULL REFERENCES customers(id) ON DELETE RESTRICT,
  status      TEXT NOT NULL CHECK (status IN ('pending','paid','cancelled')),
  total       NUMERIC(12,2) NOT NULL CHECK (total >= 0),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE order_items (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  order_id BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  sku TEXT NOT NULL, qty INT NOT NULL CHECK (qty > 0),
  unit_price NUMERIC(12,2) NOT NULL
);
CREATE INDEX idx_orders_customer_status ON orders (customer_id, status);
CREATE INDEX idx_order_items_order_id ON order_items (order_id);
```
| Index | Serves |
|---|---|
| `(customer_id, status)` | `WHERE customer_id = ? AND status = ?` |
| `order_items (order_id)` | Loading an order's items, and `ON DELETE CASCADE` (PostgreSQL does not index foreign keys automatically) |

Migration: a single reversible migration (`DROP` in reverse order). Assumption: the `customers` table exists.
