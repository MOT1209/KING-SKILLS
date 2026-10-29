# مسارات العمل | Workflows

تصنيف إنجليزي لمهارات تنفيذ المشاريع الكاملة: إنتاج الفيديو، بناء الألعاب، هوية العلامة، بناء التطبيقات ونشرها، ومراجعة التطبيقات.

An English-first category for end-to-end production skills. Unlike the Arabic-first categories, these packages keep their original `SKILL.md` (mostly English; Arabic for the HVAC content skill) plus the full set of references, scripts and assets they need to run.

## التثبيت | Installation

```bash
scripts/install.sh arabic-shorts
scripts/install.sh workflows --project
```

## المهارات | Skills

| Skill | What it produces |
|---|---|
| `agent-music-video` | Song, story-driven music video and YouTube package |
| `arabic-shorts` | 9:16 shorts with right-to-left Arabic/English captions and publishing copy |
| `build-a-game` | Playable browser game through a ten-step pipeline |
| `create-brand-kit` | Logo system, brand assets and guidelines |
| `create-upstash-software-factory` | Labelled-issue-to-PR agent pipeline |
| `davinci-resolve-video-edit` | Clean foundation cut in Resolve |
| `deploy-an-app` | Next.js app live on Vercel with proof it works |
| `hvac-short-video` | Arabic HVAC short-video scripts and content plans |
| `review-an-app` | Evidence-based security and discoverability audit |
| `start-an-app` | Working full-stack app scaffolded around an interview |

## Notes

- Every package keeps its own `references/`, `scripts/` and `assets/` folders; do not flatten them.
- Many workflows need tools that are not in this repository: local apps (DaVinci Resolve), CLIs (`ffmpeg`, the HyperFrames CLI, the Codex CLI, `gh`), MCP servers, a GPU, or paid accounts (Vercel, Upstash, ElevenLabs, a song generator). `agent-music-video` also needs the separate `/hyperframes`, `/hyperframes-core` and `/music-to-video` skills. Each skill's `README.md` lists its requirements; read it before installing.
- `README.md` is the user-facing guide for each skill. The `SKILL.md` is the instruction file Claude loads.
- These skills are English-first by default because their source material, prompts and tooling are English. The exceptions are `hvac-short-video` and `arabic-shorts`, whose output is Arabic. Arabic-first skills otherwise stay in `writing/`, `productivity/`, `design/` and `engineering/`.
