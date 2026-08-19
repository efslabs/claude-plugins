---
name: build-html-artifact
description: "Build polished single-file HTML artifacts: reports, dashboards, guides, comparison/reference pages, and dark runbook-style pages of editable, copyable code blocks. Use for any \"make me an HTML page / artifact / report / dashboard\" request, and for runbook or prompt-library asks — \"HTML page of my favorite prompts\", \"turn this framework into a runbook\", \"copyable code blocks\". Triggers on: HTML artifact, HTML page, HTML report, dashboard, runbook, prompt library, editable code blocks, copyable prompts."
---

# HTML Artifacts

One self-contained HTML file. Part 1 applies to every artifact; Part 2 is per-type playbooks — apply the matching one, ignore the rest. This skill supplies non-negotiable mechanics, house defaults, and structure; you keep design judgment.

## Workflow

1. **Get the content.** If its shape is ambiguous (flat list vs. grouped vs. sequential vs. data-vs-prose), ask one question; otherwise state your assumption and build.
2. **Pick the type** (Part 2). Hybrids are fine — a guide whose steps hold copyable blocks borrows the code-block machinery.
3. **Build** one file: Part 1 mandatory items, Part 1 defaults unless there's a reason not to, plus the type playbook.
4. **Deliver per environment:**
   - claude.ai container (`/mnt/user-data/` exists) → write `/mnt/user-data/outputs/<kebab-name>.html` and present it.
   - Claude Code / anywhere with an Artifact publish tool → write locally, publish via the Artifact tool, following its conventions (it wraps content in its own doctype/head/body skeleton) and any companion skill it requires.
   - Anywhere else → write the file and give its absolute path.

# Part 1 — Universal rules

## Mandatory — skipping these breaks the artifact

- **Self-contained, zero external resources.** No CDN scripts, webfonts, remote images, or outbound `href`/`src`. Sandbox CSP blocks network requests; the file must render identically with the network off. Inline everything; data: URIs for images if truly needed.
- **Never `href="#id"` for in-page links.** Fragment links resolve against the sandbox origin in claude.ai's iframe and read as external navigation. Use `data-goto="id"` + `role="link"` + `tabindex="0"`; handle click and Enter/Space with `scrollIntoView` (smooth unless reduced-motion). Give targets an `id` and some `scroll-margin-top`.
- **Escape user content** (`& < >`) before injecting into `innerHTML`. Placeholders like `[INSERT DATE]` stay literal.
- **localStorage in try/catch.** Every call — it throws in the artifact sandbox and must silently no-op.
- **`innerText` returns empty for `display:none` elements.** If readable content can ever be hidden (collapsed cards, tabs, filtered rows), every read of it — copy, save, count, re-render — goes through:

```js
function txt(el){const t=el.innerText;return(t===undefined||t==='')?el.textContent:t;}
```

## Strong defaults — use unless the user or the content argues otherwise

- **Palette** — Emily's house default (dark, amber/cyan on near-black); restyle on request or when content demands (keep the variable names so components port). For a requested light page: invert ink/text roles, dim accents for contrast.

```css
:root{
  --ink:#0F1218; --panel:#161B24; --panel-2:#1B2330;
  --line:#2A3341; --line-soft:#222A36;
  --text:#DCE1E9; --muted:#828C9E; --muted-2:#5B6473;
  --amber:#EBA43B; --amber-dim:#B57E2C; --cyan:#57BECE;
  --code-bg:#0B0E13; --ok:#66C089;
}
```

- **System font stacks only** (sans + `ui-monospace` mono via CSS vars). Display type differentiates by weight (700–800) and tight tracking, not typeface. Amber = primary accent/numbering; cyan = attention (Stop/Wait); green only for success.
- **TOC** after the hero for 3+ sections (mono links, one column per section, all `data-goto`); **back-to-top** for pages taller than a few screens (fixed bottom-right, appears past ~400px scroll, `{passive:true}` listener). Probe `prefers-reduced-motion` once into a shared boolean; pair `html{scroll-behavior:smooth}` with an `auto!important` reduced-motion override.
- **Footer provenance stamp:** version · date · one line on what the file is. It must explain itself months later without the conversation that produced it.
- **Responsive to ~380px** — body never scrolls horizontally; wide content scrolls in its own `overflow-x:auto` wrapper. **Visible focus rings** on every interactive element. Restrained overall: at most one signature texture (e.g. faint masked grid in the hero), no gratuitous animation.

## Naming: headings, labels, TOC

Headings are navigation labels, not headlines. Test: reading only the TOC should tell you what the document is and what each part does. Name the actual tools, files, metrics, and actions; no category nouns ("the stack", "overview") and no wordplay or metaphor — voice lives in prose and eyebrow labels, never headings.

- "Install the stack" → "Install Homebrew, Node, and cloudflared"
- "Risk, honestly assessed" → "Risk assessment"
- Card labels: the filename when the block is a file; otherwise the command/tool plus what it does. Warnings go in prose or a callout, not labels.
- TOC entries: ≤5 words, same meaning as the heading — compress by dropping words, never by substituting vaguer ones.

# Part 2 — Type playbooks

## A. Interactive code-block pages (runbooks, prompt libraries, command references)

