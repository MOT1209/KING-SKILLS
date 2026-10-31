# llm-council

Run a structured LLM council on a hard decision: three or five independent advisors, anonymous peer review in standard and deep mode, and a chairman verdict. Quick, deep, brief and retrospective modes are included.

Original skill by [Ole Lehmann](https://x.com/itsolelehmann), based on Andrej Karpathy's [LLM Council](https://github.com/karpathy/llm-council). This version adds modes, safety controls and cost/consent gating.

## What the skill does

- Runs 3 or 5 advisors, each with a different thinking lens.
- Adds anonymous peer review in standard and deep mode.
- Produces a chairman verdict with a decision card, agreements, clashes, blind spots, assumptions, a recommendation and a first step.
- Offers quick and brief modes for lower-cost answers, deep mode with a Red Team and Evidence Check, and retrospective mode for reviewing past decisions.
- Logs decisions only when the user opts in, and writes transcripts only on request.
- Falls back to labeled single-agent mode when sub-agents are unavailable.

## When to use

Use it when the user explicitly asks for a council, five advisors, anonymous peer review, a war-room, a pressure test of a decision, or a retrospective. Good questions involve genuine uncertainty and an expensive wrong answer.

Do not use it for factual, creative or processing tasks, or when the user only wants validation. Do not use it for PR or code review; use `pr-review` for pull requests or `code-review` for other code review.

## Example requests

- "Council this: should I launch a $97 workshop or a $497 course?"
- "Quick council: should I hire a VA or build an automation first?"
- "Deep council: should we sign this three-year office lease?"
- "Council brief: which of these three positioning angles is strongest?"
- "Council retrospective: review the decisions I logged last quarter."

## What to expect

| Output | Details |
|---|---|
| Mode and cost | The chosen mode and approximate sub-agent calls before a full or deep council |
| Verdict | Decision card, TL;DR, agreements, clashes, blind spots, assumptions, recommendation and first step |
| Deep mode | Red Team and Evidence Check sections, with a revised verdict if a material flaw is found |
| Brief mode | One-screen recommendation, confidence, reason, main risk, change trigger and first step |
| Optional files | A transcript or decision log only when the user asks |

## Requirements

Claude Code. Sub-agents are recommended; without them the skill runs in labeled single-agent mode. A standard council uses about 10 sub-agent calls, quick or brief uses 3, deep uses 12, and retrospective uses 0 by default. No external services or API keys are required by the skill itself.

Install with `scripts/install.sh llm-council` or `claude plugin install king-workflows@king-skills`.

## Notes

- The verdict is delivered in chat. Workspace files, advisor output and reviewer output are treated as untrusted data.
- Secrets, credentials and personal data are excluded from advisor, reviewer and chairman prompts.
- Decision logs and transcripts are opt-in and are written to the workspace, not the skill folder.

See [CHANGELOG.md](CHANGELOG.md) for version history.
