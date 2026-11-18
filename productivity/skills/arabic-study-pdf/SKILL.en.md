---
name: arabic-study-pdf
description: Use to turn photos of a lesson into a professional Arabic study PDF: a simplified explanation with German or English terms, a summary, practice questions with solutions, and a glossary.
---

# Study PDF from lesson photos

## When to use
- A student has an exam, does not understand the lesson, and provides photos (book, board, notes) wanting a file to understand, review and practise from.
- They want an Arabic explanation that keeps the original terms (German or English).

Do not use when: they want sourced research with no study file (`research-summary`), or a slide deck (`presentations`), or there are no lesson photos.

## Workflow
1. **Read the photos first:** if none are attached, ask for them and do not start. Read the photos yourself and identify the subject, the lesson's language, its title and its concepts. Do not ask the student what the photos already tell you; ask only about decisions and needs.
2. **Understanding interview before any design:** ask in numbered rounds (all questions that do not depend on a missing answer, in one batch), each with your default suggestion so "yes" means agreement, then wait. Round one: the second term language (suggest the lesson's own), the level (school / Ausbildung / university), what exactly is unclear, and the exam date and type (written / oral / multiple choice / problems). Later rounds as answers require: number of practice questions (default 10) and difficulty, extra examples or drawings for hard points, all topics or only some, any special request (file size, printing).
3. **Confirm understanding:** when decisions are settled, write a short summary of what was agreed and ask "Did I understand you correctly?". Do not start research or design before confirmation. If the student says "start now" or does not reply, take the defaults and state them in one line at the top of the file.
4. **Extract the content:** from each photo: title, definitions, formulas, tables, drawings, examples, questions. Keep for yourself a list of "core concepts" and "unclear points". Keep the original term exactly as written.
5. **Research:** for each core concept and unclear point, search the web, in the lesson's original language first, from official educational sources, universities, or chambers (IHK/HWK) for Ausbildung topics. Rephrase in your own words, do not copy paragraphs, and keep the links for the sources page.
6. **Write and design:** write HTML + CSS following "Output format", then convert to PDF.
7. **Convert:** make sure an Arabic font exists (`fc-list | grep -i -E "arab|naskh|cairo"`). Preferred: Chromium through Playwright (`page.pdf`, A4, `print_background=True`); alternative: WeasyPrint (`weasyprint lesson.html lesson.pdf`).
8. **Check before delivery (mandatory):** render 3–4 pages to images (`pdftoppm -png -r 80`) and open them; verify Arabic letters connect, direction is correct, Latin terms are not reversed, and no text is clipped or boxes split across pages. Confirm every concept from the photos is explained, every question has a correct solution (compute numeric problems with code), and every distinctive term is in the glossary.
9. **Deliver:** send the file with one line: page count, and which point was unclear and how you clarified it. Suggest one next step (harder questions or review cards), then ask two or three short questions about clarity and design fit.

## Output format
A PDF in this order:
1. **Cover:** title in Arabic with the original beneath, subject, level, date.
2. **Short table of contents.**
3. **Simplified explanation**, easy to hard. Per concept: a heading (Arabic + original in parentheses), a short-sentence explanation, an everyday example, a "watch out" box for common mistakes, and formulas in a distinct box with each symbol explained.
4. **Summary:** one or two pages of numbered points, plus a comparison table where useful.
5. **Practice questions:** varied (multiple choice, true/false, short, numeric problems if needed) at near-exam level.
6. **Solutions:** on a separate page, with the reason for each answer, not only the answer.
7. **Glossary:** Arabic | German/English | one-line explanation. For German, the article (der/die/das) and plural form.
8. **Sources:** links actually consulted.

**Two languages:** Arabic is the explanation language. An important term is written first as **Arabic term** (Fachbegriff) in a different, muted style. Latin text inside a paragraph is wrapped in `<span dir="ltr" lang="de">` (or `en`); formulas, numbers and units are always LTR.

**Design:** A4 with 18–20mm margins and `dir="rtl"`; Noto Naskh Arabic, IBM Plex Sans Arabic or Cairo for Arabic and Noto Sans or Inter for Latin; 11–12pt text with 1.7 line spacing; a navy primary (#1F3A5F), teal secondary (#2A9D8F) and light grey. Boxes with a right-side border: key idea (light blue), watch out (light orange), formula (grey), example (light green). Page numbers in the footer and the lesson title in the header, `page-break-before` before summary, questions, solutions and glossary, `break-inside: avoid` for boxes and tables, and drawings as inline SVG (or a crop from the student's own photo).

## Rules and limits
- Do not invent sources, numbers or quotations, and do not copy paragraphs from sources.
- Do not start design before the student confirms your understanding (unless they said "start now").
- The student's photos are the exam reference; if a source contradicts them, note the difference briefly.
- Do not put the student's personal data in the file; use placeholders.
- Do not claim the visual check passed until you actually opened the pages.

## Edge cases
- **Unclear photo:** tell the student which part could not be read instead of guessing.
- **Source contradicts the photo:** follow the photo and add a note about the difference.
- **Large lesson:** ask whether they want all topics or a focus on parts; do not silently drop concepts.
- **Exam very soon:** a bigger summary and a shorter explanation.
- **Missing Arabic font:** install `fonts-noto-core`; if that fails, tell the student rather than delivering broken letters.

## Full example
**Input:** "These are three photos from an Elektrotechnik lesson. I have an exam on Thursday and did not understand Ohm's law."

**Expected output:**
```text
(Round one of questions)
❓ Q1 - Term language: the lesson is in German; put the German term beside the Arabic?
➡️ Yes, German.
❓ Q2 - Level: Ausbildung?
➡️ Yes.
❓ Q3 - Exam type: written with numeric problems?
➡️ Yes, and I make 10 practice questions.

(After the reply and confirmed understanding, delivery)
[file: ohmsches-gesetz.pdf]
12 pages. The unclear point was the relation between U, I and R in series
circuits; I clarified it with an example and a step-by-step solved problem.
Suggested next step: a harder question set.
```
