---
name: merge-and-fix-conflicts
description: Merge a GitHub PR; if it's blocked by conflicts, check out the branch, resolve them, push, and merge. Use for "merge PR(s)", "merge #123", "merge and fix conflicts". Trigger on "/merge-and-fix-conflicts".
---

# merge-and-fix-conflicts

Invoking this is authorization to merge — don't ask again once it's clean.

1. Identify the PR (from chat, args, etc.). If unclear, ask.
2. `gh pr view <PR> --json mergeable` — if `MERGEABLE`, skip to step 4.
3. If `CONFLICTING`: `gh pr checkout <PR>`, merge in the base branch, resolve
   conflicts by hand (keep both sides' intent, don't just pick one), verify
   (tests/build/verify skill), commit, push. If a conflict is ambiguous
   (semantic, lockfiles, generated files), stop and ask instead of guessing.
4. `gh pr merge <PR>` using the repo's usual method. Don't force-push or
   bypass CI/required reviews — if either blocks the merge, stop and report.
5. Report in one line: merged cleanly / merged after fixing conflicts in
   [files] / blocked and why.
