# Repository audit: October 2026

An audit of the whole repository: the 52 skills, the 5 plugins, `scripts/install.sh`, `scripts/validate.sh`, the documentation and the stray `allles news skills/` folder. Each finding below states how it was confirmed, what was done and how the fix was verified. The record for each skill is in [skill-audit.md](skill-audit.md).

Status values: **fixed** (changed and verified), **open** (needs a decision or resource outside this repository), **no change** (checked and left as is, with the reason).

## Findings

| ID | Severity | Where | Evidence (before) | Fix | Verified by | Status |
|---|---|---|---|---|---|---|
| F-01 | Critical | `scripts/validate.sh`, merge-marker check | A copy with `<<<<<<<` in a README printed `ERROR: … merge-conflict markers` but ended `errors: 0` and exit 0: the `err` ran in a pipeline subshell, so the count was lost | Every check feeds the main shell through process substitution | `tests/test_validate.sh` (markers in a `.md` and in a `.py`) | fixed |
| F-02 | Critical | `scripts/install.sh --force` | With a failing `cp`, the old installed skill (and a user file in it) was deleted and nothing was installed | Staged copy, verified, then same-filesystem renames; any failure restores the previous state (exit 3) | `tests/test_install.sh`: copy failure, a failure in the middle of the swap, SIGTERM after each of the 9 renames | fixed |
| F-03 | High | `scripts/install.sh --dest` | `--dest <repo>/design/skills --force` deleted the **source** skill in the repository | Refuses any destination that overlaps a source skill, including paths given with `..` | two tests | fixed |
| F-04 | High | new installer (found by its own test) | The first version of the rollback recorded each rename after it happened; a signal in between left a folder unrecorded, and the cleanup deleted it | Rollback reads the filesystem, not a log; previous versions are never deleted unless the install completed (otherwise exit 4 and the path is printed) | the SIGTERM tests, which failed before this fix | fixed |
| F-05 | High | `allles news skills/` (38 MB) | 12 workflow packages, byte-identical to `workflows/skills/` but without READMEs (`diff -r`); referenced by nothing; ignored by installer and validator | Removed (still in git history at `df5e295`). The validator now rejects any `SKILL.md` outside `<category>/skills/<name>/` | validator test "a SKILL.md outside <category>/skills fails" | fixed |
| F-06 | High | fonts in 3 workflow skills | Poppins and Instrument Serif are SIL OFL 1.1 (their own `name` tables say so), and OFL §2 requires the licence to travel with them; no licence file was present | Added `Poppins-OFL.txt` / `InstrumentSerif-OFL.txt` with each font's own copyright line | file listing; copyright lines read from the TTFs | fixed |
| F-07 | High | `workflows/` provenance | `workflows/README.md` says the packages keep their "original" `SKILL.md`; examples contain another person's paths (`C:/Users/leon/...`) and a YouTube URL; the repository is MIT-licensed as MOT1209's work with no attribution | Owner decision (2026-10-28): the whole repository, including `workflows/`, is released under the MIT License. Bundled third-party files keep their own licences, listed in `THIRD_PARTY_NOTICES.md`. The decision rests on the owner's statement that they hold the rights; it was not independently verified | README licence sections and `THIRD_PARTY_NOTICES.md` | resolved by owner decision |
| F-08 | Medium | validator, headings | A required heading that only appeared inside a fenced code block passed | Headings are checked outside code fences | test | fixed |
| F-09 | Medium | validator, manifests | A duplicate plugin, a missing source folder and a reserved `claude-` prefix all passed (checks were `grep`s) | Manifests are parsed with Python: names, sources, folders, duplicates, prefixes, each `plugin.json` name | 4 tests | fixed |
| F-10 | Medium | validator, links | Broken relative links inside skill READMEs passed | Links in every skill's `SKILL*.md` / `README*.md` and the root docs are checked (code blocks ignored) | 2 tests | fixed |
| F-11 | Medium | validator, workflow front matter | `name:` was searched for in the whole file, so a body line satisfied it | Parsed from the front matter block only | 2 tests | fixed |
| F-12 | Medium | installer, symlinks | A symlink at `<dest>/<skill>` was removed and replaced with `--force`; a regular file there was replaced too | Both are refused, with or without `--force`; the link and its target are untouched. Source skills containing links are refused | 3 tests | fixed |
| F-13 | Medium | `matte_gpu.py` (2 skills) | `subprocess.run(f'npx … {path} …', shell=True)` re-parsed paths with a shell | Argument list with `shutil.which('npx')`, which keeps `npx.cmd` working on Windows | Stubbed `subprocess.run`: an id `b 1;touch PWNED` stays one argument, no shell | fixed |
| F-14 | Medium | `create-video-shorts/examples/.../make_reports.py` | `eval()` on text from a log file | `ast.literal_eval` | parsed a line in the real log format | fixed |
| F-15 | Medium | `start-an-app` Step 2a | Installed six third-party skills globally (`-g -y`) after a one-line announcement, without consent | Waits for a yes; on a no, skips them and researches instead | read-through | fixed |
| F-16 | Medium | 5 workflow READMEs | Requirements contradicted the skills: Upstash README promised Docker/a Dockerfile (the skill uses Box snapshots and no Docker); `agent-music-video` omitted three external skills it cannot run without; Resolve Studio and Node 22/uv missing | Requirement sections rewritten from each `SKILL.md` | read-through against the sources | fixed |
| F-17 | Medium | `db-schema-design` example | No index on `order_items.order_id` although it is the FK used by `ON DELETE CASCADE`; PostgreSQL does not index FKs | Index added in AR and EN with the reason | PostgreSQL 16: Seq Scan (cost 1986) → index scan (cost 23); both files' SQL executes | fixed |
| F-18 | Low | 19 writing/productivity/design skills | No `do not use` cross-references despite overlaps (e.g. `writing-arabic` lists formal letters, `formal-messages` exists) | 11 skills plus `security-review` gained parsed cross-references in both languages; the rest have no overlap | validator resolves every referenced name | fixed |
| F-19 | Low | Mixkit SFX | `sfx_library.py build` downloads 27 non-redistributable Mixkit sounds into each skill folder, where they could be committed | Root `.gitignore` lists those 108 paths, generated from the manifests | `git ls-files -ci --exclude-standard` is empty; manifests stay tracked | fixed |
| F-20 | Low | `validate.sh` on macOS | `declare -A` fails on bash 3.2 with an unclear error | Explicit check, exit 2 with a message | CI macOS job | fixed |
| F-21 | Low | repository | No tests and no CI | `tests/` (62 cases) and `.github/workflows/validate.yml` (Linux + macOS, read-only permissions, checkout pinned to a SHA) | see below | fixed |
| F-22 | Low | `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`, READMEs | Said there were no tests or CI; described `--force` as a plain delete-then-copy | Updated in all of them (both languages where both exist) | validator link and table checks | fixed |
| F-23 | Low | `face_landmarker.task`, `gsap.min.js` | The MediaPipe model ships without a licence notice; GSAP keeps its "standard license" header, whose terms were not reviewed | Listed as unverified in `THIRD_PARTY_NOTICES.md` (also the YuNet `.onnx` model); the owner still needs to confirm the model licences | — | **open** |
| F-24 | Low | workflow scripts and docs | `npx --yes hyperframes` and `vercel@latest` are unpinned | Left as is: `deploy-an-app` and `start-an-app` forbid pinning by design; `agent-music-video/references/lessons.md` already advises the project-pinned CLI | — | no change |
| F-25 | Info | earlier review | The earlier review said the SFX had no licence information. Wrong: `assets/sfx/manifest.json` records source and licence for all 54 sounds, and only the 27 CC0 ones are committed | — | manifest cross-check | no change |
| F-26 | Info | 20 bilingual skills | Section order differs from `_template/` (example before edge cases). The contract requires the headings, not their order | — | — | no change |

