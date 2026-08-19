# claude-plugins

Personal Claude Code plugin repo — one plugin (`emily`) carrying reusable
skills, plus the marketplace manifest so it can be installed anywhere.

## Install

```
/plugin marketplace add efslabs/claude-plugins
/plugin install emily@efslabs
```

(The marketplace is named `efslabs`, not `claude-plugins` — marketplace
names containing "claude" are rejected as impersonating official ones.)

For Claude Code on the web, declare the plugin in a repo's
`.claude/settings.json` so cloud sessions fetch it at start.

## Skills

| Skill | Invoke as | What it does |
|---|---|---|
| [artifact-page](skills/artifact-page/SKILL.md) | `/emily:artifact-page` | Build a self-contained HTML artifact — options review, system survey, plan, postmortem, reference — in the house design language, ready to commit. |
| [build](skills/build/SKILL.md) | `/emily:build` | Work through a list of changes as a sequence of agent-implemented PRs: chunk, dispatch, review (optionally with dedicated review/test agents), fix or re-dispatch, merge via `merge`. |
| [merge](skills/merge/SKILL.md) | `/emily:merge` | Merge a GitHub PR; if blocked by conflicts, check out the branch, resolve them, push, and merge. |
| [note-to-self](skills/note-to-self/SKILL.md) | `/emily:note-to-self` | Leave a note for future Emily — acknowledge and store it, never act on it, recap prior notes from the session. |
| [session-status](skills/session-status/SKILL.md) | `/emily:session-status` | Summarize this session and current state as terse bullets — what it's about, what's done/in progress/next, whatever fits the conversation. |

## Layout

```
.claude-plugin/plugin.json       plugin metadata (name: emily)
.claude-plugin/marketplace.json  marketplace manifest (this repo is its own marketplace)
skills/<name>/SKILL.md           one directory per skill
skills/<name>/references/        optional — material the skill loads on demand
```

New skills: add `skills/<name>/SKILL.md`, bump `version` in plugin.json.
Keep `SKILL.md` short enough to read in one pass; anything long (catalogs,
CSS to paste, per-case detail) belongs in `references/`.
