# typescript-strict — strict TypeScript

> English translation of [README.md](README.md).

## What the skill does
Writes or fixes TypeScript with strict types: replaces `any` with `unknown` and safe narrowing, and uses derived types and discriminated unions.

## When to use it
- You are converting a JavaScript file to TypeScript.
- Your project is full of `any` and `as` and you want to tighten it gradually.

## Example requests
1. "Convert this file from JavaScript to strict TypeScript: [file]"
2. "Scan my project for risky `any` and `as` and suggest alternatives ordered by priority."

## What to expect
| Item | What you get |
|---|---|
| The code | Strict types, type guards and derived types |
| The summary | What was replaced and why, and the `tsc --noEmit` result |
| Limits | No silencing of errors with `any` or `@ts-ignore` |
