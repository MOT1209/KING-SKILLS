# accessibility-check — accessibility check

> English translation of [README.md](README.md).

## What the skill does
Checks your design or page against WCAG 2.2 AA criteria: contrast, touch targets, alternative text, keyboard navigation, and not relying on color alone.

## When to use it
- Before handover or launch.
- When designing a new interactive component (a form, a menu, a dialog).

## Example requests
1. "Check this form (HTML code attached) against WCAG 2.2 AA and give me a list of fixes."
2. "My app's button colors: [values]. Is the contrast enough, and are the buttons a suitable size for touch?"
3. "Check my login page: [code], and focus on the keyboard and the error messages."

## What to expect
| Item | What you get |
|---|---|
| Results | A table: check, criterion, result, evidence, fix |
| Scope | What was checked and what was not |
| Contrast | Ratios that were calculated, not estimated |
| Limits | It does not replace user testing, and is not legal advice |
