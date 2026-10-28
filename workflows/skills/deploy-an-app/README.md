# deploy-an-app

Take a Next.js app that runs on the user's machine and put it into production on Vercel, then prove the live site actually works.

## What the skill does

- Runs a preflight and detects the stack, build command and runtime requirements.
- Provisions Postgres and Blob storage, and converts a SQLite app so it can run on a read-only filesystem.
- Sets every environment variable and validates them before the first deploy.
- Wires custom domains and DNS, OAuth callback URLs, email-domain verification, background jobs and payments.
- Adds optional agent access over MCP.
- Closes with a verification pass that checks the deployed site rather than taking the deploy's word for it.

## When to use

Use it when the user wants to deploy, ship, publish, launch or go live with an app; when they have finished building and ask how to put it online; or when an already-deployed app needs a database, a custom domain, an email domain or an integration wired up properly.

Do not use it to start a new app from scratch (use `start-an-app`) or to audit an existing deployed app (use `review-an-app`).

## Example requests

- "Deploy this Next.js app to Vercel with a Postgres database."
- "Connect my domain and make sure the live site really works."
- "Move this SQLite app to production storage and wire email."

## What to expect

| Output | Details |
|---|---|
| Deployment plan | Stack detection, preflight results and required services |
| Provisioned services | Database, storage, environment variables and domains |
| Integrations | Auth callbacks, email, jobs, payments and optional MCP |
| Proof | A live URL plus evidence that the deployed app serves and works |

## Requirements

The app source, a Vercel account and CLI login, and accounts for any additional providers the app needs. The skill asks before creating paid resources.
