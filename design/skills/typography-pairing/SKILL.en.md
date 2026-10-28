---
name: typography-pairing
description: Use when choosing matching Arabic and Latin fonts and defining heading and body sizes and line height.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Typography pairing

## When to use
- Choosing fonts for a brand, a website or a bilingual app.
- Setting a type scale (sizes, weights and line height).
- Fixing Arabic and Latin text that do not match in weight or size.

## Workflow
1. Identify the medium (screen, print, presentation), the languages, the brand personality, and licensing constraints (open source or paid, and web and app licenses).
2. Suggest an Arabic font and a Latin font from known, available families, with the reason for the choice. Examples of open-source Arabic families on Google Fonts: Noto Sans Arabic, IBM Plex Sans Arabic, Cairo, Tajawal, Readex Pro, Noto Naskh Arabic. Latin: Inter, IBM Plex Sans, Noto Sans.
3. Present the pairing with considerations: closeness of x-height and optical size, closeness of weight, and matching personality (geometric with geometric, humanist with humanist).
4. Make the Arabic font the base if the primary language is Arabic, and adjust the Latin size so it looks visually equivalent; it may need a nominal adjustment (such as `size-adjust` in CSS), decided by testing, not by guessing.
5. Put the type scale in a table: the role (H1–H4, body, small text, button, label), the size, the weight, the line height, and the letter spacing. Start from a base of 16px body text for the web and a line height of about 1.5 for normal text, and raise the Arabic line height a little (about 1.6–1.8) because of diacritics and ascending and descending letters, then adjust by testing on real text.
6. Do not apply letter-spacing to Arabic; it breaks the connection of the letters.
7. Define the fallback fonts for each language, the loading method (self-host or CDN) and the `font-display` setting.
8. Test on real text in Arabic and Latin together, including numerals (Western or Eastern Arabic), diacritics and punctuation.

## Output format
1. **The pairing:** the Arabic font and the Latin font, with the reason for the choice in one line each.
2. **Licensing and availability:** one line per font asking to verify both.
3. **Type scale:** a table (Role | Size | Weight | Line height | Note).
4. **Technical setup:** the fallback fonts, the loading method, `font-display`, and any size adjustment.
5. **Suggested test:** a real bilingual text to try it on.

## Full example
**Input:** "A bilingual consulting company website, a serious and modern personality. Suggest a pairing and a scale."

**Expected output:**
```text
The pairing:
- Arabic: IBM Plex Sans Arabic, a calm geometric face suited to a serious personality.
- Latin: IBM Plex Sans, from the same family so weight and feel are close.
Licensing: both are open source as far as I know; verify the license and the font's availability before commercial use.

| Role | Size | Weight | Line height |
|---|---|---|---|
| H1 | 32px | 700 | 1.4 |
| H2 | 24px | 600 | 1.5 |
| Body | 16px | 400 | 1.7 (Arabic) / 1.5 (Latin) |
| Small text | 14px | 400 | 1.7 |
The values are a starting point to adjust on your actual text.

Setup: Arabic fallback: sans-serif; load from your own server with font-display: swap.
Do not use letter-spacing on Arabic text.
Test: an Arabic sentence containing numerals and diacritics next to an English sentence at the same size.
```

## Edge cases
- **The user owns a paid or brand-specific font:** stick to it and build the pairing around it, and review the web license.
- **A font lacking the required weights:** suggest available weights or an alternative font, and do not assume a weight exists.
- **The font does not appear in the user's environment:** define the fallback font for each language and show the expected difference.
- **Arabic text with heavy diacritics:** raise the line height, and test on actual vocalized text.
- **Eastern Arabic and Western numerals together:** ask which one is adopted and unify it across the interface.
- **Uncertainty about a font's Arabic support:** say "verify availability", and do not confirm support you have not checked.

## Rules and limits
- Do not suggest a font without stating its license and the need to verify it before commercial use.
- Do not mention a font whose existence or Arabic support you are not sure of; say "verify availability".
- The numbers in step 5 are starting values that can be adjusted, not an official standard.
- Do not use more than two families, and do not overuse weights.
- Respect RTL direction in alignment and unify the interface numerals.
