---
name: incident-postmortem
description: Use when writing a post-incident report with a timeline, root cause and prevention actions, without blaming individuals.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Incident postmortem

## When to use
- After a service outage, a damaging defect or a data loss.
- Turning messy notes and logs into an organized report.
- Following up on prevention actions after an incident.

Do not use when: the cause is not yet known and you need to analyze the logs (`debug-logs`); the report is written once it is known.

## Workflow
1. Gather the facts from real sources: logs, alerts, the deploy log, incident chat, tickets. Ask for what is missing and do not assume it.
2. Define the impact: what was affected, who was affected, and when it started and ended, with the numbers available in the sources only (such as a duration, a recorded failure rate).
3. Build the timeline in a unified time zone (state it): the start of the fault, detection, response, mitigation, restoration, with the source of each item.
4. Analyze the root cause with a chain of "why" until you reach systemic causes (a missing check, weak alerting, a test gap), and distinguish between: the direct cause, the contributing factors, and what helped recovery.
5. Keep to **blameless** wording: describe actions and decisions in the context of the information available then, and change "so-and-so made a mistake" to "the system allowed...". Do not name individuals; use roles.
6. Suggest prevention actions: for early detection, mitigation, and preventing recurrence, each with a role owner, a suggested date and a priority.
7. Record what went well and what was luck, and what we learned.
8. Review the report with those involved before adopting it, and clearly mark what was not confirmed.

## Output format
```
# Postmortem: <title> (<date>)
Summary • Impact • Timeline • Root cause and contributing factors
• What went well / what did not • Prevention actions (action, role owner, priority)
• What we learned • Unresolved questions
```

## Rules and limits
- Do not invent timestamps, impact figures or causes; what is not proven appears under "unresolved questions".
- No blame and no names of individuals in the report; roles only.
- Do not include customer data, secrets or sensitive internal addresses.
- Do not present the root cause as fact if it is a hypothesis; call it a hypothesis.
- Do not promise that the actions will completely prevent recurrence; state only what they reduce.

## Checklist
- Every timeline item has a source.
- The actions are actionable and have a role owner.
- The wording is free of blame.

## Edge cases
- Several overlapping causes: present a tree of factors instead of an artificial single cause.
- An incident whose cause is unknown: document what was tried and what additional monitoring is needed to catch it when it recurs.
- A security incident: move the sensitive details to the organization's approved security channel.
- Missing logs: state the gap and add it to the prevention actions.

## Full example
### Input
Notes: a deploy at 10:02 (UTC) released a new version. At 10:05 5xx errors rose according to the alert. At 10:12 the on-call opened the incident. At 10:20 it was found that a new environment variable was not set in production. At 10:25 the deploy was rolled back. At 10:28 errors returned to their normal level.

### Output
```
# Postmortem: 5xx errors after deploying a new version (date: [TBD])
Summary: a version deployed at 10:02 UTC depended on an environment variable not set in production, so 5xx errors rose until the rollback.
Impact: from 10:05 to 10:28 UTC (23 minutes per the notes). Failed request rate: [TBD from monitoring].
Timeline (UTC): 10:02 deploy • 10:05 5xx alert • 10:12 incident opened • 10:20 cause identified • 10:25 rollback • 10:28 recovered.
Direct cause: a new environment variable missing from the production configuration.
Contributing factors: no automated check comparing the required variables to the environment configuration before deploy; no health check that fails early when configuration is absent.
What went well: the alert fired 3 minutes after the deploy; the rollback was carried out quickly.
Prevention actions: (1) a pipeline check for the required variables — owner: the platform team — high priority. (2) the application fails at startup when a mandatory setting is absent — owner: the service team. (3) review the health alert — owner: the on-call rotation.
Unresolved questions: why did the diagnosis take 8 minutes after the incident was opened? (needs a review of the logs).
```
