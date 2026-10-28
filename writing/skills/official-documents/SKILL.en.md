---
name: official-documents
description: Use when preparing official documents such as CVs, cover letters, price quotations and meeting minutes.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Official documents

## When to use
- Preparing or improving a CV.
- Writing a cover letter for a job.
- Preparing a price quotation for a client.
- Writing meeting minutes from raw notes.

## Workflow
1. Identify the document type, the target organization and the purpose, and ask the user for the actual information it will be built on.
2. Choose the suitable template:
   - **CV:** professional summary, experience (most recent first), education, skills, certificates.
   - **Cover letter:** an opening paragraph, a paragraph linking the experience to the job requirements, a closing that asks for an interview.
   - **Price quotation:** both parties' details, a description of the services, a table of items, quantities and prices, terms, validity period.
   - **Meeting minutes:** date and attendees, agenda, decisions, tasks (owner and deadline), the date of the next meeting.
3. Fill the template with what the user provided only, and use placeholders for what is missing.
4. In a quotation, calculate the totals and tax yourself with correct arithmetic, checked twice, and state the assumed tax rate if any.
5. Write in concise professional language, with achievement-based wording in the CV and the letter (verb + impact).
6. Check consistency: dates, names, totals, and that the document is free of language errors.

## Output format
- The document title and type at the top, then the sections in the order given in the template.
- Tables in Markdown (items, tasks, totals).
- Every piece of information not provided appears as [TBD: description of what is needed].
- In a quotation: separate lines for subtotal, tax and total, with the calculation shown.
- A final note of one or two lines: what was assumed and what must be completed.

## Full example
**Input:** "Prepare meeting minutes from these notes: We met to discuss the website launch. It was decided to adopt design number two. [Role: designer] delivers the final files before [date]. [Role: developer] starts coding after that."

**Expected output:**
```text
# Meeting minutes: Discussing the website launch
Date: [TBD: meeting date]
Attendees: [TBD: names of attendees]

## Decisions
1. Adopt design number two.

## Tasks
| Task | Owner | Deadline |
|---|---|---|
| Deliver the final files | Designer | Before [date] |
| Start coding | Developer | After the files are delivered |

Next meeting: [TBD]
Note: the notes contained no agenda and no attendee names, so they were left to be completed.
```

**Quotation arithmetic example** (values from the user): design 1000, development 2000, tax 15%:
Subtotal = 1000 + 2000 = 3000; tax = 3000 × 0.15 = 450; total = 3450.

## Edge cases
- **Meeting notes contain a decision whose owner is unknown:** write the task and put the owner as [TBD], and do not assign anyone.
- **Conflicting notes (two different deadlines for one task):** highlight the conflict in a final note, and write the one closest to the latest text, marked as such.
- **A cover letter without the job posting:** write a generic version with placeholders, and ask for the posting text to tailor it.
- **A CV with experience but no dates:** do not guess the durations; leave them [TBD].
- **A quotation without a tax rate:** ask for it, and if it is unavailable show prices without tax with a warning.
- **The user asks to add an achievement they did not mention to strengthen the CV:** refuse to invent the achievement, and suggest questions that help them recall their actual achievements.

## Rules and limits
- Do not include real personal data (names, phone numbers, addresses, ID numbers); use [Full name], [Email] and [Phone number] and the like.
- Do not invent experience, certificates, achievement figures or prices; whatever the user did not provide stays [TBD].
- In meeting minutes do not add decisions or tasks that were not in the notes.
- Do not present the document as legal or financial advice; flag that it should be reviewed when it is binding.
