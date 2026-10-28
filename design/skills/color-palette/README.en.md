# color-palette — color palette

> English translation of [README.md](README.md).

## What the skill does
Builds a cohesive color palette (primary, secondary, accent, neutral, states) and verifies by calculation that the text and background combinations meet WCAG 2.x level AA.

## When to use it
- You are designing a brand or an interface and need a ready-to-use palette.
- Your current palette has faint text and you want to fix it.

## Example requests
1. "Build a color palette for a banking app with a trustworthy and calm personality, with a contrast table for the text."
2. "These are my brand colors: #1F6F5C and #F2B84B. Check the contrast and adjust whatever does not pass AA."
3. "Convert my light color palette into a dark version and check the contrast: [values]"

## What to expect
| Item | What you get |
|---|---|
| The colors | A HEX table with fixed role names |
| Contrast | Ratios that were actually calculated and the result of each combination |
| Adjustments | Replacements for failing colors with their ratios |
| Limits | No statistics about "color psychology", and a print warning |
