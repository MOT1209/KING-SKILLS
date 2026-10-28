---
name: social-graphics
description: Use when designing posts and stories for social platforms at each platform's sizes, with short text and a consistent brand identity.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Social media graphics

## When to use
- Designing a post, a carousel or a story for Instagram, LinkedIn, TikTok, X and others.
- Building a repeatable template that preserves the brand identity.

Do not use when: the request is ideas, a schedule or editorial copy (`social-content-plan`), or YouTube thumbnails (`create-youtube-thumbnails`); this skill is for visual design.

## Workflow
1. Gather: the platform and format (post, carousel, story), the message, the required wording, the call to action, and the identity elements (logo, colors, fonts).
2. **Verify the current size** in the platform's official help before handover, because the specifications change. For initial planning the common ratios are: square 1:1, portrait 4:5, and full vertical 9:16 for stories and short video; treat them as a starting point, not an official specification.
3. Define the safe zones: platform interfaces cover the edges of stories and video (account names, interaction buttons), so leave safe margins and check the official specifications.
4. Set the composition: one focal point, a short headline (one idea), optional secondary text, a clear call to action, and a logo in a fixed position.
5. Preserve the identity: colors and fonts from the brand system only, a fixed spacing rule, and a unified image/illustration style.
6. For Arabic: RTL direction, right-aligned text, carousel order from right to left where it suits the context, consistent numerals and marks, and a font that reads well at small size.
7. Ensure enough contrast for text over images (an overlay or a backing panel), and check it by actual calculation when relying on colors.
8. Provide the specifications of each piece: the size in pixels, the grid, the fonts and sizes, the colors, and export notes (format and size).
9. Suggest alternative text (alt text) for each image.

## Output format
1. **Piece summary:** the platform, the format, the message, the call to action.
2. **Specifications:** the ratio (and the pixel size after checking with the platform), the grid, the safe zones.
3. **Composition:** a description or a textual diagram of the positions of the elements.
4. **Identity:** the colors and fonts (values from the user), and the logo position.
5. **Export:** the format and size, and the alternative text for each image.
6. **Verification notice:** the sizes and the rights.

## Full example
**Input:** "A 4:5 Instagram post template for a coffee brand, a short headline and a logo in the corner, in Arabic."

**Expected output:**
```text
Piece: Instagram, a 4:5 post. Message: drink of the week. Call: "Try it today".
Specifications: ratio 4:5; the pixel size is confirmed from the platform's help before export.
Fixed inner margins; and no text at the outer edges.

Composition (RTL):
+------------------------+
|                [Logo]  |  top right
|                        |
|   [drink image]        |  focal point
|                        |
| Short two-line headline|  right aligned, over a dark overlay
| "Try it today"         |  call to action
+------------------------+

Identity: the brand's colors and fonts [TBD: values]. Contrast checked by calculation if the text is over the image.
Alt text: "A cup of coffee on a wooden table" (adjusted to the actual image).
Notice: verify the rights to the image and font, and the platform's current sizes.
```

## Edge cases
- **A headline too long to fit:** shorten the wording in agreement with the user or spread it across carousel slides.
- **The logo is unavailable:** put a placeholder [Logo], and do not draw a logo of your own.
- **A low-quality image:** flag the resolution, and suggest using a color background instead.
- **Brand identity not provided:** ask for the colors and fonts, or mark them as a temporary assumption.
- **Two platforms with two different ratios:** design a version for each platform, and redistribute the elements rather than stretch.
- **Arabic and Latin text in the headline:** define the direction of each part and make sure the numerals are in the right order.

## Rules and limits
- The text on the image is short; no paragraphs.
- Do not use images, fonts or music without a license; mention verifying the rights.
- Do not put figures, certificates, quotations or claims the user did not provide.
- Do not promise specific engagement results.
- The safe-area rules and detailed sizes are taken from the platform's official source at execution time.
