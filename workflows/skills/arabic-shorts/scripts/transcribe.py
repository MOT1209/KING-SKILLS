"""Transcribe a recording with word timings, for Arabic, English or mixed speech.

Uses faster-whisper. Runs on the CPU anywhere; uses an NVIDIA GPU automatically when one is available.

usage: python transcribe.py <video-or-audio> [--out DIR] [--lang ar|en|auto] [--model small]
                            [--terms "Python, JavaScript, API, Git"]

Writes:
  DIR/transcript.json   {"language", "duration", "words": [{"i", "text", "start", "end"}], "segments": [...]}
  DIR/transcript.txt    one line per segment: [first word index] start-end  text   (for reading and picking moments)

--terms is passed to Whisper as a prompt. For mixed Arabic/English speech, list the English technical words you
use, so they are more likely to come out in Latin letters instead of being transliterated.
"""
import argparse
import json
import os
import sys


def device():
    try:
        import ctranslate2
        if ctranslate2.get_cuda_device_count() > 0:
            return "cuda", "float16"
    except Exception:
        pass
    return "cpu", "int8"


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("media")
    ap.add_argument("--out", default=".")
    ap.add_argument("--lang", default="ar", help="ar (default, also for mixed speech), en, or auto")
    ap.add_argument("--model", default="small", help="tiny, base, small (default), medium, large-v3")
    ap.add_argument("--terms", default="", help="comma-separated English terms used in the video")
    a = ap.parse_args()

    if not os.path.isfile(a.media):
        sys.exit(f"error: no such file: {a.media}")
    try:
        from faster_whisper import WhisperModel
    except ImportError:
        sys.exit("error: faster-whisper is not installed (pip install faster-whisper)")

    dev, ctype = device()
    print(f"model {a.model} on {dev} ({ctype}); this can take a while on the CPU", file=sys.stderr)
    try:
        model = WhisperModel(a.model, device=dev, compute_type=ctype)
    except Exception as e:  # the first run downloads the model from huggingface.co
        sys.exit(f"error: could not load the '{a.model}' model ({e.__class__.__name__}: {e}). "
                 "The first run downloads it from huggingface.co: check the internet connection.")
    segs, info = model.transcribe(
        a.media,
        language=None if a.lang == "auto" else a.lang,
        word_timestamps=True,
        vad_filter=True,
        beam_size=5,
        initial_prompt=a.terms or None,
        condition_on_previous_text=False,
    )

    words, segments = [], []
    for s in segs:
        first = len(words)
        for w in s.words or []:
            text = w.word.strip()
            if text:
                words.append({"i": len(words), "text": text, "start": round(w.start, 3), "end": round(w.end, 3)})
        segments.append({"first_word": first, "start": round(s.start, 3), "end": round(s.end, 3), "text": s.text.strip()})

    os.makedirs(a.out, exist_ok=True)
    data = {"language": info.language, "duration": round(info.duration, 3), "words": words, "segments": segments}
    with open(os.path.join(a.out, "transcript.json"), "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=1)
    with open(os.path.join(a.out, "transcript.txt"), "w", encoding="utf-8") as f:
        for s in segments:
            f.write(f"[{s['first_word']}] {s['start']:.2f}-{s['end']:.2f}  {s['text']}\n")
    print(f"{len(words)} words, {len(segments)} segments, language {info.language} -> {a.out}/transcript.json")


if __name__ == "__main__":
    main()
