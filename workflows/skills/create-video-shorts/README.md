# create-video-shorts

Turn talking-head recordings into finished, ready-to-post 9:16 shorts — end to end in code.

## What the skill does

- Picks the most critical, self-contained moments in a recording (3–5 per video, never more than 5) and cuts them on forced-alignment word edges with J-cuts, then proves each cut by re-transcribing it.
- Renders 1080×1920 at 60 fps and rotates three layouts: full camera, a split with a head pop-out matted with Robust Video Matting (u2net fallback), and full visuals.
- Builds graphics in the channel's fixed design system — graphite stage, glass cards, Figtree / Geist Mono, azure — through HyperFrames, with real source captures, camera moves and motion blur.
- Burns in captions with glass keyword chips, and adds a glass cover and a "Watch the full video" CTA card.
- Uses a royalty-free SFX library, a riser, and music generated locally with ACE-Step.
- Keeps remixable stems, writes a report per short with numbers taken from the render data, and produces a publishing package for YouTube Shorts, TikTok and Instagram Reels that a script validates.

## When to use

Use it whenever the user points at a folder or a single video and wants shorts, reels, TikToks, vertical clips or a few shorts from a recording, or wants to fix or re-edit a short that was made this way — even if they never mention a skill.

Do not use it for a clean foundation cut or a full long-form edit; those are `davinci-resolve-video-edit` and `davinci-resolve-pro-edit`. Arabic captions are handled by `arabic-shorts`.

## Example requests

- "Make shorts from this folder."
- "Pull the three best moments out of this 40-minute recording and post them to TikTok and Reels."
- "Re-edit short 2 with a different hook and fix the caption on the first one."
- "Take this recording and give me the thumbnail and the posting copy too."

## What to expect

| Output | Details |
|---|---|
| `edit/short-NN_<slug>/final.mp4` | Finished 1080×1920, 60 fps short |
| `edit/short-NN_<slug>/thumbnail.jpg` | Cover image for that short |
| `edit/short-NN_<slug>/stems/` | Voice, SFX, riser and music stems for remixing |
| `edit/short-NN_<slug>/music_takes/` | Every generated take as an MP3, with the one used marked |
| `edit/short-NN_<slug>/report.md` | How the moment was chosen and what the finished short contains |
| `edit/PUBLISH.md` | Titles and captions per platform, checked by `scripts/check_publish.py` |

## Requirements

`ffmpeg`, Node 22+ and `uv`. `scripts/setup.sh` creates the Python environment, the per-video work folders, the graphics engine and fonts, and downloads the missing half of the SFX library. A GPU speeds up the matting and music generation; the Robust Video Matting model and the ACE-Step environment are cached once per machine under `~/.cache/pro-edit-models/rvm` and `~/.venvs/music-gen`. The graphics run through `npx --yes hyperframes`. An existing `davinci-resolve-pro-edit` run on the same machine is reused automatically when present, but nothing depends on it.

## Attribution

The design system (graphite stage, glass, Figtree / Geist Mono, azure) and the example content in `examples/` come from Leon van Zyl's YouTube channel and its video-editing workflow. They are kept here as a worked reference for the skill.
