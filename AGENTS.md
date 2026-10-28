# AGENTS.md

Instructions for AI coding agents working on the KING-SKILLS repository. Read this file before making changes. `CLAUDE.md` adds Claude Code-specific guidance and assumes this file has already been read.

## Project Overview

KING-SKILLS (shown as `king-SKILLS`) is a library of Claude Code skills organized into five categories and distributed as Claude Code plugins or copied skill folders. It currently contains **53 skills** and **5 plugins**:

| Category | Plugin | Skills | Content |
|---|---|---|---|
| `writing` | `king-writing` | 5 | Arabic writing, formal messages, official documents, social content, Arabic–English translation |
| `productivity` | `king-productivity` | 4 | Data analysis, presentations, research summaries, project planning |
| `design` | `king-design` | 11 | Design briefs, logos, color, typography, UI, UX review, accessibility, icons, social graphics, handoff, video editing style |
| `engineering` | `king-engineering` | 21 | Specs, architecture, APIs, databases, coding, testing, security, pull requests, docs, incidents |
| `workflows` | `king-workflows` | 12 | End-to-end production workflows: video, music videos, games, brand kits, app scaffolding, deployment, app review |

The repository's primary language is Arabic:

- `writing`, `productivity`, `design`, and `engineering` are **Arabic-first**. Each skill has an Arabic `SKILL.md` (the file Claude loads), an English `SKILL.en.md` translation, and matching Arabic/English user READMEs.
- `workflows` is **English-first** because its source material and tooling are English. `hvac-short-video` is the exception that produces Arabic content. Workflow packages ship only `SKILL.md` and `README.md` plus the `references/`, `scripts/`, `assets/`, `examples/`, `docs/`, or `evals/` folders they need.

Repository content is primarily Markdown and JSON. Automation uses Bash. Individual workflow skills also contain Python, JavaScript/HTML/CSS, and media assets where required.

### Distribution and integrations

The only documented and verified integrations are Claude Code's:

1. **Plugin marketplace** — `.claude-plugin/marketplace.json` (marketplace name `king-skills`) lists the five `king-*` plugins. Each category has its own `<category>/.claude-plugin/plugin.json`.
2. **Installer** — `scripts/install.sh` copies skill folders into `~/.claude/skills/` by default, `./.claude/skills/` with `--project`, or a directory passed with `--dest`.
3. **Manual copy** — the READMEs document copying a skill folder into a Claude skills directory.

Do not claim that any other agent, IDE, or skill marketplace is supported unless its integration has been implemented and tested in this repository. There is no repository-level package manager or build step. Shell tests for the installer and validator live in `tests/` (plain Bash, run with `bash tests/run.sh`), and `.github/workflows/validate.yml` runs the validator and those tests on every push and pull request. A GitHub pull request template also exists.

## Core Engineering Principles

- Inspect the current files, Git state, documentation, scripts, and target skill before editing.
- Prefer small, focused changes that solve the requested problem. Do not refactor or reformat unrelated content.
- Preserve existing behavior, metadata, paths, plugin names, and Arabic/English structure unless the task explicitly requires a change.
- Do not duplicate an existing skill. Search the repository first and extend or cross-reference the canonical skill instead.
- Avoid unnecessary dependencies and generated files. Do not introduce a build system, linter, formatter, or package manager unless the task requires it and the need is documented.
- Follow the existing naming, directory, frontmatter, heading, and documentation conventions.
- Keep `README.md` and `README.en.md` consistent, including skill counts, badges, category tables, and relative links.
- Do not commit, push, tag, or open a pull request unless the user explicitly asks.

## Skill Authoring Standards

### Standard categories

The canonical layout for a skill in `writing`, `productivity`, `design`, or `engineering` is:

```text
<category>/skills/<skill-name>/
├── SKILL.md          # Arabic instructions, loaded by Claude
├── SKILL.en.md       # English translation, not loaded as instructions
├── README.md         # Arabic user documentation
└── README.en.md      # English user documentation
```

Follow the naming convention in `CONTRIBUTING.md` (lowercase English letters and hyphens), and make `name` match the folder exactly. `scripts/validate.sh` enforces the match. It also enforces the following structure:

- For standard skills, the frontmatter must be the first four lines and in this exact order:

  ```yaml
  ---
  name: <folder-name>
  description: <one sentence describing when to use the skill and what it does>
  ---
  ```

- `SKILL.md` must be 60–120 lines and contain these exact second-level headings:

  - `## متى تُستخدم`
  - `## خطوات العمل`
  - `## صيغة المخرجات`
  - `## قواعد وحدود`
  - `## حالات حدّية`
  - `## مثال كامل`

- `SKILL.en.md` must be 60–125 lines and contain these exact headings:

  - `## When to use`
  - `## Workflow`
  - `## Output format`
  - `## Rules and limits`
  - `## Edge cases`
  - `## Full example`

