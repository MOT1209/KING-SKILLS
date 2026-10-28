# Third-party notices | إشعارات الأطراف الثالثة

The repository is released under the [MIT License](LICENSE). The files below were written by others and are bundled under **their own licences**, which the MIT License does not replace. Keep each licence file next to its files when you copy or redistribute them.

المستودع منشور بترخيص [MIT](LICENSE)، لكن الملفات أدناه من إنتاج أطراف أخرى وتبقى خاضعة لتراخيصها الخاصة، ولا يحلّ ترخيص MIT محلّها. احتفظ بملف الترخيص بجانب ملفاته عند نسخها أو إعادة توزيعها.

## Fonts (SIL Open Font License 1.1)

The licence text and each family's copyright line ship next to the fonts.

| Family | Where | Licence file |
|---|---|---|
| Inter, Inter Display, Space Grotesk, JetBrains Mono | `workflows/skills/agent-music-video/assets/fonts/` | `OFL-Inter.txt`, `OFL-SpaceGrotesk.txt`, `OFL-JetBrainsMono.txt` |
| Figtree, Geist Mono, Poppins, Instrument Serif | `workflows/skills/create-video-shorts/assets/fonts/`, `workflows/skills/davinci-resolve-pro-edit/assets/fonts/` | `Figtree-OFL.txt`, `GeistMono-OFL.txt`, `Poppins-OFL.txt`, `InstrumentSerif-OFL.txt` |
| Poppins | `workflows/skills/create-youtube-thumbnails/assets/fonts/` | `Poppins-OFL.txt` |

## JavaScript libraries

| Library | Where | Licence |
|---|---|---|
| three.js r170 | `workflows/skills/agent-music-video/assets/vendor/three.module.min.js` | MIT, Copyright 2010-2024 Three.js Authors (header kept in the file) |
| GSAP 3.14.2 | `workflows/skills/agent-music-video/assets/vendor/gsap.min.js`, `workflows/skills/create-video-shorts/assets/gfx/gsap.min.js`, `workflows/skills/davinci-resolve-pro-edit/assets/gfx/gsap.min.js` | GreenSock standard licence, https://gsap.com/standard-license (header kept in the file) |

## Sound effects

`workflows/skills/create-video-shorts/assets/sfx/` and `workflows/skills/davinci-resolve-pro-edit/assets/sfx/` each hold 27 sounds from Freesound under **CC0 1.0**. `manifest.json` in each folder records every sound's source page, author and licence. The library's other 27 sounds (Mixkit) may not be redistributed: they are downloaded locally by `scripts/sfx_library.py build` and are excluded by `.gitignore`.

## Models (licence not yet verified)

| File | Where |
|---|---|
| `face_landmarker.task` (MediaPipe) | `workflows/skills/create-video-shorts/assets/models/`, `workflows/skills/davinci-resolve-pro-edit/assets/models/` |
| `face_detection_yunet_2023mar.onnx` (OpenCV YuNet) | the same two folders |

These ship without a licence notice in this repository. Confirm each model's licence with its publisher and add the notice here before relying on redistribution.
