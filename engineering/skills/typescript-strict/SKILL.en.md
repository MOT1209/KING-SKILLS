---
name: typescript-strict
description: Use when writing or reviewing TypeScript with strict types, avoiding any, using derived types and safe narrowing.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Strict TypeScript

## When to use
- Writing new TypeScript code or converting JavaScript.
- Reviewing code full of `any` or `as` assertions.
- Gradually enabling strict mode in an existing project.

Do not use when: the project is in another language, or a general code review is requested (`code-review`).

## Workflow
1. Read `tsconfig.json`: is `strict` enabled? Are options such as `noUncheckedIndexedAccess` and `exactOptionalPropertyTypes` enabled? And limit yourself to what the project's TypeScript version supports.
2. Inspect the weak spots: explicit `any`, unnecessary `as`, `!` (non-null assertion), `@ts-ignore`, and functions without a return type in public interfaces.
3. Derive types instead of repeating them: `typeof`, `keyof`, `ReturnType`, `Parameters`, `Pick`, `Omit`, `Partial`, `Required`, `Record`, and conditional and mapped types where needed.
4. Replace `any` with `unknown` for external data, then narrow it with type guards or with runtime validation (such as a validation library compatible with the project).
5. Use discriminated unions instead of scattered optional fields, and check exhaustiveness with `never` in `switch`.
6. Make data immutable where possible: `readonly`, `as const`, `satisfies` for checking without widening the type.
7. Clean up the types at system boundaries (API responses, JSON, environment variables): do not trust their types without validation.
8. Run `tsc --noEmit` and the lint and fix the errors, and if they are many split the fix across files.

## Output format
The modified code with strict types, then a list of what was replaced and why, then the `tsc` result, then what needs the user's decision.

## Rules and limits
- Do not use `any` or `@ts-ignore` to silence an error; if necessary use `@ts-expect-error` with a reason comment and a task reference.
- Do not narrow a type with `as` without actual validation.
- Do not raise the strictness level across the whole project at once without approval.
- Do not change runtime behavior while improving types except by adding intended validation.

## Checklist
- No new explicit `any`, and no `@ts-ignore`.
- Every `as` has a justification or was replaced by a type guard.
- External data is read as `unknown` and then validated.
- `tsc --noEmit` succeeds with no new errors.
- Modern features (such as `satisfies`) are used only if the project's TypeScript version supports them.

## Edge cases
- A third-party library without types: write a limited declaration file (`.d.ts`) and do not use a blanket `any`.
- Indexing an object with a dynamic key: use `Record` or `Map` while handling the possibility of `undefined`.
- Complex circular types: simplify them instead of building deep conditional types that are hard to read.
- Huge legacy code: enable strictness on new files first.

## Full example
### Input
```ts
function getUser(data: any) { return { id: data.id as number, name: data.name }; }
```
### Output
```ts
type User = { readonly id: number; readonly name: string };

function isUser(v: unknown): v is User {
  return typeof v === "object" && v !== null
    && typeof (v as Record<string, unknown>).id === "number"
    && typeof (v as Record<string, unknown>).name === "string";
}

function getUser(data: unknown): User {
  if (!isUser(data)) throw new TypeError("Invalid user payload");
  return { id: data.id, name: data.name };
}
```
Changes: `any` → `unknown` with a type guard, removed the unsafe `as number`, an explicit return type, `readonly` properties. Question: do you prefer a validation library that already exists in the project instead of the manual guard?