For prompts, commands, snippets, or config the user will copy out and use. Layout by shape: sequential process → numbered phase rail (only when order genuinely matters); grouped collection → labeled section dividers; flat list → stacked cards. Cards: `--panel` bg, 1px `--line` border, header bar with accent dot + mono label + Copy (+ chevron); `<pre><code>` body on `--code-bg`.

Features 1–4 always; collapsing (5) when the page has many or long cards — don't bolt fold machinery onto a five-card page.

1. **Copy per card.** Reads live text via `txt()`, `navigator.clipboard` with `execCommand` textarea fallback, brief green "Copied" state.
2. **Editable blocks + live re-highlight.** Every `<code>`: `contenteditable`, `spellcheck=false`, autocorrect/autocapitalize off. Re-highlight on every `input` — never rely on static spans surviving edits. Rules: leading `N.` → amber; Stop/Wait lines → cyan; `#`/`//` comment lines → muted. Preserve the caret across re-render:

```js
function caretOffset(el){const s=window.getSelection();if(!s.rangeCount)return null;
  const r=s.getRangeAt(0);if(!el.contains(r.endContainer))return null;
  const p=r.cloneRange();p.selectNodeContents(el);
  p.setEnd(r.endContainer,r.endOffset);return p.toString().length;}
function setCaret(el,off){const rg=document.createRange(),s=window.getSelection();
  let n,rem=off;const w=document.createTreeWalker(el,NodeFilter.SHOW_TEXT);
  while((n=w.nextNode())){if(rem<=n.length){rg.setStart(n,rem);rg.collapse(true);
    s.removeAllRanges();s.addRange(rg);return;}rem-=n.length;}
  rg.selectNodeContents(el);rg.collapse(false);s.removeAllRanges();s.addRange(rg);}
// highlight(el): off=caretOffset(el); rebuild innerHTML from txt(el) line by line
// applying the rules above with esc() on every line; then if(off!==null)setCaret(el,off).
// Run once on load and on every input.
```

3. **Save / Save as.** Buttons in hero and footer, class-driven so both share one handler set and one `fileHandle`. First Save → `showSaveFilePicker` (suggestedName from an editable filename input, force `.html`); later Saves overwrite silently; "Save as…" re-picks. Where absent (Firefox/Safari/sandbox): relabel Save to "Download", hide Save as, blob-download. Serialize `'<!DOCTYPE html>\n'+document.documentElement.outerHTML` so edits are baked in. Swallow `AbortError`.
4. **localStorage autosave.** Namespaced key per artifact (`<kebab-name>-edits-v1`), store `{cN: txt(block)}` on input, restore before first highlight.
5. **Collapsible cards.** Whole card header toggles (except the Copy button). The chevron is a real `<button>` with `aria-expanded` — never nested inside another button. Collapse via `display:none` on the `<pre>`, no height animation; collapsed headers show a line count. "Collapse all" flips to "Expand all". Fold state in its own key (`<kebab-name>-folded-v1`); sync `aria-expanded` on init for cards shipped collapsed. Collapse hides content → every read must use `txt()`.

**Tell the user:** edits persist via Save (writes the file); localStorage autosave works only in a downloaded copy, not the sandbox preview.

## B. Reports and analyses

Lead with the answer: hero states the question and one-line conclusion; a summary block (3–6 bullets or stat chips) before any detail. TOC near-mandatory — reports get revisited for one section. Evidence under plain headings: tables in `overflow-x:auto` wrappers, excerpts as non-editable `<pre>`. Callouts for caveats (amber) and methodology asides (cyan) — never bury a limitation in prose only. Numbers: consistent precision, units, stated baselines ("+18% vs. June"), never bare deltas. Methodology/sources section at the bottom; the footer states the data's as-of date, not just the build date.

## C. Dashboards and status pages

Stat tiles first (mono value, muted label, unit, delta), detail below. Every metric carries an as-of timestamp — a static artifact must never imply it's live; if it gets regenerated, say so in the footer. Charts as inline SVG only (no libraries); label axes or don't ship the chart — in Claude Code, read the `dataviz` skill before writing chart code. Color encodes state sparingly and never alone (pair with symbol or word). Detail tables get sticky headers inside their scroll container.

## D. Guides and walkthroughs

Sequential rail — order matters by definition. Prerequisites block before step 1 (tools, versions, accounts, expected time). Each step ends with an expected-result line ("you should see …"); Stop/Wait callouts where proceeding blind is costly. Commands and file contents are playbook-A cards; explanation stays in prose between them. A short troubleshooting section beats a perfect happy path.

## E. Comparison and reference pages

Comparison: criteria as rows, options as columns, first column sticky when scrolling; end with a plain verdict ("Choose X when …") — a comparison without a recommendation is a data dump. Reference (many small entries): dense card grid; past ~20 entries add a client-side text filter matching `txt()` of label + body, with an "n of m shown" count. Mono for the things themselves (flags, keys, values); prose only for judgment.

## Final checks (any type)

- Network off — would anything break?
- Every in-page link is `data-goto`, none `href="#…"`.
- ~380px wide — no body horizontal scroll.
- Tab through — focus visible, custom controls Enter/Space-operable.
- Footer explains what this file is, without the conversation.
