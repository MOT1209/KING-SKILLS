---
name: api-design
description: Use when designing REST or GraphQL endpoints with consistent naming, unified error codes and clear versions.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# API design

## When to use
- Designing a new API or extending an existing one.
- Reviewing the consistency of an API that grew without rules.
- Defining the error format and the versions.

Do not use when: the request is to design database tables (`db-schema-design`) or only to document an existing API (`technical-docs`).

## Workflow
1. Identify the consumers (web interface, mobile, services) and the core resources and their relationships. If existing APIs exist, read them and follow their conventions.
2. Choose the style: REST for resources and standard operations, and GraphQL when clients need to shape the data flexibly; state the reason.
3. In REST: plural resource names (`/orders`), the verb from the HTTP method, nested relationships at a reasonable depth (`/orders/{id}/items`), and field names in a single style (snake_case or camelCase).
4. Use status codes according to RFC 9110 (such as 200, 201, 204, 400, 401, 403, 404, 409, 422, 429), choose one for each situation and keep it fixed.
5. Unify the error format; Problem Details for HTTP APIs (RFC 9457) is preferred, or a fixed internal format containing: a machine-readable `code`, a `message`, `details`, and a `request_id`.
6. Design pagination, sorting and filtering in a unified form, and set the page limit as a configurable value.
7. For modifications that get retried (payment, for example) consider a safe retry key (Idempotency Key).
8. Define the versioning strategy (a `/v1` path or a header), what counts as a breaking change, and the deprecation policy.
9. In GraphQL: design the schema from the clients' needs, name the types and fields clearly, use input types, design business errors inside the response in a fixed pattern, and watch for the nested query problem (N+1) and for limits on query depth and complexity.
10. Define authentication and authorization for each endpoint: who can do what, and what is returned for each role.
11. Present the schema as OpenAPI or a table, with request and response examples.

## Output format
An endpoint table (method, path, purpose, success statuses, errors), then request and response samples, then an errors and versioning section, then open decisions.

## Rules and limits
- Do not expose internal identifiers that leak the database structure if possible; consider non-sequential identifiers.
- Do not put real secrets or tokens in the examples.
- Do not change the meaning of an existing field within the same version.
- Do not present numeric limits (request rate, page size) as a standard; they are project decisions.

## Edge cases
- Operations that are not CRUD (such as "cancel the order"): use a sub-resource or an event (`POST /orders/{id}/cancellation`) and keep the pattern fixed.
- Deleting a resource tied to others: define 409 or a cascading delete by explicit decision.
- Sensitive fields: not returned by default.
- A large request (file upload): use a dedicated path and a temporary upload link instead of embedding it in JSON.
- Concurrency (concurrent modification of a resource): consider `ETag`/`If-Match` or a version number, and return 409 or 412 by a fixed decision.

## Full example
### Input
"Design a REST API for managing orders: create, view, cancel, with a filterable list."

### Output
| Method | Path | Purpose | Success | Errors |
|---|---|---|---|---|
| POST | /v1/orders | create an order | 201 | 400, 422 |
| GET | /v1/orders | list (`?status=&cursor=&limit=`) | 200 | 400 |
| GET | /v1/orders/{id} | details | 200 | 404 |
| POST | /v1/orders/{id}/cancellation | cancel | 200 | 404, 409 |

```
POST /v1/orders  { "customer_id": "cus_example", "items": [{ "sku": "SKU-1", "qty": 2 }] }
201 { "id": "ord_example", "status": "pending" }

409 { "code": "order_not_cancellable", "message": "Order already shipped", "request_id": "req_example" }
```
Versioning: the `/v1` path, and a breaking change is published under `/v2`. Open question: is a retry key needed for POST /orders?
