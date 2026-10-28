---
name: accessibility-check
description: Use when checking a design or interface for contrast, touch target size, alternative text, keyboard navigation, and not relying on color alone.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Accessibility check

## When to use
- Before handing over a design or launching an interface.
- Reviewing a component (a form, a menu, a dialog) or a whole page.
- Verifying compliance with WCAG 2.2 level AA.

Do not use when: the request is building a colour palette from scratch (`color-palette`), or a general review of a user flow (`ux-review`).

## Workflow
1. Define the scope and the target standard (default: WCAG 2.2 level AA) and the available materials (a design, HTML code, a link).
2. **Contrast (SC 1.4.3, 1.4.11):** calculate the contrast ratios in code: normal text 4.5:1, large text 3:1, interface components, field borders and essential icons 3:1, and check the hover and focus states too; disabled components are exempt from the WCAG contrast requirement, but it is advisable to keep them legible.
3. **Touch targets:** WCAG 2.2 (SC 2.5.8, level AA) requires a minimum of 24×24 CSS px with exceptions (spacing and others), and SC 2.5.5 (AAA) recommends 44×44. Platforms have their own guidelines (Apple Human Interface Guidelines and Material Design) which should be checked in their official sources before quoting their numbers.
4. **Alternative text (SC 1.1.1):** every meaningful image has a short description that serves its function; decorative ones have an empty alternative; functional icons have a readable name; link and button texts are understandable out of context.
5. **Keyboard (SC 2.1.1, 2.4.3, 2.4.7):** every function can be operated by keyboard, the focus order is logical, the focus indicator is visible, and there is no focus "trap" in dialogs.
6. **Not relying on color alone (SC 1.4.1):** error and success states and links carry a second cue (an icon, text, an underline).
7. **Others as relevant:** page language and direction (`lang` and `dir`), field labels, error messages tied to the field, text resizing up to 200% without loss of content (SC 1.4.4), and respecting the reduced-motion preference.
8. Present the results: the check, the criterion (SC number), the result (pass/fail/not verifiable), the evidence, and the proposed fix, ordered by severity.

## Output format
1. **Scope:** what was checked, the target standard, and what was not checked.
2. **Results table** ordered by severity: (Check | Criterion SC | Result | Evidence | Fix).
3. **Summary:** the count of pass, fail and not verifiable.
4. **Limits notice:** the check does not replace a screen reader and users with disabilities, and is not legal advice.

## Full example
**Input:** "A button with white text #FFFFFF on a #F2B84B background, sized 20×20 pixels, and an icon with no alternative text."

**Expected output:**
```text
Scope: one button, WCAG 2.2 AA. Not checked: keyboard navigation (no code attached).

| Check | Criterion | Result | Evidence | Fix |
|---|---|---|---|---|
| Text contrast | SC 1.4.3 | fail | 1.79:1 calculated, 4.5:1 required | dark text such as #1F2A27 (8.27:1) |
| Target size | SC 2.5.8 | fail | 20×20, the minimum is 24×24 subject to exceptions | increase the size or the spacing |
| Alternative text | SC 1.1.1 | fail | a functional icon without a name | add a readable name such as "Add" |
| Keyboard | SC 2.1.1 | not verifiable | no code attached | send the HTML to check |

Summary: fail 3, not verifiable 1.
Notice: this does not replace testing with a screen reader and real users, and is not legal advice.
```

## Edge cases
- **A design without code:** check contrast and sizes from the values only, and mark the remaining items "not verifiable".
- **An older standard requested (WCAG 2.1):** adopt it, and note that SC 2.5.8 is from 2.2 so it does not apply.
- **A criterion number you are not sure of:** give the name of the criterion and ask for verification, and do not invent a number.
- **A disabled component with low contrast:** exempt from the requirement, but advise keeping it legible.
- **Colors carrying a single piece of information (red for errors only):** classify as failing SC 1.4.1 and suggest an icon or text.
- **A request for "is the page compliant?" from a partial check:** answer with what was checked only, and do not issue a blanket verdict.

## Rules and limits
- Do not claim that a page is "compliant" based on a partial check; state what was checked and what was not.
- A manual or automated tool check does not replace testing with a screen reader and users with disabilities; flag that.
- Cite exact WCAG criterion numbers only, and if you are not sure of a criterion number give its name and ask for verification.
- Do not estimate contrast ratios without calculating.
- This skill is not legal advice on compliance.
