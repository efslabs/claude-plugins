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
| [batch-prs](skills/batch-prs/SKILL.md) | `/emily:batch-prs` | Work through a list of changes as a sequence of agent-implemented PRs: chunk, dispatch, review, auto-merge when clean, report progress between rounds. |
| [merge-and-fix-conflicts](skills/merge-and-fix-conflicts/SKILL.md) | `/emily:merge-and-fix-conflicts` | Merge a GitHub PR; if blocked by conflicts, check out the branch, resolve them, push, and merge. |
| [note](skills/note/SKILL.md) | `/emily:note` | Leave a note for future Emily — acknowledge and store it, never act on it, recap prior notes from the session. |
| [recap](skills/recap/SKILL.md) | `/emily:recap` | Summarize this session and current state as terse bullets (Context, Done, In progress, Next, Open questions). |

## Layout

```
.claude-plugin/plugin.json       plugin metadata (name: emily)
.claude-plugin/marketplace.json  marketplace manifest (this repo is its own marketplace)
skills/<name>/SKILL.md           one directory per skill
```

New skills: add `skills/<name>/SKILL.md`, bump `version` in plugin.json.
