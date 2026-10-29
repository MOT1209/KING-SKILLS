<div align="center">

[العربية](README.md) | **English**

<img src="assets/banner.svg" alt="king-SKILLS: Arabic-first skills for Claude" width="100%">

![License: MIT](https://img.shields.io/badge/license-MIT-F2C14E?labelColor=0F1B33)
![Skills: 51](https://img.shields.io/badge/skills-51-F2C14E?labelColor=0F1B33)
![Plugins: 5](https://img.shields.io/badge/plugins-5-F2C14E?labelColor=0F1B33)

</div>

# king-SKILLS

A library of Skills for Claude covering writing, design, software engineering and production workflows. Each skill is a `SKILL.md` that tells Claude how to carry out one task step by step, with a user-facing README and a complete worked example.

## Categories

| Category | Plugin | Skills |
|---|---|---|
| [Writing and translation](#writing-and-translation) | `king-writing` | 5 |
| [Productivity and analysis](#productivity-and-analysis) | `king-productivity` | 4 |
| [Design](#design) | `king-design` | 11 |
| [Software engineering](#software-engineering) | `king-engineering` | 21 |
| [Production workflows](#production-workflows) | `king-workflows` | 10 |

## Installation

**1. As a plugin (easiest):** add this repository as a marketplace, then install the category you want.

```bash
claude plugin marketplace add MOT1209/KING-SKILLS
claude plugin install king-design@king-skills
```

Plugin skills are invoked with the plugin name as a prefix, for example `/king-design:color-palette`. Plugin names: `king-writing`, `king-productivity`, `king-design`, `king-engineering`, `king-workflows`.

**2. With the script:** copies one skill, a category, or everything into a skills directory.

```bash
git clone https://github.com/MOT1209/KING-SKILLS.git && cd KING-SKILLS
scripts/install.sh --list                 # list skills
scripts/install.sh color-palette          # into ~/.claude/skills/
scripts/install.sh design --project       # a whole category into ./.claude/skills/
scripts/install.sh all --force            # everything, replacing existing copies
```

The script never overwrites an existing skill without `--force`, and copies nothing if any target already exists. With `--force` the whole skill folder is replaced by the repository copy, so any edits you made to the installed copy are removed; back them up first if you need them.

- **Safe updates:** skills are first copied into a staging folder inside the destination and checked against their source, then swapped in. If any step fails or the script is interrupted, the previous installation is restored as it was.
- **No symlink following:** a skill path in the destination that is a symbolic link or a regular file is refused, and so is a destination inside the repository's own skill folders.
- **Try it first:** `--dry-run` runs every check and lists what would be installed or replaced, without writing anything.
- **Exit codes:** `0` success, `1` refused (not found, already installed, unsafe path), `2` usage error, `3` failed and the previous state was restored, `4` failed and could not be restored (the previous versions stay in the folder the script names).

**3. Manually:** copy a skill folder (for example `design/skills/color-palette/`) to `~/.claude/skills/` for personal use, or to `.claude/skills/` inside your project.

## Skills

### Writing and translation

| Skill | Description | Docs |
|---|---|---|
| `writing-arabic` | Write, edit and proofread Arabic content with style improvements | [README](writing/skills/writing-arabic/README.en.md) |
| `formal-messages` | Formal business messages: follow-ups, apologies, requests | [README](writing/skills/formal-messages/README.en.md) |
| `official-documents` | CVs, cover letters, quotations and meeting minutes | [README](writing/skills/official-documents/README.en.md) |
| `social-content-plan` | Post ideas, a publishing schedule and copy for Instagram, LinkedIn and TikTok | [README](writing/skills/social-content-plan/README.en.md) |
| `translation-arabic-english` | Arabic–English translation with consistent terminology | [README](writing/skills/translation-arabic-english/README.en.md) |

### Productivity and analysis

| Skill | Description | Docs |
|---|---|---|
| `data-analysis` | Analyze CSV/Excel files and write a report based on computed numbers | [README](productivity/skills/data-analysis/README.en.md) |
| `presentations` | Build 8–12 slide decks with speaker notes | [README](productivity/skills/presentations/README.en.md) |
| `research-summary` | Multi-source research and comparison, with references | [README](productivity/skills/research-summary/README.en.md) |
| `project-planning` | Turn a goal into phases, tasks, dates and risks | [README](productivity/skills/project-planning/README.en.md) |

### Design

| Skill | Description | Docs |
|---|---|---|
| `design-brief` | Turn a vague idea into a clear design brief | [README](design/skills/design-brief/README.en.md) |
| `logo-concepts` | Three logo directions, each tied to the brand's name and values | [README](design/skills/logo-concepts/README.en.md) |
| `color-palette` | A cohesive color palette checked for WCAG AA contrast | [README](design/skills/color-palette/README.en.md) |
| `typography-pairing` | Arabic and Latin font pairing, type scale and line height | [README](design/skills/typography-pairing/README.en.md) |
| `ui-layout` | Screen layout with a fixed grid, button priority and RTL support | [README](design/skills/ui-layout/README.en.md) |
| `ux-review` | Step-by-step task walkthrough with impact-ranked findings | [README](design/skills/ux-review/README.en.md) |
| `accessibility-check` | Contrast, touch targets, alt text and keyboard navigation checks | [README](design/skills/accessibility-check/README.en.md) |
| `icon-set` | Unify an icon set: stroke, grid and states | [README](design/skills/icon-set/README.en.md) |
| `social-graphics` | Post and story graphics sized per platform with consistent branding | [README](design/skills/social-graphics/README.en.md) |
| `design-handoff` | Exact values, component names and interaction states for developers | [README](design/skills/design-handoff/README.en.md) |
| `editing-style-coach` | Learn a tech-YouTube editing style through concepts that work in any editor, with a staged practice plan | [README](design/skills/editing-style-coach/README.en.md) |

### Software engineering

| Skill | Description | Docs |
|---|---|---|
| `code-review` | General code review for bugs, vulnerabilities and performance | [README](engineering/skills/code-review/README.en.md) |
| `feature-spec` | Turn a feature idea into specs with acceptance criteria and edge cases | [README](engineering/skills/feature-spec/README.en.md) |
| `architecture-decision` | Write an ADR: context, options, consequences | [README](engineering/skills/architecture-decision/README.en.md) |
| `api-design` | Design REST/GraphQL endpoints with consistent naming, errors and versions | [README](engineering/skills/api-design/README.en.md) |
| `db-schema-design` | Tables, relations, indexes, normalization review and migration plan | [README](engineering/skills/db-schema-design/README.en.md) |
| `task-breakdown` | Split a feature into small tasks, each with a definition of done | [README](engineering/skills/task-breakdown/README.en.md) |
| `code-scaffold` | Scaffold a new module following the repository's existing patterns | [README](engineering/skills/code-scaffold/README.en.md) |
| `refactor-safely` | Refactor in small steps with tests after each and no behavior change | [README](engineering/skills/refactor-safely/README.en.md) |
| `typescript-strict` | Strict TypeScript: avoid any, use derived types | [README](engineering/skills/typescript-strict/README.en.md) |
| `error-handling` | Consistent error handling, messages and logging across layers | [README](engineering/skills/error-handling/README.en.md) |
| `performance-audit` | Diagnose slowness; measure before and after optimizing | [README](engineering/skills/performance-audit/README.en.md) |
| `unit-test-writer` | Unit tests for normal, edge and error cases | [README](engineering/skills/unit-test-writer/README.en.md) |
| `e2e-test-plan` | End-to-end test scenarios for critical flows | [README](engineering/skills/e2e-test-plan/README.en.md) |
| `bug-reproduction` | Reproduction steps and a failing test before the fix | [README](engineering/skills/bug-reproduction/README.en.md) |
| `security-review` | Find common vulnerabilities: injection, XSS, secrets, access control | [README](engineering/skills/security-review/README.en.md) |
| `pr-review` | Severity-ordered PR review separating blockers from suggestions | [README](engineering/skills/pr-review/README.en.md) |
| `pr-description` | Clear PR descriptions: what changed, why, how to test, risks | [README](engineering/skills/pr-description/README.en.md) |
| `commit-message` | Conventional Commits messages | [README](engineering/skills/commit-message/README.en.md) |
| `technical-docs` | Technical docs for a module or API with examples that actually run | [README](engineering/skills/technical-docs/README.en.md) |
| `incident-postmortem` | Blameless postmortem: timeline, root cause, prevention | [README](engineering/skills/incident-postmortem/README.en.md) |
| `debug-logs` | Log analysis and request tracing across services | [README](engineering/skills/debug-logs/README.en.md) |

### Production workflows

| Skill | Description | Docs |
|---|---|---|
| `agent-music-video` | Turn a story into a song, a beat-synced music video and a YouTube package | [README](workflows/skills/agent-music-video/README.md) |
| `arabic-shorts` | Cut an Arabic or mixed Arabic/English video into vertical shorts with right-to-left captions and publishing copy | [README](workflows/skills/arabic-shorts/README.md) |
| `build-a-game` | Take a one-line game idea to a finished browser game in ten steps | [README](workflows/skills/build-a-game/README.md) |
| `create-brand-kit` | Logo system, brand assets, guidelines and optional merch mockups | [README](workflows/skills/create-brand-kit/README.md) |
| `create-upstash-software-factory` | An issue-to-PR pipeline where coding agents run in Upstash Box sandboxes | [README](workflows/skills/create-upstash-software-factory/README.md) |
| `davinci-resolve-video-edit` | Clean foundation cut in Resolve with retakes and fillers removed | [README](workflows/skills/davinci-resolve-video-edit/README.md) |
| `deploy-an-app` | Put a Next.js app into production on Vercel and prove the live site works | [README](workflows/skills/deploy-an-app/README.md) |
| `hvac-short-video` | Arabic HVAC short-video scripts, hooks, captions and content calendars | [README](workflows/skills/hvac-short-video/README.md) |
| `review-an-app` | Evidence-based security and discoverability audit of an existing app | [README](workflows/skills/review-an-app/README.md) |
| `start-an-app` | Interview, choose a stack and scaffold a working full-stack app | [README](workflows/skills/start-an-app/README.md) |

## Language

The skill instructions are written in Arabic (`SKILL.md`), which is the version Claude uses. Every skill also has `SKILL.en.md` and `README.en.md` as English translations for reading and sharing; they are not loaded as instructions.

The `workflows` category is the exception: those packages are English-first because their source material and tooling are English. They keep their original `SKILL.md` and ship a single user-facing `README.md`.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). In short: copy `_template/` to `<category>/skills/<skill-name>/`, write both the Arabic and English versions, add the skill to its category table here and in `README.md`, and run `scripts/validate.sh` before opening a pull request.

## License

[MIT](LICENSE), covering every skill including `workflows/`. Bundled third-party fonts, libraries, sound effects and models keep their own licences: see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
