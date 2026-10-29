"""Cut one vertical short (1080x1920) from a recording, with burned-in Arabic/English captions.

usage: python make_short.py <video> <transcript.json> <start> <end> <out_dir>
                            [--layout crop|fit] [--max-words 3] [--font-size 78] [--no-captions]

  start, end   seconds in the source video (snap them to word boundaries from transcript.json)
  --layout     crop: fill the frame from the centre (talking head)
               fit:  the whole frame over a blurred copy of itself (screen recordings, code)

Writes out_dir/short.mp4, out_dir/captions.ass and out_dir/captions.srt.
Captions use the bundled IBM Plex Sans Arabic Bold (Arabic and Latin in one font). Lines that contain Arabic are
laid out right to left; English words inside them keep their own order.
"""
import argparse
import json
import os
import re
import shutil
import subprocess
import sys

SKILL = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FONT_DIR = os.path.join(SKILL, "assets", "fonts")
FONT_NAME = "IBM Plex Sans Arabic"
ARABIC = re.compile("[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]")
RLE, PDF = "\u202b", "\u202c"  # right-to-left embedding: libass ignores RLM, but honours this (tested)
W, H = 1080, 1920


def probe_duration(path):
    out = subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", path],
                         capture_output=True, text=True)
    try:
        return float(out.stdout.strip())
    except ValueError:
        sys.exit(f"error: cannot read the duration of {path}: {out.stderr.strip()}")


def chunks(words, start, end, max_words):
    """Group the words inside [start, end] into caption lines: up to max_words words, a break at pauses and
    sentence punctuation, never longer than 2 s. Times are relative to the clip start."""
    picked = [w for w in words if w["end"] > start and w["start"] < end]
    lines, cur = [], []
    for k, w in enumerate(picked):
        cur.append(w)
        nxt = picked[k + 1] if k + 1 < len(picked) else None
        pause = nxt is not None and nxt["start"] - w["end"] > 0.35
        punct = w["text"][-1:] in ".!?؟،,؛:"
        long_ = cur[-1]["end"] - cur[0]["start"] > 2.0
        if len(cur) >= max_words or pause or punct or long_ or nxt is None:
            lines.append({"start": max(cur[0]["start"], start) - start,
                          "end": min(cur[-1]["end"], end) - start,
                          "text": " ".join(x["text"] for x in cur)})
            cur = []
    # close small gaps so captions don't flicker between words of one sentence
    for a, b in zip(lines, lines[1:]):
        if 0 < b["start"] - a["end"] < 0.25:
            a["end"] = b["start"]
    return lines


def ts_ass(t):
    cs = int(round(t * 100))
    h, cs = divmod(cs, 360000)
    m, cs = divmod(cs, 6000)
    s, cs = divmod(cs, 100)
    return f"{h}:{m:02d}:{s:02d}.{cs:02d}"


def ts_srt(t):
    ms = int(round(t * 1000))
    h, ms = divmod(ms, 3600000)
    m, ms = divmod(ms, 60000)
    s, ms = divmod(ms, 1000)
    return f"{h:02d}:{m:02d}:{s:02d},{ms:03d}"


def caption_text(text):
    text = text.replace("\\", "\\\\").replace("{", "(").replace("}", ")")
    return RLE + text + PDF if ARABIC.search(text) else text


def write_ass(lines, path, size):
    head = f"""[Script Info]
ScriptType: v4.00+
PlayResX: {W}
PlayResY: {H}
WrapStyle: 0
ScaledBorderAndShadow: yes

[V4+ Styles]
Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding
Style: Cap,{FONT_NAME},{size},&H00FFFFFF,&H00FFFFFF,&H00000000,&H64000000,-1,0,0,0,100,100,0,0,1,6,2,2,90,90,430,1

[Events]
Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text
"""
    with open(path, "w", encoding="utf-8") as f:
        f.write(head)
        for c in lines:
            f.write(f"Dialogue: 0,{ts_ass(c['start'])},{ts_ass(c['end'])},Cap,,0,0,0,,{caption_text(c['text'])}\n")


def write_srt(lines, path):
    with open(path, "w", encoding="utf-8") as f:
        for n, c in enumerate(lines, 1):
            f.write(f"{n}\n{ts_srt(c['start'])} --> {ts_srt(c['end'])}\n{c['text']}\n\n")


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("video")
    ap.add_argument("transcript")
    ap.add_argument("start", type=float)
    ap.add_argument("end", type=float)
    ap.add_argument("out_dir")
    ap.add_argument("--layout", choices=["crop", "fit"], default="crop")
    ap.add_argument("--max-words", type=int, default=3)
    ap.add_argument("--font-size", type=int, default=78)
    ap.add_argument("--no-captions", action="store_true")
    a = ap.parse_args()

    for tool in ("ffmpeg", "ffprobe"):
        if not shutil.which(tool):
            sys.exit(f"error: {tool} not found on PATH")
    if not os.path.isfile(a.video):
        sys.exit(f"error: no such file: {a.video}")
    dur = probe_duration(a.video)
    if not 0 <= a.start < a.end <= dur + 0.05:
        sys.exit(f"error: need 0 <= start < end <= {dur:.2f} (the video's length); got {a.start}-{a.end}")
    if a.end - a.start > 180:
        sys.exit("error: a short is at most 180 s (YouTube Shorts); pick a shorter range")

    with open(a.transcript, encoding="utf-8") as f:
        words = json.load(f).get("words", [])
    os.makedirs(a.out_dir, exist_ok=True)
    lines = [] if a.no_captions else chunks(words, a.start, a.end, a.max_words)
    write_ass(lines, os.path.join(a.out_dir, "captions.ass"), a.font_size)
    write_srt(lines, os.path.join(a.out_dir, "captions.srt"))

    # ffmpeg runs inside out_dir with relative paths, so filter arguments never contain drive letters or spaces
    fonts = os.path.join(a.out_dir, "fonts")
    shutil.copytree(FONT_DIR, fonts, dirs_exist_ok=True)
    if a.layout == "crop":
        vf = f"scale={W}:{H}:force_original_aspect_ratio=increase,crop={W}:{H},setsar=1"
    else:
        vf = (f"split[a][b];[a]scale={W}:{H}:force_original_aspect_ratio=increase,crop={W}:{H},boxblur=30:3[bg];"
              f"[b]scale={W}:{H}:force_original_aspect_ratio=decrease[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2,setsar=1")
    if lines:
        # the ass filter with complex shaping: the subtitles filter's simple shaping breaks the lam-alef ligature (tested)
        vf += ",ass=captions.ass:fontsdir=fonts:shaping=complex"
    cmd = ["ffmpeg", "-v", "error", "-y", "-ss", f"{a.start:.3f}", "-to", f"{a.end:.3f}", "-i", os.path.abspath(a.video),
           "-filter_complex", f"[0:v]{vf}[v]", "-map", "[v]", "-map", "0:a?",
           "-c:v", "libx264", "-preset", "medium", "-crf", "18", "-pix_fmt", "yuv420p",
           "-c:a", "aac", "-b:a", "192k", "-movflags", "+faststart", "short.mp4"]
    r = subprocess.run(cmd, cwd=a.out_dir, capture_output=True, text=True)
    if r.returncode != 0:
        sys.exit(f"error: ffmpeg failed:\n{r.stderr.strip()}")
    print(f"{os.path.join(a.out_dir, 'short.mp4')}: {a.end - a.start:.1f} s, {len(lines)} caption lines, layout {a.layout}")


if __name__ == "__main__":
    main()
