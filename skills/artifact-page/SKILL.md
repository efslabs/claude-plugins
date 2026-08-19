---
name: artifact-page
description: Build a self-contained HTML artifact — an options review, system survey, implementation plan, postmortem, or reference collection — in the house design language, ready to commit into a repo's artifacts directory. Use when the user asks for a writeup, review, plan, or survey "as an artifact" or "as an HTML page", or when a piece of thinking is worth keeping rather than leaving in chat. Trigger on "/artifact-page", "make this an artifact", "write this up as a page".
---

# artifact-page

Artifacts are thinking that outlived its conversation: the options review you
want to reread in six months, the survey of a system before changing it, the
plan someone else has to follow. One HTML file, committed, no build step.

The document is the point. The page is a way to read it — not a place to
demo interaction.

## Workflow

1. **Settle the type.** `references/types.md` has spines for options review,
   system survey, implementation plan, postmortem, and reference. Say which
   one you're using and why in a sentence. If the material fits none, say so
   and structure it to its own argument.
2. **Get the content straight before the markup.** Artifacts are read for
   their claims, so the failure mode is a beautiful page that hedges. Take a
   position, name the tradeoff, and put what you're unsure about in writing.
   Ask when intent is genuinely unclear; otherwise state your assumption in
   the document and keep going.
3. **Build one file.** Paste in `references/base.css`, then add only the
   components the document needs from `references/components.md`.
4. **Self-check** (below), then hand off.
5. **Commit.** If the repo has a `save-artifact` skill, that skill owns the
   slug, the file location, and any registration migration — hand off to it
   rather than reimplementing. Otherwise write the file where the user asks.

## Hard constraints

An artifact is served under a strict CSP and framed on an opaque origin.
Everything off-origin fails silently and renders a broken page:

- **No external anything** — no CDN scripts, no webfonts, no remote images,
  no `fetch`. Inline all CSS and JS; system font stacks only.
- **No storage.** `localStorage` throws on an opaque origin. Nothing that
  needs to persist across a reload belongs in an artifact.
- **Theme comes from the OS, not the app.** The viewer can't reach into the
  frame, so `prefers-color-scheme` is the mechanism that fires. `base.css`
  handles this; don't replace it with a toggle.
- **Copy buttons work** — `clipboard-write` is delegated into the frame on
  purpose. They're the one interactive feature worth shipping.

Interactivity is opt-in and rare. A document with nothing to copy needs no
JavaScript, and two of the three artifacts built so far have none.

## Provenance

Every artifact gets, in the hero: a status eyebrow (`Exploration · nothing
built yet`, `Shipped 2026-08-02`, `Superseded — see …`), the date as a chip,
and a chip for anything the reader needs to know is unresolved
(`4 open decisions`). These documents age, and one that can't be told apart
from a live plan is worse than no document.

Close with the open decisions — every type ends this way. Name what you'd
need answered, not "further work is needed".

## Self-check before handing off

- `grep -nE 'https?:|//[a-z0-9-]+\.[a-z]{2,}|fetch\(|localStorage|@import|@font-face'`
  over the file comes back clean.
- Renders in both themes — check the dark block actually mirrors the light one.
- Real `<title>`; `id` on every section a TOC or link points at.
- Readable at 380px; tables wrapped in `.tscroll`.
- Print preview isn't wrecked (`base.css` covers this — don't undo it).

## Don't

- Don't restate the conversation. If a paragraph doesn't advance a claim,
  cut it.
- Don't number things that aren't sequential, and don't add a TOC under
  ~8 sections.
- Don't invent a second name for a component in `components.md`, and don't
  rename its tokens — cross-artifact consistency is most of the value.
- Don't build a new artifact for a revision of an existing one. Edit the
  file in place.