- `README.md` must contain `## ما الذي تفعله المهارة`, `## أمثلة على الطلبات`, and `## ماذا تتوقع`.
- `README.en.md` must contain `## What the skill does`, `## Example requests`, and `## What to expect`.
- The contributing standard expects each skill to include a "do not use when" line when its scope overlaps another skill, naming the better-suited skill in backticks. `scripts/validate.sh` verifies that every skill name referenced this way exists.
- Arabic and English instruction files should stay close in length; the validator warns when they differ by more than 10 lines.

Use `_template/` as the starting point for a new standard skill. Do not hand-write a different structure.

### Workflow skills

`workflows` is a deliberate exception:

- `SKILL.md` and `README.md` are required and non-empty.
- `SKILL.md` must have YAML frontmatter containing `name` (matching the folder) and `description`, but the strict four-line frontmatter rule does not apply.
- `README.md` must contain `## What the skill does`, `## Example requests`, and `## What to expect`.
- The six-section Arabic/English rule and the 60–120 line limits do not apply.
- Keep `references/`, `scripts/`, `assets/`, `examples/`, `docs/`, and `evals/` intact and relative to the skill folder. Do not flatten or relocate their contents.
- Workflow packages may depend on external tools, paid APIs, local applications, or models. Do not add new dependencies silently; document prerequisites in the skill's own `README.md` and `SKILL.md`.

### Content quality

- Do not invent sources, measurements, quotations, or capabilities. Cite standards by their exact names.
- Do not put real personal data, credentials, API keys, or confidential material in skills, examples, or docs. Use clear placeholders.
- Examples containing numbers, code, or commands must have been actually run and their results verified.
- Keep instructions actionable and specific: inputs, ordered steps, output format, limits, edge cases, and a worked example.
- Write natural Arabic and English. Do not translate skill names, code identifiers, commands, or file paths. Keep terminology consistent within a skill.
- Avoid unnecessary duplication between skills. Prefer a short cross-reference to the canonical skill.
- When adding or removing a skill, update both root READMEs: the category table, the Markdown link, and the `skills-<total>` badge. `scripts/validate.sh` enforces these.

## Multi-Agent Compatibility

KING-SKILLS is currently a Claude Code-oriented repository. Its runtime contract is Claude Code's skill and plugin format; `AGENTS.md` is the shared maintenance contract for any coding agent that edits the repository. Maintenance should stay agent-neutral so different coding agents can work here, while the shipped skill runtime stays Claude Code-specific until another format is implemented and verified.

- Treat each agent's instruction discovery mechanism, skill format, installation path, and metadata schema as distinct.
- Verify a proposed integration against that agent's official documentation before implementing it. Do not infer support from similar file names.
- Reuse the canonical skill content. If another agent needs a different manifest or discovery layout, add a thin, documented adapter that points to the canonical source rather than forking the skill.
- Do not claim that a skill or integration works with an agent until the format and behavior have been verified in this repository.
- Document unsupported capabilities and limitations honestly. A missing integration is better than an untested claim.
- Keep Claude-specific requirements in `CLAUDE.md`; keep this file neutral across agents.
- Do not silently rename or move `SKILL.md`, category folders, or plugin manifests to satisfy another format.

## Security

- Never add secrets, tokens, credentials, private URLs, or personal data to the repository. Use placeholders in examples.
- Inspect `scripts/install.sh`, `scripts/validate.sh`, and any workflow script before changing them.
- `scripts/install.sh` refuses to overwrite existing skill folders unless `--force` is given. It copies every selected skill into a staging folder inside the destination, verifies the copy, then swaps folders in with renames; on any failure or interruption it restores the previous installation (exit code 3), and it never deletes previous versions it could not restore (exit code 4). It never follows or replaces symbolic links and refuses a destination that overlaps the repository's skill folders. With `--force`, the replaced folder's old contents, including local edits, are removed after the swap succeeds. Do not run it against a real skills directory without explicit confirmation; use `--dry-run`, `--list`, and a temporary `--dest` directory for tests, and keep `tests/test_install.sh` passing.
- Any change to installation path handling must validate inputs and keep writes inside the intended destination. Do not introduce path traversal, broad recursive deletes, or unsafe shell expansion.
- Do not execute untrusted code, download and run installers, or add dependencies merely to inspect a skill. Workflow skills may invoke expensive production tools and paid services; those actions require the user's explicit request and should not be triggered as repository maintenance.
- Avoid destructive filesystem or Git operations: no `git reset --hard`, `git clean -fd`, force-push, history rewriting, or deletion of user files unless the user explicitly authorizes it.
- Never remove or overwrite user changes. Check `git status` and the diff before editing.
- Validate external input, file paths, URLs, and generated filenames where relevant. Do not assume a path or command is safe because it appears in an existing document.

## Testing and Validation

