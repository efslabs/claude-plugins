# claude-plugins

Personal Claude skills. This repo is the **single source of truth** — Claude Code
gets these skills through the `emily` plugin, and claude.ai gets them as `.skill`
zips built from the same `SKILL.md` files.

## Install (Claude Code)

```
/plugin marketplace add efslabs/claude-plugins
/plugin install emily@efslabs
```

(The marketplace is named `efslabs`, not `claude-plugins` — marketplace names
containing "claude" are rejected as impersonating official ones.)

For Claude Code on the web, cloud sessions load plugins declared in the repo you
open, not from your user settings. Commit this to `.claude/settings.json` in any
repo where the skills should be available:

```json
{
  "extraKnownMarketplaces": {
    "efslabs": { "source": { "source": "github", "repo": "efslabs/claude-plugins" } }
  },
  "enabledPlugins": { "emily@efslabs": true }
}
```

Worth doing for the few repos you actively open web sessions in — each
declaration is a fetch at session start. Local machines are covered by the
user-level install above.

## Skills

| Skill | Invoke as | Surfaces | What it does |
|---|---|---|---|
| [build-html-artifact](skills/build-html-artifact/SKILL.md) | `/emily:build-html-artifact` | both | House conventions for single-file HTML artifacts — reports, dashboards, guides, reference pages, and runbook pages of editable/copyable code blocks. |
| [build](skills/build/SKILL.md) | `/emily:build` | code | Work through a list of changes as agent-implemented PRs: chunk, dispatch, review, fix or re-dispatch, merge. |
| [merge](skills/merge/SKILL.md) | `/emily:merge` | code | Merge a GitHub PR; if blocked by conflicts, check out the branch, resolve, push, merge. |
| [note-to-self](skills/note-to-self/SKILL.md) | `/emily:note-to-self` | both | Leave a note for future Emily — acknowledge and store it, never act on it. |
| [session-status](skills/session-status/SKILL.md) | `/emily:session-status` | both | Summarize this session and current state as terse bullets. |

**Surfaces** is an optional `surfaces: code` frontmatter key meaning "Claude Code
only" — skills that drive git, PRs, or agents are useless in claude.ai chat.
Omit the key for skills that belong on both. `build.sh` skips `code` skills when
packaging and strips the key from what it packages, since claude.ai rejects
frontmatter keys it doesn't recognize.

## Releasing a skill change

Claude Code picks up merged changes on its own. claude.ai has no sync and no
upload API — its copies are manual, so the repo tracks which ones have gone stale.

1. Edit `skills/<name>/SKILL.md` on a branch; bump `version` in `plugin.json`; merge.
2. `./build.sh status` — shows `current` / `STALE` / `never uploaded` per skill.
3. `./build.sh` — writes `dist/<name>.skill` for every claude.ai-bound skill.
4. Upload the stale ones at claude.ai → Customize → Skills (delete the old copy
   first if the name collides), then toggle them on.
5. `./build.sh mark <name>` and commit `uploaded.tsv` — that file is the record
   of what's live on claude.ai.

Staleness is a content hash of the skill directory, so `status` stays honest
without anyone maintaining a version number by hand.

## Layout

```
.claude-plugin/plugin.json       plugin metadata (name: emily)
.claude-plugin/marketplace.json  marketplace manifest (this repo is its own marketplace)
skills/<name>/SKILL.md           one directory per skill
build.sh                         package skills as .skill zips; track upload staleness
uploaded.tsv                     what's currently uploaded to claude.ai
dist/                            build output (gitignored)
```

`agents/`, `commands/`, and `hooks/hooks.json` can be added at the repo root
later — the plugin loader discovers them without manifest changes.

New skills: add `skills/<name>/SKILL.md`, bump `version` in plugin.json.
