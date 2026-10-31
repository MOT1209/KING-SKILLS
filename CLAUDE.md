# CLAUDE.md

Before making changes, read and follow `AGENTS.md` at the repository root. It contains the general engineering, security, documentation, and validation rules for KING-SKILLS. This file adds Claude Code-specific guidance.

## Relationship to AGENTS.md

- `AGENTS.md` is the authoritative maintenance contract for all coding agents. It covers project structure, skill standards, security, validation, documentation, and reporting.
- This file only adds guidance specific to Claude Code and its skill/plugin workflow. It does not replace `AGENTS.md`.
- Claude Code does **not** automatically load `AGENTS.md` for this repository. Read it explicitly at the start of every session before inspecting or editing files.
- If a rule here appears to conflict with `AGENTS.md`, follow `AGENTS.md` and report the conflict instead of silently choosing one rule.
- Keep general rules in `AGENTS.md`. Add a rule here only when it is genuinely specific to Claude Code.

## Current Claude Code Contract

KING-SKILLS currently contains 52 skills in five category plugins: `king-writing`, `king-productivity`, `king-design`, `king-engineering`, and `king-workflows`.

Preserve these verified facts unless the user explicitly requests a change:

- The repository root contains `.claude-plugin/marketplace.json` with the marketplace name `king-skills`. Each category contains its own `<category>/.claude-plugin/plugin.json`. The root does not contain a separate `plugin.json`.
- Arabic-first skills use `SKILL.md` (Arabic) as the instruction file Claude loads. `SKILL.en.md`, `README.md`, and `README.en.md` are supporting files; the English `SKILL.en.md` is not loaded as instructions. Do not swap these roles or rename the files.
- Workflow skills are English-first and require only `SKILL.md` and `README.md`, plus their own supporting folders. Do not apply the Arabic/English pair rules or the six-section line limits to them.
- The documented plugin invocation form is `/king-<category>:<skill>`.
- `scripts/install.sh` copies a skill, category, or all skills into `~/.claude/skills/`, `./.claude/skills/` (`--project`), or a `--dest` directory.
- `scripts/validate.sh` is the repository validation gate. `scripts/validate.sh --with-claude` also runs `claude plugin validate` against the marketplace and each category when the CLI is available.
- No other agent, IDE, or marketplace integration is verified in this repository. Do not describe one as supported without implementing and testing it.

## Before Editing

1. Read `AGENTS.md`, `README.md` or `README.en.md`, and `CONTRIBUTING.md`.
2. Inspect `git status --short` and the current diff so you do not overwrite user work.
3. Read the relevant `<category>/.claude-plugin/plugin.json`, the target skill's `SKILL.md` and READMEs, and any scripts or references the skill depends on.
4. Use the repository's actual commands and paths. Do not assume a script, command, folder, or integration exists because it is common in other Claude projects.

## Claude-Specific Editing Rules

- **Preserve existing contracts.** Do not rename plugins, the marketplace, skill folders, or instruction files; do not change plugin versions, manifests, installation paths, or overwrite behavior unless the requested task requires it.
- **Reserved names.** Do not introduce plugin names starting with `claude-` or `anthropic-`.
- **New standard skills.** Start from `_template/`, not from an unrelated skill. Match the folder name to the frontmatter `name`, keep the strict four-line frontmatter, the six exact headings, and the line-count limits enforced by `scripts/validate.sh`. Write both the Arabic and English instruction files and both READMEs.
- **Workflow skills.** Follow the closest existing workflow package and `workflows/README.md`. Keep `references/`, `scripts/`, `assets/`, `examples/`, `docs/`, and `evals/` in place; do not flatten them or force the standard six-section format.
- **Catalog updates.** When adding or removing a skill, update both root READMEs and the `skills-<total>` badge. When adding a category, update its plugin manifest, the marketplace file, the `CATEGORIES` arrays in both scripts, and both READMEs. `scripts/validate.sh` checks these.
- **No duplicate skills.** Extend the canonical skill or add a documented cross-reference. Do not create a second Claude-specific copy of an existing skill.
- **Plugin and format changes.** Verify any change to `.claude-plugin/` manifests, skill frontmatter, or discovery behavior against the current repository implementation and the official Claude Code plugin/skill documentation. If the documentation and the repository disagree, stop and report the discrepancy; do not guess.
- **Installer changes.** Read `scripts/install.sh` before modifying it. Preserve its refusal to overwrite without `--force`, its `--dry-run` support, its path-safety and symlink checks, and its staged install with rollback; keep `tests/test_install.sh` passing and add a test for every fix. Never run `--force` against a real skills directory; test with `--dry-run` and a temporary `--dest`.
- **Workflow execution.** Do not run a workflow's production pipeline, paid API calls, rendering jobs, or deployments merely to validate repository maintenance. Verify what can be checked statically, and report what remains unrun and why.
- **Other agents.** Do not add an adapter, copy, or compatibility claim for another agent until its official format has been verified and the adapter is tested. Keep shared rules in `AGENTS.md`.

## Validation

Run the repository's actual checks from the repository root in a Bash environment:

```bash
bash -n scripts/install.sh
bash -n scripts/validate.sh
bash scripts/validate.sh
```

When the Claude Code CLI is available, also run:

```bash
bash scripts/validate.sh --with-claude
claude plugin validate .
claude plugin validate ./<category>
```

For any change to `scripts/` or `tests/`, run the test suite (CI runs it too):

```bash
bash tests/run.sh
```

For installer changes, also use the documented smoke checks:

```bash
scripts/install.sh --list
scripts/install.sh <skill> --dry-run --dest /tmp/king-skills-test
```

Before finishing, inspect the complete diff:

```bash
git diff --check
git status --short
git diff
```

Rules for reporting validation:

- Report the exact commands run and their actual results. A successful run ends with a summary such as `skills: 52 | errors: 0 | warnings: 0` (the count may change if skills were added or removed).
- `claude plugin validate` may emit advice or plugin-directory warnings that do not fail validation. Report them separately from errors; do not describe warnings as passes or failures without checking the exit status.
- If `claude`, `python3`, or another optional tool is unavailable, report the skipped check and the reason.
- The shell scripts are stored with LF line endings. A CRLF Windows checkout can make Bash fail with `\r` syntax errors. Validate from a Linux/macOS/WSL checkout or an LF-normalized copy rather than editing the scripts' line endings.
- The only test suite is `tests/` (Bash), run by `.github/workflows/validate.yml` on every push and pull request. Do not invent `npm test`, `pytest`, or similar commands. CI does not run `claude plugin validate`; report that check from a local run or as skipped.

## Reporting and Delivery

Finish with a concise report covering:

- what changed and why;
- the exact files added, modified, or deleted;
- the commands run and their actual results, including warnings and skipped checks;
- any unverified compatibility, environmental limitation, or follow-up work that is genuinely necessary.

Do not claim that files were created, checks passed, or changes were pushed unless those actions actually occurred. Do not commit or push unless the user explicitly asks.
