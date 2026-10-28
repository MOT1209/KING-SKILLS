# create-video-shorts

Turn a talking-head recording into finished, ready-to-post 9:16 shorts for YouTube Shorts, Instagram Reels and TikTok — end to end in code.

## What the skill does

- Transcribes the recording and picks the strongest lines for each short.
- Cuts with J-cuts and rotates eye-contact-aware layouts: full camera, split screen with a matted head pop-out, and full visuals.
- Builds HyperFrames graphics in the channel's design system, with real source captures, camera moves and motion blur.
- Burns in captions with glass keyword chips, a glass cover and a "Watch the full video" CTA card.
- Adds real library sound effects, a riser and music generated locally for each short.
- Verifies the output and delivers 1080×1920 60 fps MP4s with stems, a report, a thumbnail and a publishing package for each platform.

## When to use

Use it whenever the user points at a folder or video and wants shorts, reels, TikToks, vertical clips or a few shorts from a recording, or wants to fix or re-edit a short made this way — even if they just say "make shorts from this folder".

Do not use it for a long-form edit (use `davinci-resolve-pro-edit`) or a clean foundation cut with no graphics (use `davinci-resolve-video-edit`).

## Example requests

- "Make three shorts from this recording, one per best moment."
- "Cut this interview into vertical clips for Reels and TikTok."
- "Re-edit this short with better captions and a hook."

## What to expect

| Output | Details |
|---|---|
| Selected moments | A shortlist of the best lines with timestamps |
| Edited shorts | 1080×1920 60 fps MP4s with captions, graphics and sound design |
| Assets | Remixable stems, cover and a thumbnail per short |
| Publishing package | Platform-tuned titles, captions, hashtags and links back to the full video |

## Requirements

A source recording, `ffmpeg`, Python 3 and Node.js. Robust Video Matting and local music generation benefit from a GPU; the pipeline can fall back to supplied assets and existing music.
