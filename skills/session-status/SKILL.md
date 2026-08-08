---
name: session-status
description: Summarize this session and current state as terse bullets — for work sessions typically Context, Done, In progress, Next, Open questions; otherwise whatever structure fits. Use for "recap", "where are we", "catch me up", "what's the status", "what were we working on". Trigger on "/session-status".
---

# session-status

Cold-open status for someone returning to this session after time away or
from another session: readable with no scrollback. Base it primarily on this
session's chat — a quick `git status`/`diff`/`log` (if in a git repo) can
catch uncommitted or committed work the chat glossed over, but supplements
the recap, never replaces it.

## Output

Terse bullets, one line each, under short headings that fit the conversation.
Default for work sessions: Context, Done, In progress, Next, Open questions.
A discussion or research session may call for different headings, or none.
Only print headings with real content — omit empty ones, never write "None".

No preamble, no closing summary, no follow-up offer. Well under 10 bullets
total unless the session truly warrants more.
