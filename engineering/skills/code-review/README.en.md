# code-review — code review

> English translation of [README.md](README.md).

## What the skill does
Reviews the code you provide for logic bugs, security vulnerabilities and performance issues, explains the reason for each finding, and suggests a clear fix.

## When to use it
- Before merging a pull request.
- When you suspect a defect or a vulnerability in a function or a file.
- To improve the performance of a slow part of the code.

## Example requests
1. "Review this function for bugs and security vulnerabilities: [paste code]"
2. "Review the changes in the current branch compared to main and focus on performance."
3. "This query slows down as the data grows: [paste code]. What is the likely cause and how do I fix it?"

## What to expect
| Item | What you get |
|---|---|
| The findings | Ordered from most to least severe: location, severity, reason, fix |
| Confirmation | Confirmed findings only; unconfirmed ones are marked "possible" |
| The summary | The number of findings by severity and a recommendation to merge or change |
| Security | A description of the vulnerability and its fix without exploit code |
