# agent-music-video

Turn a news story, a topic, a product launch or any other story into an original song and a story-driven, beat-synced music video hosted by the AGENT robot mascot.

## What the skill does

- Researches and verifies the story, keeping a source list for every claim.
- Writes narrative lyrics with humour, a chantable hook and a style prompt for Suno or Udio.
- Analyses the generated track: beats, quiet moments and word-level lyric timing.
- Plans the video in sections, then builds it in HyperFrames with real screenshot "receipts", brand logos, animated mascot cameos, 3D toon lettering and karaoke captions.
- Runs a section-director team and an end-of-pipeline critic loop before delivery.
- Packages the result for YouTube: 4K 60 fps MP4, loudness-normalised master, SRT, thumbnails and `social-metadata.md` with titles, description, chapters, tags and a pinned comment.

## When to use

Use it when the user wants a song or music video about a news story or topic, a recap or launch turned into a song, a video for a track they already generated, lyrics with a hook, a 60-second Short version, or anything involving the AGENT mascot or music-video channel.

Do not use it when the user only wants a normal talking-head edit (use `create-video-shorts` or `davinci-resolve-pro-edit`) or only a thumbnail (use `create-youtube-thumbnails`).

## Example requests

- "Make a song and music video about this week's AI news."
- "Turn this product launch post into a 60-second song with a chantable hook."
- "I have a Suno track — build the full music video and YouTube package."

## What to expect

| Output | Details |
|---|---|
| Research brief | Verified story beats, quotes and source links |
| Song package | Narrative lyrics, hook, style prompt and track analysis |
| Video project | HyperFrames sections, graphics, captions and critic report |
| Delivery package | 4K 60 fps MP4, SRT, thumbnails and publishing metadata |

## Requirements

A source track or access to a song generator (Suno, Udio or similar), `ffmpeg`, Python 3 (`librosa numpy soundfile faster-whisper pillow`) and Node.js. Building the video needs the HyperFrames CLI (`npx hyperframes`) and the `/hyperframes`, `/hyperframes-core` and `/music-to-video` skills, which are **not part of this repository** and must be installed separately. Voice casting needs Demucs and SpeechBrain in their own Python environment. A GPU speeds up rendering but is not required.
