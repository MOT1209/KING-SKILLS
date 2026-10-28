---
name: logo-concepts
description: Use when proposing three visual directions for a logo, tying each direction to the brand's name and values.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Logo directions

## When to use
- The user is starting a new brand or redesigning their logo and wants directions before execution.
- They want to compare different styles (wordmark, symbol, combination).

Do not use when: there is no brief or settled name yet (`design-brief`), or the request is a complete, produced brand kit with files (`create-brand-kit`).

## Workflow
1. Gather the inputs: the brand name (Arabic/Latin), the activity, the values (3 at most), the audience, any logos or colors that are rejected. Use the design brief if there is one.
2. Analyze the name: its meaning, its letter count, the shape of its letters in Arabic and Latin, and whether a symbol can be extracted from it.
3. Propose **three** genuinely distinct directions, and do not settle for three variants of one idea. For example: a wordmark, an abstract or pictorial symbol, and a combination mark pairing a symbol with the name.
4. For each direction write:
   - **A descriptive name** for the direction.
   - **The visual description:** the shape, the composition, the type style (linear, thuluth, kufic, modern), the geometric or organic approach.
   - **Why it connects:** how it reflects the brand name and which of its values, in two sentences.
   - **Use:** where it works well (app icon, signage, stamp) and where it is weak.
   - **Bilingual:** how the Arabic and Latin names are arranged together or separately.
5. Suggest tests before approval: scaling down, one color, dark and light backgrounds, legibility from a distance.
6. Ask the user to choose a direction or combine elements for the next round of development.

## Output format
1. **Name analysis:** two to four lines (meaning, letters, symbol opportunities).
2. **Three directions** in order, each with: descriptive name, visual description, why it connects, use (strength/weakness), bilingual.
3. **Pre-approval tests:** a short list.
4. **The choice question:** which direction (or combination) do we develop?

## Full example
**Input:** "A brand named «ورقة» (a placeholder name for illustration) for printing services, values: precision and speed. Give me three directions."

**Expected output:**
```text
Name analysis: «ورقة» is a short name of four letters, and it contains the shape of a sheet of paper as a direct symbol.
The letters waw and ra give a curved movement that can be exploited.

Direction 1: restrained wordmark (Wordmark)
- Description: the name alone in a modern geometric Arabic type, with the qaf slightly open like the corner of a sheet.
- Connection: the strict geometry expresses precision; the short name gives a feeling of speed.
- Use: strong on print and signage; weaker as a small app icon.
- Bilingual: the Arabic name larger, with the Latin beneath it in a lighter weight.

Direction 2: abstract symbol (Symbol)
- Description: a square with a folded corner that hints at the sheet, in one continuous line.
- Connection: the folded corner = the sheet; the continuous line = speed.
- Use: excellent for the icon and the stamp; it needs the name to introduce it at first.
- Bilingual: the symbol is independent of language, with the name beside it.

Direction 3: combination (Combination)
- Description: a simplified sheet symbol to the right of the Arabic name.
- Connection: it combines the clarity of the name with an easily remembered symbol.
- Use: flexible; the symbol can be separated for small uses.
- Bilingual: a horizontal version and a vertical one.

Pre-approval tests: scaling down, one color, a dark background, legibility from a distance.
Which direction do we develop, or do you want to combine elements?
```

## Edge cases
- **A long name (more than three words):** suggest an abbreviation or an initials-based symbol, and explain its effect on readability.
- **An Arabic and a Latin name with different meanings:** ask which is primary for the audience, and do not assume.
- **Brand values not stated:** mark them as an assumption and suggest three to confirm, and do not build on them as if approved.
- **The user attaches an existing logo:** analyze its elements and improve them, and do not suggest directions close to another well-known logo.
- **A request for a "guaranteed unique logo":** explain that uniqueness and registration cannot be guaranteed, and advise a legal check.
- **A name whose Arabic letters change shape when joined:** flag legibility in every direction.

## Rules and limits
- Do not claim that the logo is unique or registrable as a trademark; advise searching the official trademark register of the relevant authority and consulting a specialist.
- Do not imitate an existing logo or ask to come close to one.
- The description is textual, or a simple SVG drawing on request; do not claim that the output is final print-ready files.
- Any use of traditional Arabic calligraphy must keep the letters legible.
- Do not assume brand values the user did not state; ask or mark them as an assumption.
