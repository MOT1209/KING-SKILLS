---
name: e2e-test-plan
description: Use when drafting end-to-end test scenarios for critical flows and deciding which of them to automate.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# E2E test plan

## When to use
- Before launching a critical feature or flow (sign-up, payment, booking).
- Building an end-to-end test suite (Playwright, Cypress or an equivalent).
- Deciding what deserves automation and what is left to manual testing or lower-level tests.

Do not use when: the request is for unit tests of a function or class (`unit-test-writer`).

## Workflow
1. Identify the critical flows by their impact on the user and the business: what, if broken, would stop work or lose money or data.
2. For each flow write the scenario from the user's point of view: the role, the starting point, the steps, the visible expected result.
3. Add the important failure paths, not only the happy path: wrong data, network failure, session expiry, insufficient permissions.
4. Define the environment and data requirements: test accounts, seed data, external services replaced by simulators, and how data is cleaned up after the test.
5. Choose the priority: P0 (run with every merge), P1 (before release), P2 (periodically).
6. Design to avoid brittleness: stable selectors (such as `data-testid` or roles), waiting for conditions rather than fixed timeouts, and independence of each test from the others.
7. Decide what is tested at lower levels (unit/integration) and what stays E2E only; do not repeat what cheaper tests cover.
8. State how it is run in CI, the reports, and limited retries with a record of what failed and then passed.

## Output format
A scenario table (ID, flow, priority, steps, expected result, data, automation: yes/no), then the environment requirements, then risks and open issues.

## Rules and limits
- Do not use real production data or real accounts; use test accounts and fake data.
- Do not hide an intermittent failure with open-ended retries; investigate its cause.
- Do not estimate run time or coverage percentages with numbers that were not measured.
- Do not test actual external providers (payment, for example) except in their official sandbox environment.

## Checklist
- Every P0 scenario is independent and can be run alone.
- Every scenario has an observable expected result.
- Test data is created and cleaned up automatically.
- The Arabic/RTL interface is covered if supported.
- The P0 set is small enough to run with every merge, and the rest is scheduled.

## Edge cases
- An external service unavailable in CI: use a simulator and document the difference from reality.
- A flow that depends on email or messages: use a dedicated test inbox.
- Concurrent users: add a scenario for concurrent modification if it matters.
- Multiple languages and directions: test at least one language in each direction.
- A flow that cannot be automated reliably (CAPTCHA, real two-factor authentication): suggest disabling it in the test environment or a documented manual test instead of a brittle test.
- Data shared between parallel tests: create isolated data for each test or run them sequentially.

## Full example
### Input
"An appointment booking system. The flow: the patient signs in, chooses a doctor, books an appointment, and receives a confirmation."

### Output
| ID | Scenario | P | Short steps | Expected result | Automate |
|---|---|---|---|---|---|
| E1 | Successful booking | P0 | sign in → choose doctor → choose time → confirm | A confirmation page with the booking number appears, and the appointment is in "My appointments" | yes |
| E2 | Already booked slot | P0 | book the same time from two accounts | The second sees an "appointment unavailable" message and no duplicate booking is created | yes |
| E3 | Session expires during booking | P1 | delete the session before confirming | Redirect to sign-in without losing the selection | yes |
| E4 | Arabic RTL interface | P1 | repeat E1 in Arabic | Direction and alignment are correct, and numbers and dates are readable | yes |
| E5 | Confirmation email | P2 | after E1 check a test inbox | A message with the details arrives | manual/later |

Environment: test accounts and fake doctors, a controllable clock, a simulator for the email service. Open issue: the cancellation policy before the appointment (needs specifications).
