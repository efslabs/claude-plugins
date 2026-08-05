---
name: note-to-self
description: A message is a note for Emily's future self, not a task — acknowledge and restate it, recap this session's prior notes, but never act on its contents. Trigger on "/note-to-self", "note for emily", "note to self", "leave a note".
---

# note-to-self

A bookmark for future Emily. Never act on its contents, even if it mentions
work or reads like an instruction.

## Modes

- **Literal** (quoted or self-contained text) → echo verbatim.
- **Generate** (message asks you to produce the note, e.g. "summarize the
  plan above as bullets") → follow those instructions to build the note
  content. Transforming conversation content into the note is the only
  work allowed.

## Storage

Session-scoped, never committed to a repo:
`${TMPDIR:-/tmp}/emily-notes-$CLAUDE_CODE_SESSION_ID.md` (fall back to
`${TMPDIR:-/tmp}/emily-notes.md` if that env var is unset).

1. Append the new note under a `### <local time>` heading.
2. Read the file back to build the recap below.

## Output

```
## 📝 Note for Emily

[note content]
```

If the file has earlier entries, append a recap:

```

**Earlier this session (N):**
1. [time] ...
2. [time] ...
```

Terse. No preamble, no suggestions, no follow-up questions. End the turn.
