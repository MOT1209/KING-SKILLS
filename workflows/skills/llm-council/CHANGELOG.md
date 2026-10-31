# Changelog

All notable changes to `llm-council` are documented here. This project follows [Semantic Versioning](https://semver.org/).

## [1.0.0] - 2026-10-31

First stable release.

### Added

- Five advisor lenses: Contrarian, First Principles Thinker, Expansionist, Outsider, Executor.
- Anonymous peer review with rotated labels and five review questions.
- Chairman verdict with Decision Card, TL;DR, agreement/clash sections, assumption conflicts, recommendation, change triggers, and first step.
- Quick mode: 3 advisors, no peer review, 300-500 words.
- Deep mode: standard council + Red Team + Evidence Check, 800-1200 words, about 12 calls.
- Brief mode: 3 advisors, no peer review, one-screen 150-250 words, 3 calls.
- Retrospective mode for reviewing logged or user-supplied decisions and calibration.
- Opt-in decision log at `council-decisions/YYYY-MM-DD-<slug>.md`.
- Optional model-diverse councils when the environment supports per-sub-agent model selection.
- Language propagation: advisors, reviewers, chairman, and headings follow the user's language.
- Prompt-injection defense, privacy rules, and graceful single-agent fallback.
- Confidence, key assumptions, and "what would change my mind" on every advisor response.
- Transcript template with raw/framed question, advisor responses, peer reviews, verdict, and gaps.
- Minimum viable council threshold and degraded-council labeling.
- PR/code-review routing to `pr-review` or `code-review`.
- Retrospective accepts decisions from the user's message or the decision log.
- Evals covering full council, no auto-invoke, quick mode, prompt injection, deep mode, brief mode, retrospective, Arabic, transcript saving, PR routing, degraded councils, single-agent mode, and stress-test failure handling.

### Changed

- Clarified the boundary with lighter council workflows.
- Clarified mode selection, deep/brief length limits, and trigger routing.
- Expanded privacy and prompt-injection rules to reviewers and the chairman.
- Expanded the README with modes, cost, language/safety, installation, and usage.
- Moved the annotated example to `references/example.md` to keep `SKILL.md` focused.

### Security

- Workspace files, advisor outputs, and reviewer outputs are treated as untrusted data.
- Secrets, credentials, and personal data are excluded from advisor, reviewer, and chairman prompts.
