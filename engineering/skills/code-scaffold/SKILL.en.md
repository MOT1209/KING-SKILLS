---
name: code-scaffold
description: Use when creating the skeleton of a new module, component or service following the current repository's patterns, naming and file structure.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# New module scaffold

## When to use
- Adding a module, a service, a component or an API endpoint to an existing project.
- The user says "create module X in the style of the rest of the project".

Do not use when: the request is to change the behavior of existing code or reorganize it (`refactor-safely`).

## Workflow
1. Read the repository structure: the folders, `package.json` or its equivalent, the configuration files (lint, tsconfig, formatter).
2. Choose 2 to 3 similar existing modules as references and read them in full: naming, file split, import style, injection, tests.
3. Extract the pattern: file names (kebab-case or otherwise), class and function naming, the location of tests, index files, and registration in the parent module.
4. Define the list of files to be created and what will be modified in existing files (module registration, routes), and show it before creating if the number is large.
5. Create the skeleton with the least possible logic: interfaces, types, signatures and a simple working implementation, no guessed business logic.
6. Create an initial test that passes and proves the skeleton is registered and works.
7. Run the available checks (build, lint, tests) and fix what the skeleton broke.
8. Present a summary of the files created and modified and what remains for the user.

## Output format
The list of files (created/modified) with their paths, the content of each file, the result of running the checks, and a short "next" list.

## Rules and limits
- Follow the repository's pattern even if it differs from your preference; do not introduce a new pattern without stating why.
- Do not add new dependencies without approval.
- Do not write business logic that was not requested; use a clear TODO where a decision is needed.
- Do not put secrets or real data in the examples and the configuration.
- Do not modify the reference modules.

## Edge cases
- There is no similar module: follow the official conventions of the framework and say so.
- Two references that conflict in pattern: follow the newer or the more widely used one and state the choice.
- The build fails because of a conflict unrelated to the skeleton: do not fix it silently; report it.
- A monorepo: respect the package boundaries and the configuration files of each package.

## Full example
### Input
"Create an `invoices` module in a NestJS project in the style of the existing `orders` module."

### Output
After reading `src/orders/` (files: `orders.module.ts`, `orders.controller.ts`, `orders.service.ts`, `dto/`, `orders.service.spec.ts`):
```
created:  src/invoices/invoices.module.ts
created:  src/invoices/invoices.controller.ts
created:  src/invoices/invoices.service.ts
created:  src/invoices/dto/create-invoice.dto.ts
created:  src/invoices/invoices.service.spec.ts
modified: src/app.module.ts  (import InvoicesModule)
```
```ts
// src/invoices/invoices.service.ts
@Injectable()
export class InvoicesService {
  findAll(): Invoice[] {
    // TODO: connect the data source after the schema is approved
    return [];
  }
}
```
Checks: `build` passed, `lint` passed, one test passed. Next: define the fields of `Invoice` and the data source.
