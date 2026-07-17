---
name: recap
description: Summarize this session and current state as terse bullets under optional headings (Context, Done, In progress, Next, Open questions). Use for "recap", "where are we", "catch me up", "what's the status", "summarize this session". Trigger on "/recap".
---

# recap

Cold-open status: readable with no scrollback. Base it primarily on this
session's chat. If in a git repo, a quick `git status`/`diff`/`log` can
catch uncommitted or committed work the chat glossed over — use it to
supplement the recap, not replace it.

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

Bullets only, one line each. No preamble, no closing summary, no follow-up
offer. Well under 10 bullets total unless the session truly warrants more.
