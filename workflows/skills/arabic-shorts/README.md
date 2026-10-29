# arabic-shorts

Turn one long video in Arabic, or Arabic mixed with English, into vertical shorts (YouTube Shorts, Reels, TikTok) with burned-in Arabic captions laid out right to left, plus Arabic publishing copy. Built for the **مختبر البرمجة** channel.

## What the skill does

- Transcribes the video with a timing for every word (faster-whisper; CPU or NVIDIA GPU).
- Picks 1 to 3 self-contained moments of 20 to 60 seconds, each with a hook in its first seconds.
- Cuts each one to 1080x1920: `crop` for a talking head, `fit` for screen recordings and code.
- Burns in captions in IBM Plex Sans Arabic Bold. Arabic lines read right to left, English terms stay in Latin letters in the right place, and the lam-alef ligatures render correctly.
- Writes an SRT file and the publishing copy (title, description with the channel link, TikTok and Instagram captions).

## When to use

When the user wants shorts, reels or TikToks cut from a recording, or Arabic captions on a vertical clip.

Do not use it to write a script for a video that has not been recorded yet; use `hvac-short-video` for HVAC content, or the writing skills.

## Example requests

- "قصّ لي ثلاث شورتس من هذا الفيديو." (Cut three shorts from this video.)
- "اعمل مقطع قصير من الدقيقة 4 إلى 4:50 مع ترجمة عربية." (Make a short from 4:00 to 4:50 with Arabic captions.)
- "هذا تسجيل شاشة لدرس Python؛ أريد منه ريلز." (This is a screen recording of a Python lesson; I want reels from it.)

## What to expect

| Output | Details |
|---|---|
| `short.mp4` per short | 1080x1920, H.264 + AAC, captions burned in |
| `captions.srt` | The same captions as a separate file |
| `PUBLISH.md` | Arabic title, description, hashtags, TikTok and Instagram captions |
| A short report | Why each moment was chosen, what was corrected in the transcript, what was not checked |

## Requirements

`ffmpeg` built with libass, Python 3.9 or newer, and `pip install faster-whisper`. The first run downloads the speech model from huggingface.co (about 500 MB for `small`). An NVIDIA GPU is optional; without one, transcription runs on the CPU and is slower.

## Tested

Cutting, both layouts and caption rendering were tested on rendered frames, including mixed lines such as «Python هي الأفضل» and the lam-alef ligatures. Transcription accuracy on real Arabic and mixed speech has **not** been tested yet: try it on one of your own videos first and correct the transcript where needed.
