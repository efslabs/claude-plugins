---
name: build
description: Turn a list of requested changes into shipped PRs — chunk the work, dispatch agents to implement, review the diff yourself (optionally dispatching separate review/test agents for complicated changes), fix or re-dispatch until it's clean, then merge. Use when the user lists changes to make and wants them built and shipped ("here are the next changes", "build these", "work through this list", "/build").
surfaces: code
---

# build — dispatch / review / fix / merge loop

Turn a list of requested changes into merged PRs, one well-scoped chunk at a
time. You are the orchestrator: you scope, dispatch, review, and decide —
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
   touch only what the chunk names, verify its work (verify skill, tests, or
   a manual check), open a terse PR, and report back — but **never merge**.

3. **Review it yourself.** Read the actual diff (not just the agent's
   report), sanity-check anything deleted or added, confirm CI is green and
   the diff stays in scope. Use judgment on whether it's worth dispatching a
   separate review/test agent for a second opinion — a large diff, anything
   touching auth/payments/migrations, or a change with no existing test
   coverage to lean on are good signs it's warranted.

4. **Fix or re-dispatch.** Anything wrong: re-dispatch the *same* agent with
   itemized, concrete feedback — it already has the branch and context.
   Patch it yourself only for trivial, unambiguous fixes (typo, lint,
   one-liner). Spin up a fresh agent only if the original is stuck or its
   branch is unrecoverable, and hand it your own diagnosis, not "figure out
   what's wrong."

5. **Merge or pause.** Once the diff is clean and CI is green, invoke the
   **merge** skill to merge it — don't duplicate conflict-resolution logic
   here. Default is merge without asking, unless the user opted out for this
   run. Anything off — scope creep, CI failure, mid-implementation ambiguity
   — pause and ask the user before merging.

6. **Post a status checklist after every merge**, before the next dispatch —
   each task with a visual indicator: ✅ merged (PR #) · 🔄 in review ·
   ⬜ pending · ❓ blocked on user.

7. **Wrap up** when the list is done: every PR with a one-liner, plus
   anything deferred or worth flagging.

## Ground rules

- One agent at a time unless chunks share no files.
- New requests mid-run join the checklist.
- Merging is always the orchestrator's call, made after review — but
  executed via the **merge** skill, not reimplemented here.
