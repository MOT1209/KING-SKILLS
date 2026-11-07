# davinci-resolve-pro-edit

Professionally edit a long-form YouTube recording in DaVinci Resolve, and hand back a mastered 4K file that is ready to upload.

## What the skill does

- Reuses or makes a clean foundation cut and duplicates it, so nothing on the clean cut changes.
- Gives the first 30–45 seconds a short-form hook: screen zooms with highlights, punch-ins, graphics with real source captures and motion blur, a split with a head pop-out, keyword pops, music that fades out after the hook, and a riser.
- Keeps the body moving with something to look at wherever the talk explains or cites something — zooms with highlights, real articles and pages with the cited line marked, explainer graphics, logos, the speaker's own videos and CTA cards, with library SFX and no music after the hook.
- Places a moving, morphing webcam (full frame, side card, corner window, hidden) on eased transitions when the webcam and desktop were recorded separately.
- Builds a new Pro Edit timeline in Resolve with every addition on its own named track, so anything can be adjusted or removed, plus chapters, an SRT and publishing copy.
- Masters the finished 4K file to −14 LUFS with a true peak under −1 dBTP and verifies it on the decoded file.

## When to use

Use it whenever the user wants a long-form video or a Resolve timeline professionally edited, polished or finished, or wants zooms, graphics, B-roll, highlights, sound design or a hook added — even without naming a skill.

Do not use it for a clean cut alone (`davinci-resolve-video-edit`) or for vertical shorts (`create-video-shorts`).

## Example requests

- "Edit this 40-minute tutorial like a pro and make the first 30 seconds grab people."
- "Add B-roll, zooms and a hook to my Resolve timeline, but keep my clean cut untouched."
- "My webcam was recorded separately — place it properly through the video and master the audio."
- "Give me the finished 4K file, chapters, subtitles and the publishing copy."

## What to expect

| Output | Details |
|---|---|
| Pro Edit timeline | A duplicate of the clean cut with each kind of addition on its own named track |
| `final/<timeline> - FINAL (-14 LUFS).mp4` | Upload-ready 4K master, verified on the decoded file |
| Chapters and SRT | Timed to the finished edit |
| Publishing copy | Title, description and the rest of the upload package |
| Clean cut and source media | Preserved; the skill archives duplicates rather than deleting them |

## Requirements

DaVinci Resolve Studio with the `davinci-resolve` MCP server connected (Studio is needed for external scripting), `ffmpeg` (NVENC is used when present), Node 22+ and `uv`. `scripts/setup.sh` creates a Python 3.11 environment at `~/.venvs/pro-edit` or the path in `PRO_EDIT_VENV` with numpy, scipy, soundfile, pyloudnorm, opencv, pillow, mediapipe and onnxruntime-gpu. Graphics run through `npx --yes hyperframes`. Resolve itself is a paid local application, and the MCP server is a community project.

## Attribution

The design system (graphite stage, glass, Figtree / Geist Mono, azure) and the example content in `examples/` come from Leon van Zyl's YouTube channel and its video-editing workflow. They are kept here as a worked reference for the skill.
