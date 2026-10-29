# davinci-resolve-video-edit

Cut a DaVinci Resolve talking-head, screencast or tutorial timeline into a clean, well-paced foundation edit — and nothing else.

## What the skill does

- Transcribes the timeline with word-level CrisperWhisper 2.0 on the local GPU.
- Removes bad takes, retakes, false starts, stumbles, "um"/"uh" fillers, lip smacks and noises.
- Applies editorial rules for pacing, breathing room and clean cut points.
- Assembles the cut through the `davinci-resolve` MCP, preserving the source media.
- Reports what was removed and why so the edit can be reviewed.

## When to use

Use it whenever the user wants to edit, clean up, tighten or rough-cut a Resolve timeline, remove bad takes, fillers or retakes, "cut this video like a professional editor", or prepare a YouTube recording for B-roll — even if they don't say "skill" or name the tools. Also use it when they ask how a previous clean-cut edit was made.

Do not use it when the user wants B-roll, captions, music, transitions or motion graphics; this repository has no skill for that yet. Use `arabic-shorts` for vertical shorts.

## Example requests

- "Clean up this Resolve timeline and remove every retake and filler."
- "Tighten this 50-minute recording into a watchable first cut."
- "How were my previous clean cuts made? Do the same here."

## What to expect

| Output | Details |
|---|---|
| Transcript | Word-level transcript used for cut decisions |
| Foundation timeline | A clean cut with retakes, fillers and noises removed |
| Cut report | What was removed and the editorial rule behind it |
| Review notes | Any passages that need a human decision |

## Requirements

DaVinci Resolve (Studio or free edition) with the `davinci-resolve` MCP connected, `ffmpeg`, a Python environment with CrisperWhisper 2.0 (about a 7 GB download; the skill asks first), and the source recording. An NVIDIA GPU is strongly recommended; the CPU works but is much slower. No graphics, music or caption tooling is needed.
