# start-an-app

Interview the user in depth about what they actually want to build, then scaffold a working full-stack web app around it.

## What the skill does

- Runs requirements discovery before choosing a stack or writing code.
- Sets up the project, database (SQLite or Postgres in Docker), sign-in, transactional email, file uploads, payments, AI features and background jobs.
- Adds optional agent access over MCP so tools such as Claude can use the app.
- Builds a real landing page and dashboard, with public help documentation when useful.
- Agrees a design system with the user and writes it to `DESIGN.md` so every page matches.
- Creates an account-settings area with system logs and debugging built in.
- Adds the legal pages and cookie consent the app actually needs, and decides whether search engines and AI crawlers should find it.
- Closes with a verification pass proving the result builds, serves and does what was agreed.

## When to use

Use it when the user wants to start a new app, website, prototype or SaaS; when they don't know what tech stack to pick; or when they want a solid working starting point fast.

Do not use it to deploy an existing app (use `deploy-an-app`) or to audit one (use `review-an-app`).

## Example requests

- "I want to build a SaaS for freelancers — interview me and scaffold it."
- "Start a working app for a small team task tracker."
- "I don't know which stack to use; help me choose and build the first version."

## What to expect

| Output | Details |
|---|---|
| Requirements | A written brief with scope, users and decisions |
| Working app | Landing page, dashboard, auth and database wired end to end |
| Design system | `DESIGN.md` and matching UI across pages |
| Operations | Settings, logs, legal pages, cookie consent and SEO choices |
| Verification | Build, serve and behaviour checks with evidence |

## Requirements

Node.js and a modern browser; Docker is optional for Postgres. Accounts for email, payments or AI are only needed when the chosen scope includes them.
