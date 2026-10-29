# Per-skill audit record

Every skill below was inspected individually during the October 2026 audit, except `editing-style-coach`, which was added afterwards and is not covered here (see [AUDIT.md](AUDIT.md)). For bilingual skills, the Arabic `SKILL.md` (the file Claude loads) was read in full and compared with `SKILL.en.md` for structure, steps, code blocks and numbers. Workflow packages were read in full; their production pipelines were **not** run (they need GPUs, paid services or desktop apps).

| Skill | Category | Checks | Result |
|---|---|---|---|
| `accessibility-check` | design | AR + EN read, structure parity | WCAG 2.2 SC numbers checked (2.5.8 AA 24x24, 2.5.5 AAA 44x44). Contrast 1.79:1 and 8.27:1 re-computed. Added cross-references. |
| `color-palette` | design | AR + EN read, structure parity | All four contrast ratios re-computed (6.02, 1.79, 8.27, 5.54). Added cross-reference to `accessibility-check`. |
| `design-brief` | design | AR + EN read, structure parity | No defect found; unchanged. |
| `design-handoff` | design | AR + EN read, structure parity | No defect found; unchanged. |
| `icon-set` | design | AR + EN read, structure parity | No defect found; unchanged. |
| `logo-concepts` | design | AR + EN read, structure parity | Added cross-references (`design-brief`, `create-brand-kit`). |
| `social-graphics` | design | AR + EN read, structure parity | Converted the free-form pointer to a parsed `do not use` line; added `create-youtube-thumbnails`. |
| `typography-pairing` | design | AR + EN read, structure parity | No defect found; unchanged. |
| `ui-layout` | design | AR + EN read, structure parity | No defect found; unchanged. |
| `ux-review` | design | AR + EN read, structure parity | Added cross-reference to `accessibility-check`. |
| `api-design` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `architecture-decision` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `bug-reproduction` | engineering | AR + EN read, structure parity | Example re-run: the 0-based slice returns `[3,4]` as stated. |
| `code-review` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `code-scaffold` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `commit-message` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `db-schema-design` | engineering | AR + EN read, structure parity | Example SQL executed on PostgreSQL 16. Added the missing `order_items(order_id)` index (plan: Seq Scan cost 1986 to index scan cost 23). |
| `debug-logs` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `e2e-test-plan` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `error-handling` | engineering | AR + EN read, structure parity | Example type-checked with `tsc --strict`: passes on ES2022, fails on ES2020 exactly as its edge case warns. |
| `feature-spec` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `incident-postmortem` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `performance-audit` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `pr-description` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `pr-review` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `refactor-safely` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `security-review` | engineering | AR + EN read, structure parity | Added cross-reference to `review-an-app` for whole-app audits. |
| `task-breakdown` | engineering | AR + EN read, structure parity | No defect found; unchanged. |
| `technical-docs` | engineering | AR + EN read, structure parity | All four `slugify` example outputs re-run in Node 22 and match. |
| `typescript-strict` | engineering | AR + EN read, structure parity | Example type-checked with `tsc --strict` (passes). |
| `unit-test-writer` | engineering | AR + EN read, structure parity | `applyDiscount` cases re-run: 180, 99.99, 0, 6.7 and three RangeErrors as stated. |
| `data-analysis` | productivity | AR + EN read, structure parity | Example figures re-computed from the sample CSV: 252, 120/132, 47.6%/52.4%, 98 to 154 (+57.1%) all correct. |
| `presentations` | productivity | AR + EN read, structure parity | No defect found; unchanged. |
| `project-planning` | productivity | AR + EN read, structure parity | Added cross-reference to `task-breakdown`. |
| `research-summary` | productivity | AR + EN read, structure parity | No defect found; unchanged. |
| `agent-music-video` | workflows | SKILL.md + README read, referenced paths resolved, scripts syntax-checked | README requirements were incomplete: now names the HyperFrames CLI, the external `/hyperframes`, `/hyperframes-core`, `/music-to-video` skills (not in this repo) and Demucs/SpeechBrain. |
| `arabic-shorts` | workflows | Written from scratch (October 2026); `make_short.py` run end to end, `transcribe.py` checked up to the model download | Captions rendered and inspected for Arabic joining, lam-alef ligatures and mixed Arabic/English order; transcription accuracy on real speech **not yet tested** (the model download was blocked in the build environment). |
| `build-a-game` | workflows | SKILL.md + README read, referenced paths resolved, scripts syntax-checked | No defect found; unchanged. |
| `create-brand-kit` | workflows | SKILL.md + README read, referenced paths resolved, scripts syntax-checked | No defect found; unchanged. |
| `create-upstash-software-factory` | workflows | SKILL.md + README read, referenced paths resolved, scripts syntax-checked | README wrongly mentioned Docker/a Dockerfile; corrected (worker images are Box snapshots). Remote-shell quoting helper `q()` reviewed: correct. |
| `davinci-resolve-video-edit` | workflows | SKILL.md + README read, referenced paths resolved, scripts syntax-checked | README requirements corrected (GPU recommended, not required; ffmpeg and CrisperWhisper listed). |
| `deploy-an-app` | workflows | SKILL.md + README read, referenced paths resolved, scripts syntax-checked | No defect found; unchanged. |
| `hvac-short-video` | workflows | SKILL.md + README read, referenced paths resolved, scripts syntax-checked | No defect found; unchanged. |
| `review-an-app` | workflows | SKILL.md + README read, referenced paths resolved, scripts syntax-checked | No defect found; unchanged. |
| `start-an-app` | workflows | SKILL.md + README read, referenced paths resolved, scripts syntax-checked | Global third-party skill installs now wait for the user's go-ahead, with a fallback when declined. |
| `formal-messages` | writing | AR + EN read, structure parity | Added `do not use` cross-references (`official-documents`, `writing-arabic`). |
| `official-documents` | writing | AR + EN read, structure parity | Added cross-reference to `formal-messages`. Tax arithmetic in the example re-computed: 3000 / 450 / 3450 correct. |
| `social-content-plan` | writing | AR + EN read, structure parity | Added cross-references (`social-graphics`, `hvac-short-video`). |
| `translation-arabic-english` | writing | AR + EN read, structure parity | Added cross-reference to `writing-arabic`. |
| `writing-arabic` | writing | AR + EN read, structure parity | Replaced a free-form exclusion line with a parsed `do not use` line naming `translation-arabic-english` and `formal-messages`. |
