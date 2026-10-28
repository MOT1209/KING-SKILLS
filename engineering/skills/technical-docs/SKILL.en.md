---
name: technical-docs
description: Use when writing technical documentation for a module or an API with examples that actually run.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Technical documentation

## When to use
- Documenting a module, a function, an API or an internal tool.
- Writing a README for a project or a quick-start guide.
- Updating documentation that has gone stale after a code change.

Do not use when: the request is an incident report (`incident-postmortem`) or an architecture decision (`architecture-decision`).

## Workflow
1. Identify the audience (a new developer, an API consumer, an operator) and what they want to accomplish, since this sets the depth.
2. Read the actual code and tests, and do not document from names alone. Run the commands and examples to learn the real behavior.
3. Build the structure: what this tool is and why, installation and requirements, a quick start with a working example, the reference (signatures, parameters, return values, errors), advanced examples, limitations and FAQs.
4. For each public element write: the purpose in a sentence, the parameters with their types, whether they are required and their defaults, the return value, the possible errors.
5. Write small, complete examples that can be copied and run, then **run them for real** and copy the actual outputs into the documentation.
6. Document the common errors and how to solve them, the known limitations, and compatibility (versions).
7. Be consistent in terminology and formatting, and link between pages and sections.
8. Add a last-reviewed date or a related version if the repository has a pattern for that, and a list of what is not covered.

## Output format
A Markdown file (or the repository's format) with the sections: overview, installation, quick start, reference, examples, errors, limitations.

## Rules and limits
- Every example must have been actually run, and the outputs shown are the real outputs.
- Do not put secrets, real data or internal addresses in the examples; use clearly fake values.
- Do not describe behavior that does not exist or is planned as if it exists.
- Do not invent version numbers or performance benchmarks.
- Keep the documentation close to the code (the same repository) as much as possible.

## Checklist
- Every example was run and its output is real.
- Every public parameter is documented with its type and default.
- Errors and limitations are stated.
- No sensitive data.

## Edge cases
- Code without tests and with unclear behavior: document what you actually verified and mark the rest "unconfirmed".
- A bilingual or RTL interface: add an example with Arabic text if the tool processes text.
- An interface in flux: mark it explicitly as experimental.
- Arabic documentation for code with English names: keep the code names as they are inside code marks.

## Full example
### Input
```js
export function slugify(text) {
  return text.trim().toLowerCase().replace(/[^\p{L}\p{N}]+/gu, "-").replace(/^-+|-+$/g, "");
}
```
### Output
````markdown
## slugify(text)

Converts text into a link-safe identifier: lowercase letters, and every run of non-letter/non-digit characters becomes `-`.

**Parameters**
| Name | Type | Required | Description |
|---|---|---|---|
| `text` | `string` | yes | The text to convert |

**Return value:** `string` — may be empty if the text contains no letters or digits.

**Examples** (actually run)
```js
slugify("  Hello, World!  ");     // "hello-world"
slugify("مرحبا بالعالم");          // "مرحبا-بالعالم"
slugify("!!!");                   // ""
slugify("Node.js 22 Release");    // "node-js-22-release"
```

**Limitations:** a non-string `text` fails at `trim`; type checking is the caller's responsibility.
````
