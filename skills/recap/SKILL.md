---
name: recap
description: Summarize this session and current state as terse bullets under optional headings (Context, Done, In progress, Next, Open questions). Use for "recap", "where are we", "catch me up", "what's the status", "summarize this session". Trigger on "/recap".
---

# recap

Cold-open status: readable with no scrollback. If in a git repo, check
`git status`/`diff`/`log` first — ground it in actual state, not memory.

## Output

Only print headings with real content — omit empty ones, never write "None".

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

- **Context** — task/repo/branch, 1-2 bullets max.
- **Done** — concrete completed work (commits, fixes, merges).
- **In progress** — what's mid-flight, including uncommitted edits.
- **Next** — concrete next actions, ordered if it matters.
- **Open questions** — anything blocked on the user.

Bullets only, one line each. No preamble, no closing summary, no follow-up
offer. Well under 10 bullets total unless the session truly warrants more.
