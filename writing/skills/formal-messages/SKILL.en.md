---
name: formal-messages
description: Use when writing formal business messages such as follow-ups, apologies, requests, thanks and reminders.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Formal business messages

## When to use
- Writing a formal email or letter: follow-up, apology, request, reminder, thanks, polite refusal.
- Rewording an existing message to make it more formal and clear.

## Workflow
1. Identify the message type, the recipient (their relationship to the sender and their seniority), the purpose, the action requested from them and the deadline if any.
2. Identify the language (Arabic or English) and the tone (very formal, friendly-professional). If not specified, follow the language of the user's request.
3. Write a short, specific subject line.
4. Structure the message: greeting, the reason for writing in the first sentence, the necessary details, the request or required action with the deadline, a courteous closing, a signature.
5. In an apology: acknowledge the matter clearly without lengthy justification, and state what will be done to put it right.
6. In a request or follow-up: cite the earlier reference (a date or a subject) and make the ask a clear line.
7. Review the message: suitable length, correct language, free of hurtful or vague wording.
8. Provide a ready-to-send version and, when useful, a shorter or friendlier version.

## Output format
- **Subject:** one specific line.
- **Message body:** a greeting, then one or two short paragraphs, then the request on its own line, then a closing and signature.
- **Placeholders:** in square brackets, such as [Recipient name], collected in a "What you need to replace" line under the message.
- **Alternative version** (optional): shorter or warmer, under a clear heading.
- Usual length: 80 to 150 words unless the user asks otherwise.

## Full example
**Input:** "Write a follow-up message to a project manager who has not replied to my proposal for a week, in a polite tone."

**Expected output:**
```text
Subject: Follow-up on the proposal sent on [send date]

Dear [Recipient name],

I hope you are well.

I am writing about the proposal I sent on [send date], and I would like to
confirm that it reached you and whether you have any comments on it.

I would be glad to arrange a short call, or to answer any questions, so that
you can make your decision in good time. I would be grateful for your reply
before [suggested deadline].

Kind regards,
[Sender name]
[Job title] | [Company]

What you need to replace: [Recipient name], [send date], [suggested deadline],
[Sender name], [Job title], [Company].
```

## Edge cases
- **The recipient or their relationship to the sender is not stated:** assume a neutral professional tone, use [Recipient name], and state the assumption.
- **The request combines two conflicting tones (such as "very formal and very friendly"):** choose one dominant tone and offer an alternative version in the other.
- **A threatening or accusatory message is requested:** write a firm, courteous version that states the facts and the deadline without accusation, and tell the user so.
- **Missing details (a deadline, an amount, a reference number):** put [TBD] and do not invent a value.
- **The user wants a promise they did not mention (compensation or a discount):** do not include it; suggest it as an option for them to decide.
- **An existing message contains contradictory information (two dates for the same event):** point out the contradiction and ask which is correct before the final wording.

## Rules and limits
- Do not include real personal data; use clear placeholders such as [Recipient name], [Sender name], [Company], [Date] and [Reference number].
- Do not invent facts, dates or commitments the user did not state; mark them [TBD].
- Do not make promises on the user's behalf that they did not ask for (compensation, a deadline, a discount).
- Avoid a threatening or accusatory tone, even in reminders.
- Do not write deceptive messages or impersonate another party.
