---
name: batch-prs
description: Work through a user-provided list of changes as a sequence of agent-implemented PRs — chunk the list, dispatch a background agent per chunk, review the diff, auto-merge when clean, and report progress between rounds. Use when the user lists multiple changes to make and wants them shipped iteratively ("here are the next changes", "work through these", "/batch-prs").
---

# Batch PRs — dispatch / review / merge loop

Turn a list of requested changes into merged PRs, one well-scoped chunk at a
time. You are the orchestrator: you scope, dispatch, review, and merge —
subagents implement. If anything gets complicated or ambiguous at any step,
pause and ask the user rather than guessing.

## The loop

1. **Chunk the list.** Restate the user's changes as discrete tasks. Combine
   changes that touch the same area into one PR; keep independent or risky
   ones separate. Share the chunking plan, and settle anything that needs
   user input (copy, naming, ambiguous scope) before dispatching that chunk.

2. **Pre-scout, then dispatch one background agent per chunk.** Read the
   relevant code yourself first and give the agent concrete anchors (files,
   line numbers, existing helpers/labels) — never dispatch "figure out where
   X lives". The agent should: follow the repo's CLAUDE.md, start its branch
   from the latest default branch (confirming any previous PR has merged),
   touch only what the chunk names, verify its work with whatever the project
   has (verify skill, tests, or a manual check), open a terse PR, and report
   back — but **never merge**.

3. **Review it yourself.** Read the actual diff (not just the agent's
   report), sanity-check anything deleted or added, confirm CI is green and
   the diff stays in scope.

4. **Merge or pause.** Clean review + green CI → merge without asking
   (match the repo's merge style). Anything off — questionable judgment
   call, scope creep, CI failure, mid-implementation ambiguity → pause and
   ask the user before merging.

5. **Post a status checklist after every merge**, before the next dispatch —
   each task with a visual indicator: ✅ merged (PR #) · 🔄 in review ·
   ⬜ pending · ❓ blocked on user.

6. **Wrap up** when the list is done: every PR with a one-liner, plus
   anything deferred or worth flagging.

## Ground rules

- One agent at a time unless chunks share no files.
- New requests mid-run join the checklist.
- If an agent's output is unusable, re-prompt or continue it — don't
  silently do the work inline.
- Merging is always the orchestrator's call, after review.
