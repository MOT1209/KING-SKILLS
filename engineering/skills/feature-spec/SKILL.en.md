---
name: feature-spec
description: Use when turning a vague feature idea into clear specifications with acceptance criteria, edge cases and open questions before implementation starts.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Feature specification

## When to use
- The user says "I want feature X" without enough detail.
- Before splitting the work into tasks or writing code.
- When the team disagrees about what the feature means.

Do not use when: the idea already has specifications and needs splitting into tasks (`task-breakdown`), or the request is a technical decision between options (`architecture-decision`).

## Workflow
1. Read the idea, and if the repository is available read the relevant parts to understand what already exists.
2. Write the problem and the target user in two sentences: who is struggling, and what they cannot do now.
3. Define the scope: what is in and what is explicitly out (non-goals).
4. Write the main usage scenarios in the form "As a [role] I want [action] so that [benefit]" where useful.
5. Write testable acceptance criteria, each one a sentence that can be judged pass or fail, preferably in Given/When/Then form.
6. Derive the edge cases: empty inputs, large values, permissions, concurrency, an external service failing, languages and RTL direction, time zones.
7. State the known non-functional constraints (performance, security, compatibility) only as the user provided them.
8. Record the open questions and assumptions, and classify each question: does it block implementation or not.

## Output format
```
# Specification: <feature name>
## Problem and user
## Scope (in / out)
## Usage scenarios
## Acceptance criteria (numbered list AC-1..)
## Edge cases
## Non-functional constraints
## Open questions (tagged: blocking / non-blocking)
## Assumptions
```

## Rules and limits
- Do not invent numbers (performance limits, user counts); whatever is not stated goes into the open questions.
- Do not specify a detailed technical solution; the specification describes "what", not "how".
- Every acceptance criterion is measurable; avoid "fast" and "easy" without a definition.
- Do not include real data in the examples.

## Edge cases
- The idea conflicts with an existing feature: state the conflict as a blocking open question.
- The idea is too large: suggest splitting it into smaller features and continue with the first.
- Not enough information about the problem itself: ask 3 questions at most before writing.

## Full example
### Input
"I want to export invoices to PDF in the accounting app."

### Output
```
# Specification: Export an invoice to PDF
## Problem and user
The accountant cannot send an invoice to the client outside the system except by a screenshot.
## Scope
In: exporting a single invoice. Out: bulk export, sending by email.
## Acceptance criteria
AC-1: When a confirmed invoice is opened and "Export PDF" is pressed, a file is downloaded within the agreed timeout.
AC-2: The file contains the invoice number, the line items and the total as on screen.
AC-3: Invoices in "draft" status do not show the button.
AC-4: Arabic text appears with connected letters and from right to left.
## Edge cases
An invoice with hundreds of items (multiple pages), a client name mixing Arabic and Latin letters, generation failure.
## Open questions
Q1 (blocking): is there a unified logo template?  Q2 (non-blocking): is a digital stamp required?
## Assumptions
The user is signed in and has permission to view the invoice.
```
