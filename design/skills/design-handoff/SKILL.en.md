---
name: design-handoff
description: Use when documenting a design for developers with exact values for sizes, spacing, colors and fonts, fixed component names and interaction states.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Design handoff

## When to use
- Handing screens or components over for implementation.
- Building documentation or design tokens.
- Aligning what was implemented with the original design.

## Workflow
1. Gather the source: design files, screenshots or the approved values. Do not create values that do not appear in it; ask for them or mark them [TBD].
2. Extract the **tokens** with exact values and fixed semantic names:
   - Colors: HEX/RGB and the role name (such as `color-primary-600`, `color-text-default`).
   - Typography: family, size, weight and line height for each text role, for Arabic and Latin.
   - Spacing: the adopted scale, and the margins and padding of each component.
   - Radii, shadows, borders and contrast.
3. Name the components in a fixed pattern (such as `Button/Primary`, `Input/Text`) and use the same name in the design, the code and the documents.
4. For each component state: the sizes (width/height or stretch behavior), the inner spacing, the alignment, the long-text behavior (truncate or wrap), and the size variants.
5. Attach the **interaction states** of each interactive component: default, hover, focus, pressed, disabled, and special states (loading, error, success). Give the changing values for each state, such as color, border and shadow.
6. Document RTL: what mirrors, the alignment, the direction of icons, and the logical spacing (start/end).
7. Define the assets and their formats: SVG for icons, image formats and sizes (1x/2x), and naming rules.
8. Record the dynamic behavior: motion and transitions (the duration and the curve, if they exist in the design), and the responsive behavior at breakpoints.
9. Provide a review checklist: what the developer compares against the design before closing.

## Output format
1. **Handoff scope:** the components and screens covered, and the source of the values.
2. **Tokens table** or JSON with the semantic names and the values.
3. **Documentation of each component:** sizes, spacing, alignment, and variants.
4. **States table:** (State | Changing values).
5. **RTL, assets and motion notes.**
6. **Open questions** (missing values or conflicts).
7. **Review checklist.**

## Full example
**Input:** "Document the app's primary button. From the design: background #1F6F5C, text #FFFFFF, height 48, horizontal padding 24, radius 8, font 16 weight 600. On hover the background becomes #195A4B."

**Expected output:**
```text
Source of values: only what you provided.

{
  "color-primary-600": "#1F6F5C",
  "color-primary-700": "#195A4B",
  "color-on-primary": "#FFFFFF",
  "radius-md": "8px"
}

Button/Primary
- Height 48px; horizontal padding 24px; radius radius-md.
- Text 16px, weight 600.
- Long text: [TBD: truncate or wrap?]

| State | Background | Note |
|---|---|---|
| default | color-primary-600 | |
| hover | color-primary-700 | |
| focus | [TBD] | no ring value provided |
| pressed | [TBD] | |
| disabled | [TBD] | |

RTL: padding as padding-inline, and a directional icon mirrors.
Open questions: the focus, pressed and disabled states, and the long-text behavior.
Checklist: colors, dimensions, states, RTL behavior.
```

## Edge cases
- **A value not provided in the design:** mark it [TBD] and ask about it, and do not round to a neighboring value.
- **Two different values for the same element in two places:** report the conflict and ask for the reference before documenting.
- **A component without a focus state:** record it as a gap in the handoff, and do not skip it.
- **Names inconsistent between the design and the code:** suggest a unified name, and keep the two names side by side temporarily.
- **A design that violates an accessibility rule (low contrast):** document it as is and raise a separate note, and do not alter it yourself.
- **The team wants a specific format (CSS variables, for example):** convert the outputs to it with the same values.

## Rules and limits
- Every numeric value comes from the design file or the user; do not estimate and do not round.
- Do not change the design during handoff; record any conflict or gap as a question.
- Use fixed names that do not change between documents.
- Do not neglect the states; a component without a focus or disabled state is incomplete.
- Format the outputs in a form that suits the team (a table, JSON for tokens, Markdown).
