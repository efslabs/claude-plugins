---
name: recap
description: Summarize this session and the current state of work as terse bullets under optional headings (Context, Done, In progress, Next, Open questions). Use when the user asks to recap, catch them up, or summarize status — "recap", "where are we", "catch me up", "what's the status", "summarize this session" — especially after a long session or before picking work back up later. Trigger on "/recap".
---

# recap

A cold-open status summary: someone reading only this should know where things
stand without scrolling back through the session.

## Before writing

If in a git repo, ground the recap in actual state rather than memory alone —
check `git status`, `git diff`, and recent `git log` to catch uncommitted
edits or commits the conversation summary might have glossed over.

## Output

Print only the headings that have real content — skip any section with
nothing to say. Never print a heading with "None" or leave it empty.

```
## Context
- ...

## Done
- ...

## In progress
- ...

## Next
- ...

## Open questions
- ...
```

- **Context** — task, repo/branch/PR, why this session exists. 1-2 bullets max.
- **Done** — concrete completed work: commits, merged PRs, fixed bugs. Skip
  exploratory dead ends.
- **In progress** — what's mid-flight right now, including uncommitted edits.
- **Next** — concrete next actions, ordered if sequence matters.
- **Open questions** — decisions blocked on the user, unresolved ambiguities.

## Rules

- Bullets only, one line each — no prose paragraphs.
- No preamble before the headings, no closing summary or follow-up offer
  after them.
- Stay grounded in what actually happened/exists — don't speculate beyond
  what the session and repo state support.
- Keep it scannable: well under 10 bullets total unless the session genuinely
  spans that much.