## Verification run (final state)

| Command | Result |
|---|---|
| `bash -n` on `scripts/*.sh` and `tests/*.sh` | no errors |
| `bash scripts/validate.sh` | `skills: 52 \| errors: 0 \| warnings: 0`, exit 0 |
| `bash scripts/validate.sh --with-claude` | `skills: 52 \| errors: 0 \| warnings: 0`, exit 0 |
| `claude plugin validate` on `.` and each of the 5 categories | exit 0 for all six (one non-failing advice: `workflows/README.md` has no `/plugin install` line) |
| `bash tests/run.sh` (as root) | install 36 passed, 1 skipped (permissions are not enforced for root); validate 26 passed |
| `bash tests/test_install.sh` as an unprivileged user | 37 passed, 0 skipped |
| The new tests against the **original** scripts | install: 21 of 36 failed; validate: 12 of 26 failed, so the tests detect the defects above |
| `py_compile` on 98 workflow Python files, `bash -n` on 12 shell scripts, `node --check` on 44 JS modules | all pass |
| `git diff --check` | clean |

## Not verified

- Workflow production pipelines (rendering, GPU matting, music generation, Resolve assembly, deployments, paid APIs). Repository rules forbid running them for maintenance; only static checks ran.
- TypeScript/JSX templates inside workflow packages were not type-checked.
- ShellCheck could not run locally; it runs in CI at `--severity=warning`.
- CI does not run `claude plugin validate` (it needs the Claude Code CLI); run `bash scripts/validate.sh --with-claude` locally.
