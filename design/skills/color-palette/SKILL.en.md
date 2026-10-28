---
name: color-palette
description: Use when building a cohesive color palette (primary, secondary, accent, neutral) while checking text contrast against WCAG 2.x level AA at least.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Color palette

## When to use
- Building a palette for a brand, an interface or print materials.
- Fixing an existing palette that has unreadable text.
- Creating a dark or light version of an existing palette.

## Workflow
1. Read the design brief: the personality, the sector, the cultural norms of the audience, and any required or rejected colors.
2. Define the roles: **primary**, **secondary**, **accent**, **neutrals** (a gray ramp of 5 to 9 steps), then state colors: success, warning, error, info.
3. Give each color as a HEX value, with a fixed role name (such as `primary-600`) and light and dark shades if needed.
4. Check contrast by actual calculation using the WCAG 2.x contrast ratio formula (relative luminance) in code, and never estimate it by eye or from memory.
5. Apply the AA level limits of WCAG 2.x:
   - Normal text: at least 4.5:1 (SC 1.4.3).
   - Large text: at least 3:1 (SC 1.4.3).
   - Interface components and graphics needed to understand content (field borders, icons): at least 3:1 (SC 1.4.11).
6. Present a table of the proposed combinations: text color, background color, the calculated ratio, the result (AA / AAA / fail), and the permitted use.
7. Adjust the failing colors (by changing lightness while keeping the hue) and recalculate.
8. Suggest a usage distribution rule (such as neutrals dominating and the accent being rare) as guidance, not as an official standard.

## Output format
1. **Color table:** (Role | Name | HEX).
2. **Contrast table:** (Text color | Background color | Calculated ratio | Result | Permitted use).
3. **Adjustments:** each failing color with its proposed replacement and its new ratio.
4. **Notes:** reliance on color alone, print, and cultural assumptions if any.

## Full example
**Input:** "My colors: #1F6F5C and #F2B84B. Check the contrast on a white background."

**Expected output** (ratios computed with the WCAG 2.x relative luminance formula):
```text
| Text color | Background | Ratio | Result | Use |
|---|---|---|---|---|
| #1F6F5C | #FFFFFF | 6.02:1 | passes AA (normal text) | text and buttons |
| #F2B84B | #FFFFFF | 1.79:1 | fails | not used as text on white |
| #1F2A27 | #F2B84B | 8.27:1 | passes AA and AAA | text on the accent background |

Adjustment: to use the accent color as text on white, replace it with #8A6100 (5.54:1, passes AA).
Notes: do not rely on color alone to convey meaning (SC 1.4.1); for print, verify with the print shop.
```

## Edge cases
- **A required color that fails on every possible background:** suggest using it as a decorative non-text element, or a darker shade of it for text, and explain the reason.
- **A color value in a non-HEX format (a name, RGB, CMYK):** convert it in code and tell the user the value adopted.
- **A request for colors for an audience of a particular culture:** state that the connotations are assumptions, and do not cite studies.
- **Background images instead of a solid color:** calculate the contrast on the weakest area, and suggest an overlay.
- **A request for a dark version:** recalculate the contrast; inverting the values is not enough.
- **An invalid HEX value:** report it and ask for a correction, and do not guess.

## Rules and limits
- Do not present a contrast ratio that was not actually calculated.
- Do not rely on color alone to convey meaning (WCAG SC 1.4.1); point out the presence of an additional cue.
- Color connotations differ between cultures; do not generalize a color's meaning to an audience without stating that it is an assumption.
- Screen values (RGB/HEX) can differ from print; for print advise an actual match with the print shop.
- Do not cite studies or statistics about "color psychology" without a source.
