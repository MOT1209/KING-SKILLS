# security-audit

Turn a coding agent into a source-first security auditor: reconnaissance, coverage-led hunting, adversarial validation, and a report with evidence and the smallest effective fix.

## What the skill does

- Maps the architecture, trust boundaries, input surfaces, and prior evidence into `architecture.md` and `coverage-ledger.json`.
- Assigns isolated hunters from ledger units, records what each one checked, and uses coverage critics to find gaps.
- Gives every unique candidate to a fresh verifier that tries to disprove it, so the finder is never the judge.
- Writes `confirmed`, `needs_validation`, and `rejected` records to `findings.json` and validates them against `report-schema.json`.
- Derives `REPORT.md`, `FINDINGS-DETAIL.md`, and `NEEDS-VALIDATION.md` from the verified records and the coverage ledger.
- Keeps runs additive: later audits use prior ledgers and findings to target gaps and revalidate changed source.
- Treats a candidate without a concrete affected principal, resource, or security outcome as not a finding.

## When to use

Use it when the user asks for a security audit or pen test of a codebase, API, service, CLI tool, library, or daemon, wants vulnerability research or a review of a specific finding, or needs audit report artifacts.

The skill stays in guidance mode for security questions and focused reviews. It runs the full six-phase workflow only for an explicit codebase audit or pen-test request, a full or end-to-end review, or a request for report artifacts.

Do not use when the task is a single pull request diff (use `security-review`), an app-wide security and discoverability review (use `review-an-app`), or fixing the findings it reports (use the relevant implementation skill).

## Example requests

- "Security audit this codebase and write the report to an external folder."
- "Find vulnerabilities in `./src`, and validate every candidate before reporting it."
- "Review our authentication and session handling for real boundary failures."
- "We ran an audit last month. Check the code that changed since then."

## What to expect

| Output | Details |
|---|---|
| `architecture.md` | Trust boundaries, input surfaces, and prior evidence for the target |
| `coverage-ledger.json` | Audit units, what was checked, and the gaps still open |
| `findings.json` | `confirmed`, `needs_validation`, and `rejected` records, validated against `report-schema.json` |
| `REPORT.md` | Target-neutral summary of confirmed findings, ranked by severity |
| `FINDINGS-DETAIL.md` | Source evidence, safe reproduction, and the smallest effective fix per finding |
| `NEEDS-VALIDATION.md` | Exact unresolved fact for every lead that could not be confirmed |
| Limits | Checks that could not be performed are named explicitly instead of being implied as passed |

## Requirements

- A coding agent with a model that supports tool use and parallel sub-agents.
- Node.js for the zero-dependency findings and coverage-ledger validators.
- An OS-enforced sandbox for target-controlled builds, tests, processes, browsers, emulators, fuzzers, and fixtures: no external network, an allowlisted environment, resource limits, and writes only to assigned scratch paths. Without those controls the skill keeps the lead as `needs_validation` instead of executing target code.
- Source inspection is read-only. Full audit mode writes its artifacts to a new directory outside the target, defaulting to `~/security-audit-skill/<repo-name>/run-<N>`.

## Files

| File | Purpose |
|---|---|
| `SKILL.md` | Setup, operating modes, safety rules, workflow overview, and anti-patterns |
| `RECONNAISSANCE.md` | Phase 1 reconnaissance prompts and synthesis instructions |
| `HUNTING.md` | Phase 2 orchestration, hunting methodology, and validation rules |
| `ATTACK-CLASSES.md` | Core, wildcard, and obvious-things attack prompts |
| `MEMORY-SAFETY-AND-BINARY.md` | Memory-safety, binary, and kernel hunting classes for native targets |
| `AI-AND-LLM.md` | Prompt-injection, agent/tool, and output-handling hunting classes for LLM-backed targets |
| `WEB-PROTOCOL-AND-AUTH.md` | HTTP request-framing, cache, and authentication-protocol classes |
| `CLIENT-SIDE.md` | DOM-injection, messaging-trust, UI-redress, and prototype-pollution classes |
| `SUPPLY-CHAIN-AND-RELEASE.md` | Dependency, CI, release, signing, update, plugin, and extension classes |
| `CLOUD-AND-DEPLOYMENT.md` | IAM, infrastructure-as-code, container, serverless, ingress, and runtime-config classes |
| `PROTOCOLS-RPC-AND-MESSAGING.md` | RPC, serialization, queue, broker, webhook, and streaming-protocol classes |
| `RESOURCE-EXHAUSTION-AND-AVAILABILITY.md` | Shared resource, quota, queue, worker, and operator-spend classes |
| `DATA-ISOLATION-AND-LIFECYCLE.md` | Tenant isolation, cache, search, export, backup, migration, and deletion classes |
| `DESKTOP-MOBILE-AND-LOCAL-IPC.md` | Native app, deep-link, webview, exported-component, and local-IPC classes |
| `VALIDATION-AND-REPORTING.md` | Phases 3–6 candidate validation, structured output, record verification, and reporting |
| `report-schema.json` | JSON schema for all three `findings.json` verdicts |
| `validate-findings.cjs` | Zero-dependency validator for `findings.json` |
| `validate-coverage-ledger.cjs` | Zero-dependency validator for `coverage-ledger.json` |
| `*.test.cjs` | Tests and fixture checks for both validators |

## Attribution

This skill is vendored from Cloudflare's `security-audit-skill` (MIT — see [LICENSE](LICENSE)). It seeded the vulnerability discovery harness described in [Build your own vulnerability harness](https://blog.cloudflare.com/build-your-own-vulnerability-harness).
