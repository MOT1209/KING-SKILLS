---
name: ux-review
description: Use when walking through a user task step by step to find points of hesitation and confusion, and ranking findings by impact with a proposed fix for each.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# UX review

## When to use
- Reviewing a flow (sign-up, purchase, booking) from screenshots, a description or a prototype.
- Looking for the reason users drop off or why support receives many questions.

Do not use when: the request is an accessibility audit against WCAG (`accessibility-check`).

## Workflow
1. Define the task precisely: who the user is, what their goal is, where they start, and what success means. Ask for the flow materials (screenshots, a link, a description).
2. Do not assume what you have not seen: if a screen is unavailable, ask for it or mark the step "not reviewed".
3. Split the task into consecutive steps, and in each step record: what the user sees, what is asked of them, what they expect, and what happens next.
4. Identify the points of hesitation and confusion in each step: vague wording, too many options, an unclear primary button, no response to an action, incomprehensible error messages, information requested too early, a direction or language conflict in RTL.
5. Draw on well-known principles and name them when citing, such as Nielsen's 10 Usability Heuristics; and do not attribute to them what they do not contain.
6. Rate each finding: the impact (high/medium/low) and the approximate effort to fix (low/medium/high), and make clear that the rating is an expert judgment, not a measurement.
7. Order the findings by impact first, then lower effort.
8. For each finding: the step, the problem, why it hinders the user, the proposed fix (as text or a layout), and how to verify it worked.
9. End with a list of what works well, and questions that need research with real users.

## Output format
1. **Task and scope:** the user, the goal, the starting point, the success criterion, and what was not reviewed.
2. **Step trace:** a table (Step | What the user sees | What is asked of them | The confusion point).
3. **Findings** ordered by impact then effort, each with: the step, the problem, why it hinders, the fix, how to verify, the impact, the effort.
4. **What works well.**
5. **Questions that need research with real users.**

## Full example
**Input:** "Review an appointment booking: 1) the service selection screen, 2) the time selection screen, 3) a confirmation screen with a 'Continue' button and nothing after it."

**Expected output:**
```text
Task: a new user books an appointment. Success: seeing a confirmation message. Not reviewed: payment, if any.

| Step | What they see | What is asked | The confusion |
|---|---|---|---|
| 1 | A list of services | Choose one | Nothing evident |
| 2 | A calendar and times | Choose a time | It is not shown that the chosen time was saved |
| 3 | A summary and a "Continue" button | Press it | It is unclear whether "Continue" confirms the booking or moves to another step |

1) [Impact: high | Effort: low] Step 3 — the button is ambiguous
- Problem: "Continue" does not say the booking will be completed.
- Why: the user does not know whether the booking happened, and may call support (principle: Visibility of system status).
- Fix: change the text to "Confirm booking" and show a success page after it.
- Verify: 3 users try the booking without prompting, and name what happened after pressing.

2) [Impact: medium | Effort: low] Step 2 — the chosen time is not highlighted
- Fix: highlight the chosen time with color and a second cue other than color.

Works well: a small number of steps.
The impact stated is an expert judgment, not a measurement, and does not replace testing with real users.
```

## Edge cases
- **Incomplete screenshots (a missing step):** mark the step "not reviewed" and ask for it, and do not guess its content.
- **The flow description contradicts the screenshots:** report the conflict and ask which is the reference.
- **The user asks for numbers (a drop-off rate):** make clear that an expert review does not measure, and suggest what can be measured and how.
- **A very long flow (more than 10 steps):** review the critical steps first, and state what was deferred.
- **A finding based on personal preference:** classify it as "preference" in a separate section.
- **An RTL interface where elements appear mirrored by mistake:** list them as a separate finding with its step.

## Rules and limits
- Do not claim figures (a drop-off rate, a completion time) that were not provided to you or measured.
- An expert review does not replace testing with real users; say so.
- Distinguish a functional problem from a personal preference.
- Do not suggest a complete redesign when changing a text or an order is enough.
- Do not use users' personal data in the examples.
