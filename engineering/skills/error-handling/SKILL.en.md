---
name: error-handling
description: Use when designing error handling, messages and logging consistently across the application's layers.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Error handling

## When to use
- Designing an error strategy for a new service or unifying it in an existing project.
- Reviewing code with an empty `catch`, vague messages or errors leaking to the user.
- Tying errors to logging and response codes.

Do not use when: the request is to analyze an error that actually happened from its logs (`debug-logs`).

## Workflow
1. Read how errors are handled now: the entry points, the middleware, the layers (interface, service, data), and the logging library in use.
2. Classify the errors: input validation errors, expected business errors, external dependency errors (retryable), unexpected programming errors.
3. Define an error hierarchy or fixed machine-readable codes (`code`) independent of the text message.
4. Set the layer rule: each layer catches what it understands and converts or wraps it while keeping the original cause, does not swallow errors, and does not catch and rethrow without adding context.
5. Separate the user message from the technical details: a safe, clear message for the user, and the details in the log only.
6. Set up the logging: an appropriate level for each type, log the error once at the outer boundary to avoid duplication, with structured context (request id, anonymized user, the operation).
7. Define the retry policy for transient failures: a limited count, increasing delay, and only for operations that are safe to repeat.
8. Test the failure paths: a test for each main error type and for converting errors between layers.

## Output format
An error classification table (type, code, response status, user message, log level, retry), then the sample code for the layers, then a list of fixes for the weak spots.

## Rules and limits
- Do not log passwords, tokens, personal data or secrets in logs or messages.
- Do not show a stack trace or query details to the end user.
- Do not use an empty `catch`; if ignoring is intended, document the reason.
- Do not use exceptions for normal control flow.
- Do not change existing response codes without informing the consumers.

## Edge cases
- Asynchronous work (Promise/async): make sure the rejection is caught and not lost.
- Partial failure in a batch operation: handle each item and return a success/failure report instead of failing entirely if appropriate.
- A failure during cleanup (finally): do not hide the original error.
- A background task with no user: log and alert instead of a user message.
- The `cause` option in `new Error(message, { cause })` requires a runtime and type libraries that support ES2022; check the `target`/`lib` in the project, otherwise pass the cause as a custom field.

## Full example
### Input
```ts
try { await db.save(order); } catch (e) { console.log(e); return { ok: false }; }
```
### Output
```ts
class AppError extends Error {
  constructor(readonly code: string, message: string, options?: { cause?: unknown }) {
    super(message, options);
  }
}

try {
  await db.save(order);
} catch (err) {
  logger.error({ err, requestId, orderId: order.id }, "order_save_failed");
  throw new AppError("ORDER_SAVE_FAILED", "Could not save the order", { cause: err });
}
// At the outer boundary: AppError → a 500 response with a safe message + request_id, without leaking err.
```
Changes: `console.log` → a structured log, rethrow with context and the original cause instead of an `ok:false` result that hides the failure. Question: which database errors are retryable in your system?
