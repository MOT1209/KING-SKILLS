# create-youtube-thumbnails

Design high-click YouTube thumbnails that show what the video is actually about, then prove each render mechanically and with a blind viewer test.

## What the skill does

- Reads the transcript and titles to identify the video's real payoff.
- Researches proven outliers in the niche with VidIQ (100k+ views) and measures their layout, background, palette, type and treatment.
- Re-makes one outlier per variant faithfully for this video, using the creator's own photo, the video's real payoff frames and official logos.
- Renders variants with ChatGPT image generation through the Codex CLI.
- Proves every render against its reference (background and palette drift, text contrast), against the title (a blind "stranger test" subagent must say what the video is about) and at real feed sizes.
- Delivers 1280×720 variants for YouTube Test & Compare with an HTML report showing where every decision came from.

## When to use

Use it whenever the user wants a thumbnail, thumbnail ideas, A/B thumbnail variants or a better thumbnail for a video — from a YouTube link, a transcript, a recording or just an idea and a hook.

Do not use it to generate a generic image with no video context, or to produce the video itself; use `create-video-shorts` or `davinci-resolve-pro-edit` for that.

## Example requests

- "Make three thumbnail variants for this YouTube video."
- "My click-through rate is low — redesign this thumbnail and test it."
- "Here is a transcript and a hook; make a thumbnail that earns the click."

## What to expect

| Output | Details |
|---|---|
| Competitor research | Outlier thumbnails with measured layout, palette and type |
| Thumbnail variants | 1280×720 renders ready for Test & Compare |
| Proof | Mechanical checks, blind stranger test and feed-size review |
| Report | An HTML report documenting every decision and its source |

## Requirements

The Codex CLI with image generation, VidIQ access for outlier research, the video or transcript, and the creator's photo and official logos.
