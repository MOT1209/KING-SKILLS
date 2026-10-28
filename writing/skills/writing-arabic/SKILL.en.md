---
name: writing-arabic
description: Use when writing, editing or proofreading Arabic content (articles, letters, posts) and improving its style.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Writing and editing Arabic content

## When to use
- Writing an article, a formal letter or a social media post in Arabic.
- Editing existing Arabic text to improve its style and clarity.
- Proofreading: spelling, grammar and punctuation.

Do not use for literal translation between languages, or for writing in a colloquial dialect unless the user explicitly asks for it.

## Workflow
1. Identify the text type (article, letter, post), the audience, the purpose and the tone (formal, friendly, marketing). If something is missing and cannot be inferred, ask one short question.
2. Set the language level: simplified contemporary Modern Standard Arabic by default, unless asked otherwise.
3. For new writing: sketch a short structure (introduction, main points, conclusion for an article; greeting, purpose, closing for a letter; one idea and a call to action for a post), then write.
4. For editing: preserve the author's meaning and voice, and change only what improves clarity or correctness.
5. Proofread: spelling (hamzas, ta marbuta vs. ha, alif maqsura), grammar and case endings where they are evident, number and gender agreement, and Arabic punctuation (، ؛ ؟).
6. Improve style: shorten long sentences, remove filler and repetition, replace literally translated phrases with natural Arabic, and vary sentence openings.
7. When editing, show the corrected text followed by a short list of the most important changes and why, without listing every minor change.

## Output format
- **New writing:** the final text directly, with a title if it is an article, within the requested length.
- **Editing or proofreading:** two parts: "Corrected text", then "Key changes" as a list of 3 to 7 items, each item: change — reason.
- **Missing information:** shown as [TBD], with a final line listing them.
- No openers such as "Sure!" and no summary of what was written after the text.

## Full example
**Input:** "Proofread this text: ان الاهتمام بالقراءه اليوميه يزيد من المعرفه و يساعد على تحسين الاسلوب , و لذالك ننصح بها."

**Expected output:**
```text
Corrected text:
إنّ الاهتمام بالقراءة اليومية يزيد المعرفة ويساعد على تحسين الأسلوب؛ ولذلك ننصح بها.

Key changes:
- إنّ instead of ان: the particle takes a hamza (with kasra) at the start of the sentence.
- القراءة, اليومية, المعرفة: ta marbuta instead of ha.
- الأسلوب: hamza added to the alif.
- يزيد المعرفة instead of "يزيد من": the verb takes its object directly.
- Removed the space before the conjunction (ويساعد) and before punctuation, and used the Arabic semicolon (؛).
- ولذلك instead of "ولذالك": spelling fixed.
```

## Edge cases
- **Text mixing colloquial and standard Arabic:** unify at simplified Modern Standard Arabic unless the user explicitly wants the colloquial.
- **An ambiguous sentence with two possible meanings:** do not guess; show both wordings and ask which is meant.
- **Partially vocalized text or wrong vocalization:** correct it or remove it, and tell the user what you did.
- **Text with a weak opinion or argument:** correct the language only, and suggest strengthening the argument in a separate note without applying it.
- **A writing request that needs figures or sources not provided:** write the text with a [TBD] marker in those places.
- **A quotation or poetry in the text:** do not edit it, as it may be intentionally verbatim; only flag an obvious error.
- **A length limit that cannot fit the requested content:** respect the limit and tell the user what you left out.

## Rules and limits
- Do not change the meaning, position or facts in text the user owns.
- Do not invent figures, statistics, quotations, names or sources; if the text needs information that is not available, put a [TBD] marker and tell the user.
- Leave foreign names and terms as they are, or write them in Arabic letters with the original in parentheses on first mention.
- Do not overdo rhetorical ornament; clarity comes before grandeur.
- Respect the requested length; if none is given, choose a length suited to the text type.
- If a change concerns the opinion or argument rather than the language, suggest it and do not apply it without approval.
