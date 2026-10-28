---
name: design-brief
description: Use when turning a vague idea or a general design request into a clear design brief covering the goal, audience, message and constraints.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Design brief

## When to use
- The user says "I want a design for…" without enough detail.
- Before starting any design work (logo, interface, posts) to fix the direction.
- When the parties to a project disagree about what is required.

## Workflow
1. Read what the user provided and extract what is actually known.
2. Ask only about what is essential and missing (up to 5 questions in one message): the goal, the audience, the product or service, where the design will be shown, the deadline.
3. Write the brief with these sections:
   - **Goal:** what should change once the design appears, in one sentence, measurable if possible.
   - **Audience:** who they are, their context of use, and their language (Arabic, English, bilingual).
   - **Key message:** the one idea the recipient should leave with.
   - **Tone and personality:** 3 traits (for example: trustworthy, warm, modern) with one trait to avoid.
   - **Deliverables:** the required pieces, their formats and sizes.
   - **Constraints:** the budget, the deadline, an existing identity, legal or print requirements, writing direction.
   - **Success criteria:** how we will judge that the design succeeded.
   - **Inspiration references:** examples supplied by the user only, with what they like in each.
4. Mark [TBD] on every item the user did not provide and that cannot be safely inferred, and record the assumptions in a separate section.
5. End with a confirmation question: does the brief express what you meant?

## Output format
1. **Clarifying questions** (if needed): up to 5 numbered questions before the brief, and no final brief before they are answered if what is missing is essential.
2. **The brief** on one page with the sections: goal, audience, key message, tone and personality, deliverables, constraints, success criteria, inspiration references.
3. **Assumptions:** a list of every item you inferred or marked [TBD].
4. **The confirmation question** on the last line.

## Full example
**Input:** "I want an identity for a new coffee shop."

**Expected output:**
```text
Questions before the brief:
1. What is the closest goal: attracting neighborhood customers, or a brand that can scale?
2. Who is the main audience (students, employees, families)?
3. Where will the identity appear first (signage, cups, a social account)?
4. Is there a final name and what language is it in (Arabic, English, bilingual)?
5. What are the deadline and the approximate budget?

Preliminary brief (updated after your answers):
- Goal: [TBD]
- Audience: [TBD]
- Key message: [TBD]
- Tone: [TBD: 3 traits and one trait to avoid]
- Deliverables: a visual identity (logo, colors, fonts) [TBD: the other pieces]
- Constraints: writing direction [TBD], deadline [TBD]
- Success criteria: [TBD]
Assumptions: nothing so far except that the project is a new coffee shop.
Does this express what you meant?
```

## Edge cases
- **A request detailed enough:** do not ask extra questions; write the brief directly and mark only what is missing.
- **Conflicting answers (such as "luxurious" and "very economical"):** highlight the conflict and ask which wins, and do not reconcile them silently.
- **The user does not know their audience:** suggest two hypotheses and mark them as assumptions to verify, and do not provide market figures.
- **Several parties with different opinions:** record each party's opinion under a "points of disagreement" item and ask for the decision maker's call.
- **Inspiration references with no explanation:** ask what they like about each reference, and do not assume.
- **The user asks for a visual solution inside the brief:** record it as a preference stated by them, and keep the brief about the problem.

## Rules and limits
- Do not invent data about the audience, the market or competitors; whatever is not stated remains a marked assumption.
- Do not propose detailed visual solutions in the brief; its job is to define the problem, not the solution.
- Keep the brief to about one page.
- Word the brief so that it suits an Arabic or bilingual brand, and state the writing direction explicitly.
