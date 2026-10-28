# مسارات العمل | Workflows

تصنيف إنجليزي لمهارات تنفيذ المشاريع الكاملة: إنتاج الفيديو، بناء الألعاب، هوية العلامة، بناء التطبيقات ونشرها، ومراجعة التطبيقات.

An English-first category for end-to-end production skills. Unlike the Arabic-first categories, these packages keep their original `SKILL.md` (mostly English; Arabic for the HVAC content skill) plus the full set of references, scripts and assets they need to run.

## التثبيت | Installation

```bash
scripts/install.sh create-video-shorts
scripts/install.sh workflows --project
```

## المهارات | Skills

| Skill | What it produces |
|---|---|
| `agent-music-video` | Song, story-driven music video and YouTube package |
| `build-a-game` | Playable browser game through a ten-step pipeline |
| `create-brand-kit` | Logo system, brand assets and guidelines |
| `create-upstash-software-factory` | Labelled-issue-to-PR agent pipeline |
| `create-video-shorts` | 9:16 shorts with graphics, captions and publishing copy |
| `create-youtube-thumbnails` | Tested 1280×720 thumbnail variants |
| `davinci-resolve-pro-edit` | Finished long-form Resolve timeline with B-roll and graphics |
| `davinci-resolve-video-edit` | Clean foundation cut in Resolve |
| `deploy-an-app` | Next.js app live on Vercel with proof it works |
| `hvac-short-video` | Arabic HVAC short-video scripts and content plans |
| `review-an-app` | Evidence-based security and discoverability audit |
| `start-an-app` | Working full-stack app scaffolded around an interview |

## Notes

- Every package keeps its own `references/`, `scripts/` and `assets/` folders; do not flatten them.
- `create-video-shorts`, `davinci-resolve-pro-edit` and `create-youtube-thumbnails` are based on work for Leon van Zyl's YouTube channel; their examples and bundled design system stay credited to him (see [THIRD_PARTY_NOTICES.md](../THIRD_PARTY_NOTICES.md)). Set your own community links in each project's `project.json` → `community_links`.
- Many workflows need tools that are not in this repository: local apps (DaVinci Resolve), CLIs (`ffmpeg`, the HyperFrames CLI, the Codex CLI, `gh`), MCP servers, a GPU, or paid accounts (Vercel, Upstash, ElevenLabs, a song generator). `agent-music-video` also needs the separate `/hyperframes`, `/hyperframes-core` and `/music-to-video` skills. Each skill's `README.md` lists its requirements; read it before installing.
- `README.md` is the user-facing guide for each skill. The `SKILL.md` is the instruction file Claude loads.
- These skills are English-first by default because their source material, prompts and tooling are English. The exception is `hvac-short-video`, whose output is Arabic. Arabic-first skills otherwise stay in `writing/`, `productivity/`, `design/` and `engineering/`.
