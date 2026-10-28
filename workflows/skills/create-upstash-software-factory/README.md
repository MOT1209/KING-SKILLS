# create-upstash-software-factory

Set up a "software factory" that turns labelled GitHub issues into reviewed pull requests using coding agents running in Upstash Box sandboxes.

## What the skill does

- Creates the GitHub Actions workflow that starts an agent when an issue receives the factory label.
- Configures a worker image or snapshot with the chosen coding agent (Claude Code, Codex or another CLI agent).
- Wires the Upstash Box sandbox lifecycle, credentials and repository checkout.
- Adds repository, agent type, worker count, model and effort settings.
- Documents the runbook, failure recovery and how to extend the factory with another repo or agent.

## When to use

Use it when someone wants to build, recreate, extend or debug an issue-to-PR pipeline, a pool of background coding agents, "agents that work on my GitHub issues", a label-triggered agent workflow, or anything that combines Upstash Box with coding agents and GitHub — even if they never say "software factory".

Do not use it for a one-off coding task that a single agent session can finish; this skill builds the repeatable pipeline around the agent.

## Example requests

- "Set up a factory where labelling an issue makes an agent open a PR."
- "Add a second repo and a Codex worker to my existing software factory."
- "My issue-to-PR workflow is failing — debug it."

## What to expect

| Output | Details |
|---|---|
| GitHub automation | Workflow, label trigger, permissions and secrets wiring |
| Worker environment | Dockerfile or snapshot and agent CLI setup |
| Factory configuration | Repos, agents, workers, model and effort settings |
| Operations docs | Runbook, troubleshooting and extension guide |

## Requirements

A GitHub repository where you can add workflows and secrets, an Upstash account and API key, and credentials for the coding agent. Docker is optional when building a custom worker image.
