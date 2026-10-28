---
name: ui-layout
description: Use when laying out a screen or page with a fixed grid and consistent spacing, ordering buttons by priority, with right-to-left support.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Interface layout

## When to use
- Designing a new screen or rearranging a crowded one.
- Converting an interface from LTR to RTL or making it bidirectional.
- Setting the spacing and grid rules for a product.

## Workflow
1. Identify the screen's main task, the platform (mobile, web, dashboard), and the actual content or realistic examples of it.
2. Order the elements by importance: one primary action per screen, then secondary actions, then tertiary ones, then informational elements.
3. Choose a fixed grid: the number of columns, the gutters and the margins for each breakpoint, and a base spacing unit (such as multiples of 4 or 8px) applied across all screens.
4. Draw the layout in text, ASCII or simple HTML/CSS: header, content area, sections, buttons, stating the columns each element occupies.
5. Order the buttons:
   - One prominent primary button per context.
   - The secondary in a lighter style, and the tertiary as text or a link.
   - Destructive actions in a distinct style with confirmation, and away from the primary action.
6. Apply RTL: start the grid and the alignment from the right, mirror the order of horizontal elements (menus, navigation, progress steps), mirror directional icons (arrows, back, forward) and do not mirror non-directional icons (clock, settings, logo), and keep numerals, symbols and Latin text in their correct order. Use CSS logical properties (`margin-inline-start`, `padding-inline`) instead of `left/right`.
7. Record the responsive behavior: what stacks, disappears or transforms on smaller screens.
8. Review: spacing only from the adopted scale, consistent alignment, proximity of related elements, and enough whitespace.

## Output format
1. **The main task** of the screen and its primary action in two lines.
2. **Grid specification:** columns, gutters, margins, spacing unit (starting suggestions).
3. **Layout diagram:** textual or simple HTML/CSS, showing the columns of each element.
4. **Button order:** primary, secondary, tertiary, destructive.
5. **RTL decisions:** what mirrors and what does not.
6. **Responsive behavior:** what stacks or disappears on smaller screens.

## Full example
**Input:** "The layout of the payment screen in a mobile app in Arabic."

**Expected output:**
```text
Task: complete the payment. Primary action: "Pay now".
Grid (starting suggestion): 4 columns, 16px margin, 16px gutter, 8px spacing unit.

Layout (RTL, starting from the right):
+------------------------------+
| Payment  [→ mirrored back]   |  header (4 columns)
| Order summary                |  card (4 columns)
| Payment method               |  selection list (4 columns)
| [Pay now]  (primary)         |  full-width button
| [Cancel order] (text, destructive) |  away from the primary button
+------------------------------+

RTL: the back arrow is on the right and points right (mirrored); the settings icon is not mirrored. Spacing with margin-inline-start.
Responsive: on a wide screen the summary sits beside the payment form.
```

## Edge cases
- **Content longer than expected (a long name or address):** specify truncation or wrapping for each element and do not leave the behavior ambiguous.
- **A screen with two actions of equal importance:** ask the user to name the more important one, and if they do not, suggest the likelier with the reasoning.
- **An interface with Arabic and Latin text together:** define the direction of each block, and keep numerals and symbols in their correct order.
- **No screenshot of the current screen is available:** ask for a description or a screenshot, and do not assume its elements.
- **Breakpoints not stated:** suggest two or three and mark them as an assumption.
- **An icon whose directionality is unknown:** ask about its meaning before deciding whether it mirrors.

## Rules and limits
- Do not put more than one primary action in a single context.
- Do not use spacing values outside the scale without a documented reason.
- Do not assume content; use the actual content or clear placeholders, and test with longer and shorter Arabic text.
- The grid and spacing numbers are starting suggestions the user adjusts, not an official standard.
- Do not forget contrast and touch targets; for detail use `accessibility-check`.
