# create-youtube-thumbnails

Design high-click YouTube thumbnails that show what the video is actually about, and prove it with checks instead of taste.

## What the skill does

- Reads the transcript and the titles, finds the video's payoff, and writes a brief with the promise, the payoff and the one picture that makes each title believable.
- Researches the niche with VidIQ (outliers at 100k+ views), the creator's own uploads and competitors, downloads the thumbnails into contact sheets, and looks at them.
- Measures one proven reference per concept — background, palette, subject treatment, type, hero treatment and grid — with `dna.py`, then re-makes it for this video and changes only the person, the words and the hero content.
- Renders with ChatGPT image generation through the Codex CLI, two renders per concept, attaching labelled avatar, logo, layout-reference and payoff-frame images.
- Proves every render mechanically: fidelity against its own reference, a blind "stranger test" on the image, full-resolution text, hands and logo checks, and a feed-size ladder at 246 and 168 px.
- Delivers 1280×720 variants for YouTube's Test & Compare, an HTML report showing each variant next to its reference, and a written report of the decisions.

## When to use

Use it whenever the user wants a thumbnail, thumbnail ideas, A/B thumbnail variants or a better thumbnail for a video, from a YouTube link, a transcript, a recording, or just an idea and a hook — even if they never mention a skill.

Do not use it for producing the video itself; use `create-video-shorts` for vertical shorts or `arabic-shorts` for Arabic short-form.

## Example requests

- "Make me three thumbnails for this video: <YouTube URL>."
- "These thumbnails aren't getting clicks. What should they look like instead?"
- "Here's the transcript and two possible titles — design variants for Test & Compare."
- "Re-make this outlier thumbnail for my video, with my photo."

## What to expect

| Output | Details |
|---|---|
| `thumbnails/A_<slug>.jpg`, `B…` | 1280×720 JPEG, under 2 MB, ranked, plus a 1920 master |
| `thumbnails/report.html` | Each variant next to its reference and the creator's thumbnail, with the title it pairs with |
| `thumbnails/report.md` | The reasoning, the stranger test answers and the measured fidelity, in writing |
| `brand.md` | The house style, updated with what this run established |
| `research/niche.md` | Outliers, competitors and keywords found for the niche |

## Requirements

The Codex CLI logged in with ChatGPT and `image_generation` enabled (the setup script checks both), and the VidIQ MCP server for research. `scripts/setup.sh` creates the shared Python environment with `uv`; UI captures use Playwright. Poppins (`Poppins-Regular.ttf`, `Poppins-SemiBold.ttf`) is bundled in `assets/fonts/`, and `qa.py` falls back to a system font when neither file is present. Image generation and VidIQ are external services and may cost money; the skill asks before spending.
