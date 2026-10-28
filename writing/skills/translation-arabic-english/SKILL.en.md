---
name: translation-arabic-english
description: Use when translating between Arabic and English in either direction, keeping terminology consistent and preserving meaning and tone.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Arabic–English translation

## When to use
- Translating a text or document from Arabic to English or the reverse.
- Reviewing and improving an existing translation.
- Unifying terminology across a long document or several documents.

## Workflow
1. Identify the direction of translation, the text type (legal, technical, marketing, literary, letter), the audience and the tone.
2. Read the whole text before translating to understand the context and the recurring terms.
3. Extract recurring or specialized terms and fix one equivalent for each. If the user provides a glossary, follow it.
4. Translate meaning, not words: rebuild the sentence according to the nature of the target language, and avoid literal translation of idioms.
5. Preserve: numbers, dates and names, the formatting of the text (headings, lists), and the tone of the original.
6. When translating into Arabic use correct contemporary Modern Standard Arabic and Arabic punctuation; when translating into English follow the natural style for the text type.
7. Check the translation against the source: no omissions, no additions, consistent terminology.
8. Attach short notes on ambiguous wording and give alternatives where there is more than one meaning, with a glossary table if the text is long.

## Output format
1. **Translation:** the translated text alone in a clear block, in the formatting of the source (headings, lists, paragraphs).
2. **Notes:** a short list of ambiguous wording and why you chose as you did (only when there is any).
3. **Glossary table:** (source | adopted equivalent) for long or specialized texts.
4. **Review notice:** one line for binding legal or medical texts.

## Full example
**Input:** "Translate into Arabic in a professional tone: 'Our team will review the proposal and revert by Thursday.'"

**Expected output:**
```text
Translation:
سيراجع فريقنا العرض ويوافيكم بالرد يوم الخميس.

Notes:
- "revert" here means "reply" in professional usage, not "return to a previous state".
- "proposal" was rendered as «العرض»; «المقترح» also works if a research document is meant.

Glossary:
| Source | Adopted equivalent |
|---|---|
| proposal | العرض |
| revert (meaning reply) | يوافي بالرد |
```

## Edge cases
- **Text mixing Arabic and English:** translate only the requested part, and leave names and common terms as they are.
- **A word with two or more meanings and missing context:** give the most likely meaning and its alternatives in the notes, or ask one question if the meaning changes the judgment.
- **Source text with a spelling mistake or an incomplete sentence:** translate the clear intended meaning and point out the mistake in the notes.
- **A proper name or term with no common equivalent:** transliterate and give the original in parentheses on first mention.
- **A contradiction inside the text (two different dates for the same event):** translate both as they appear and report the contradiction.
- **Colloquial dialect in the source:** translate the meaning in an equivalent tone, and say that you could not keep the local flavor if that was impossible.
- **A long text:** split it into parts while keeping a single shared glossary.

## Rules and limits
- Do not add information that is not in the source and do not remove any from it.
- Do not guess the meaning of an ambiguous word; flag the ambiguity and ask, or show the options.
- Do not change names, numbers or dates, and do not convert currencies or units unless asked.
- Binding legal and medical texts: warn that a certified translator should review them.
- Leave code snippets and brand names untranslated.
