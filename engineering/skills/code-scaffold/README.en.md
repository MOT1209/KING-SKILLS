# code-scaffold — new module scaffold

> English translation of [README.md](README.md).

## What the skill does
Reads your existing modules and creates a new module in the same style: naming, file split, registration, and an initial test.

## When to use it
- You are adding a module, a service or a component to an existing project.
- You want your project's patterns followed without manual copying.

## Example requests
1. "Create a new React component named `PaymentForm` in the style of the other components in `src/components`."
2. "Add a `notifications` service to the project with the same structure as the `users` service."

## What to expect
| Item | What you get |
|---|---|
| The files | A skeleton in your project's pattern and registration in the parent module |
| Verification | An initial test and the result of the build and checks |
| Limits | No guessed business logic and no new dependencies without your approval |
