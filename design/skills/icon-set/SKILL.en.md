---
name: icon-set
description: Use when unifying an icon set with a fixed stroke width and grid size and defining each icon's states (default, active, disabled).
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Icon set

## When to use
- Building an icon set for an app or a brand from scratch.
- Unifying icons from different sources whose styles visibly differ.
- Defining icon states in a design system.

## Workflow
1. Define the list of required icons and the function of each, the usage platform, and the required sizes.
2. Fix the core specifications of the set:
   - **Drawing grid:** the canvas size and the safe margin (for example 24×24 with an inner padding).
   - **Stroke width:** a single value for the whole set.
   - **Style:** outline, filled or duotone, and do not mix.
   - **Corners and ends:** the corner radius, and the line ends (round or flat).
   - **Key shapes:** keyline shapes (circle, square, vertical and horizontal rectangle) drawn at a similar optical size.
3. Classify the icons: functional (actions), status, navigation, content. And identify which are affected by RTL direction (directional ones mirror, non-directional ones do not).
4. Define the **states** of each icon: default, active/selected, disabled, and optionally hover, focus and pressed. For each state: the color and its role in the color palette, the stroke or fill if it differs, and the contrast.
5. Require that the state does not rely on color alone, such as changing the style from outline to filled for the active one (WCAG SC 1.4.1), and that the color of an essential icon achieves at least 3:1 contrast (SC 1.4.11).
6. Name the icons in a fixed format (such as `icon-search`, `icon-arrow-start`) and use `start/end` instead of `left/right` for directional ones.
7. Produce clean SVG on request: a unified `viewBox`, `fill`/`stroke` set to `currentColor`, no unnecessary transforms, and alternative text when used.
8. Test: scaling down to the smallest size in use, visual consistency side by side, and clarity on light and dark backgrounds.

## Output format
1. **Set specifications:** a table (Item | Value): the grid, the padding, the stroke, the style, the corners, the ends.
2. **Icon list:** (Name | Function | Directional? | RTL note).
3. **States table:** (State | Color/role | Shape change | Contrast).
4. **Naming rules.**
5. **SVG** for one or more icons on request only.

## Full example
**Input:** "Specifications for an outline icon set for an app, 3 icons: search, back, settings."

**Expected output:**
```text
| Item | Value (adopted by your team) |
|---|---|
| Grid | 24×24, inner padding 2 |
| Stroke | 2 (one value for the set) |
| Style | outline |
| Corners and ends | radius 2, round ends |

| Name | Function | Directional? |
|---|---|---|
| icon-search | search | no (the handle may be mirrored as a design decision) |
| icon-arrow-start | back | yes, mirrors in RTL |
| icon-settings | settings | no |

| State | Color | Shape change |
|---|---|---|
| default | text-secondary | outline |
| active | primary | filled (a non-color cue) |
| disabled | text-disabled | outline |

A simple SVG for icon-search:
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
     stroke-linecap="round" aria-hidden="true">
  <circle cx="11" cy="11" r="6"/><path d="M16 16l4 4"/>
</svg>
```

## Edge cases
- **Icons arriving with different stroke widths:** set the width of the set, and list the icons that need redrawing.
- **Icons from a licensed source:** ask for the license and check it before merging, and do not assume it is open.
- **An icon whose meaning differs by culture:** flag it and suggest an alternative or an accompanying text.
- **An active state that differs from the default only by color:** suggest an additional shape change.
- **A size in use smaller than the grid:** test clarity and simplify the detail for those sizes.
- **A directional icon whose mirroring is unknown to the user:** decide by its meaning (forward/back mirror) and state the reason.

## Rules and limits
- Do not copy icons from licensed sets without a license that permits it; check the license of any ready-made set.
- Do not mix two stroke widths or two styles in one set.
- The grid and stroke numbers are values chosen by the user or the system; do not present them as a universal standard.
- Culturally loaded symbols (hand gestures, animals) are reviewed before adoption.
- Do not use an icon with a meaning different from its common use without a reason.
