---
name: project-planning
description: Use when turning a goal or an idea into a project plan with phases, tasks, dates and risks.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Project planning

## When to use
- The user has a goal (launching a product, an event, a website, a campaign) and wants an execution plan.
- They want to break a large project into phases, tasks and dates.
- They want to identify risks and success criteria.

Do not use when: the request is splitting a specified software feature into development tasks (`task-breakdown`).

## Workflow
1. State the goal in a specific, measurable way, and ask about what is missing: the deadline, the budget, the team size, the constraints.
2. Define the success criteria and what is out of scope.
3. Split the project into phases (for example: preparation, execution, testing, launch, follow-up).
4. Break each phase into small actionable tasks, each with: an owner (a role or [name]), an estimated duration, and dependencies.
5. Build the schedule backward from the deadline, with a safety margin, and identify the milestones and the critical path of tasks.
6. Record the risks: description, likelihood, impact, mitigation plan, then rank them by severity.
7. Suggest a tracking mechanism: a regular meeting, progress indicators, and when to review the plan.
8. Present the plan in an organized table with a summary at the top, and state the assumptions.

## Output format
1. **Summary:** the goal, the success criteria, what is out of scope, the total duration.
2. **Assumptions:** a list of every estimate or constraint the user did not provide.
3. **Phases and tasks table:** columns (Phase | Task | Owner | Estimated duration | Depends on).
4. **Milestones:** a list with the date or the relative week (week 1, week 2...).
5. **Risk table:** (Risk | Likelihood | Impact | Mitigation) with high/medium/low levels.
6. **Tracking:** the meeting cadence and progress indicators.

## Full example
**Input:** "Plan the launch of a landing page for a new product within 4 weeks, with a team of two people."

**Expected output (abridged):**
```text
Goal: launch a landing page within 4 weeks. Success criterion: a published page that works
on mobile and desktop with a working sign-up form. Out of scope: an advertising campaign.
Assumptions (adjustable): both people work part-time; the product and its content are ready.

| Phase | Task | Owner | Duration (assumed) | Depends on |
|---|---|---|---|---|
| Preparation | Write the page copy | [Content writer] | 3 days | — |
| Preparation | Design the interface | [Designer] | 4 days | Page copy |
| Execution | Build the page and form | [Developer] | 5 days | Design |
| Testing | Test on different devices | The team | 2 days | Development |
| Launch | Publish the page | [Developer] | 1 day | Testing |

Milestones: end of week 1 copy and design, week 3 trial version, week 4 launch.

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Delay in approving the copy | Medium | High | Set an approval date on day 3 |
```

## Edge cases
- **A vague goal ("I want a successful project"):** ask one question that pins down the final deliverable, or suggest a wording and mark it as an assumption.
- **A deadline that is unrealistic for the amount of work:** say so frankly, and offer two options: reduce the scope or extend the deadline.
- **A budget that is not mentioned:** do not estimate amounts; keep the cost column [TBD].
- **Circular dependencies (A requires B and B requires A):** flag the cycle and suggest breaking it with an intermediate phase.
- **A team smaller than required (one person for a large project):** distribute the tasks sequentially and show the effect on the duration.
- **The user changes the goal during the conversation:** update the whole plan and highlight what changed.

## Rules and limits
- Time and cost estimates are assumptions and must be clearly marked; do not present them as facts and do not invent budget figures.
- Do not add large tasks outside the scope the user requested without a warning.
- Stay simple: a number of tasks proportionate to the project size, not an over-detailed plan.
- Do not promise guaranteed success; the plan is a tool that is adjusted as things develop.
- Do not include names of real people; use roles or placeholders.