Run commands from the repository root in a Bash environment that handles the repository's LF scripts (Linux, macOS, WSL, or an equivalent setup):

```bash
bash -n scripts/install.sh
bash -n scripts/validate.sh
bash scripts/validate.sh
```

`scripts/validate.sh` is the repository's validation gate. It checks, among other things:

- category plugin manifests and their entries in `.claude-plugin/marketplace.json`;
- duplicate skill names;
- required files, frontmatter, exact headings, and line counts;
- README sections, root README tables, links, and badge counts;
- referenced skill names in "do not use" lines;
- skill folder names (lowercase letters, digits and single hyphens) and that skill folders are not symbolic links;
- `SKILL.md` files outside `<category>/skills/<name>/` (stray copies or an unregistered category);
- that both scripts use the same `CATEGORIES` list;
- relative links in the root docs and in every skill's `SKILL*.md` and `README*.md` (links inside code blocks are ignored);
- required headings outside code blocks (a heading that only appears in an example does not count);
- JSON validity, the marketplace's plugin names, sources and reserved prefixes, and each `plugin.json` name (when `python3` is available);
- skill descriptions longer than Claude Code's 1,536-character listing limit (a warning);
- merge-conflict markers in any text file;
- the number of skills reported by `scripts/install.sh --list`.

It exits non-zero whenever it reports an error, and needs bash 4 or newer (macOS ships bash 3.2; install a newer one with Homebrew).

Optional integration check, when the Claude Code CLI is installed:

```bash
bash scripts/validate.sh --with-claude
claude plugin validate .
claude plugin validate ./<category>
```

`--with-claude` invokes `claude plugin validate` for the marketplace and every category. If `claude` or `python3` is missing, the script reports a warning and skips that check; report the skip rather than claiming it passed.

Tests, required after any change to `scripts/` or `tests/` (CI runs the same command):

```bash
bash tests/run.sh
```

They build every case in private temporary directories and never touch a real skills directory. Add a regression test for every defect you fix in either script.

Additional checks for relevant changes:

```bash
scripts/install.sh --list
scripts/install.sh <skill> --dry-run --dest /tmp/king-skills-test
git diff --check
git status --short
git diff
```

Notes:

- The only test suite is `tests/` (Bash). Do not invent commands such as `npm test`, `pytest`, or `make test`.
- CI (`.github/workflows/validate.yml`) runs on GitHub's Linux and macOS runners with read-only permissions and no secrets. It does not run `claude plugin validate`; run `--with-claude` locally when the CLI is available. A red CI run is a failure to fix, not to bypass.
- The shell scripts are stored with LF line endings. On Windows, a CRLF working tree can make Bash report `\r` syntax errors. Run validation from a Linux/macOS/WSL checkout or an LF-normalized copy; do not rewrite the scripts solely to work around a local checkout.
- Run the validation appropriate to the change. A documentation-only change still needs the validator when it touches README tables, links, counts, or skill metadata.
- Do not weaken, bypass, or delete validation checks to make a change pass. If the repository standard itself must change, update `_template/`, `CONTRIBUTING.md`, both scripts, and affected skills consistently, and explain the migration.
- Never report a check as passed unless it was actually executed successfully. State failures, skipped checks, and environmental limitations.

## Documentation

- Update documentation only when the requested change requires it.
- Keep `README.md`, `README.en.md`, `CONTRIBUTING.md`, `workflows/README.md`, and each skill's README accurate and consistent with the implementation.
- When adding or removing a skill, update the category table in both root READMEs and the badge count.
- When adding a category, create `<category>/.claude-plugin/plugin.json` named `king-<category>`, add the marketplace entry, add the category to `CATEGORIES` in both scripts, and update the READMEs, as described in `CONTRIBUTING.md`.
- Do not add plugin names beginning with `claude-` or `anthropic-`; those prefixes are reserved.
- Explain installation, usage, validation, and compatibility only where the repository actually supports them. Do not add marketing claims or unverified compatibility matrices.

## Required Workflow

For non-trivial tasks:

1. **Inspect** the repository state, relevant docs, scripts, and skill folders.
2. **Identify** the problem, constraints, and affected contract.
3. **Plan** the smallest coherent implementation and state any assumptions.
4. **Implement** only the necessary changes, following the existing conventions.
5. **Validate** with the repository's actual scripts and relevant checks.
6. **Review** the diff for regressions, security issues, unintended file changes, and secrets.
7. **Report** the result accurately.

Use judgment for small tasks: a typo or a single documentation correction does not need a formal plan, but it still needs inspection and an appropriate check.

## Final Report

After completing a task, summarize:

- What changed and why.
- The exact files added, modified, or deleted.
- The checks actually run and their results, including warnings and skips.
- Any known limitations, unverified compatibility, or environmental constraints.
- Any genuinely necessary follow-up work.
