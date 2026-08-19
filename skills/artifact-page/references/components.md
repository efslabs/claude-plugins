# Component catalog

The vocabulary the existing artifacts converged on, written down so each new
one doesn't reinvent it. Take what the document needs and leave the rest —
this is a parts bin, not a template. Everything here assumes `base.css`.

Naming stays boring and short (`.panel`, `.dec`, `.tier`) because these are
one-file documents; there's no cascade to protect.

---

## Hero

Opens every artifact. The chiprow is where provenance goes — see
`SKILL.md` → Provenance.

```html
<header class="hero">
  <div class="eyebrow">Exploration · nothing built yet</div>
  <h1>The night shift <span class="lo">— unattended overnight work</span></h1>
  <p class="lede">One or two sentences: what this is, and what it's for.</p>
  <div class="chiprow">
    <span class="mchip">2026-08-19</span>
    <span class="mchip">proposal</span>
    <span class="mchip">4 open decisions</span>
  </div>
</header>
```

## Section divider

A mono eyebrow above the heading, for sections that need a label as well as
a title. Plain `<h2>` is fine when it doesn't.

```css
.sechead{margin:38px 0 12px}
.sechead .lbl{font-family:var(--mono);font-size:10.5px;letter-spacing:.14em;
  text-transform:uppercase;color:var(--muted-2);margin-bottom:6px}
.sechead h2{margin:0}
```

```html
<div class="sechead">
  <div class="lbl">02 · Constraints</div>
  <h2>What everything bends around</h2>
</div>
```

## Panel

The workhorse container: a titled box for one idea. Header bar carries an
amber dot and a mono label.

```css
.panel{background:var(--panel);border:1px solid var(--line);border-radius:8px;
  margin:14px 0;overflow:hidden}
.panel>.hd{background:var(--panel-2);border-bottom:1px solid var(--line);
  padding:8px 12px;display:flex;align-items:center;gap:8px}
.panel>.hd::before{content:"";width:6px;height:6px;border-radius:50%;
  background:var(--amber);flex:none}
.panel>.hd .lbl{font-family:var(--mono);font-size:11px;letter-spacing:.06em;
  color:var(--heading);font-weight:600}
.panel>.body{padding:12px}
.panel>.body>:last-child{margin-bottom:0}
```

```html
<div class="panel">
  <div class="hd"><span class="lbl">Serial shipper</span></div>
  <div class="body"><p>One change at a time, merged on green.</p></div>
</div>
```

## Callout

An aside that shouldn't read as body text. Amber by default; `.ok` and
`.danger` for a verdict-flavoured one. Needs the optional `--amberbg` /
`--amberline` / `--okbg` / `--dangerbg` tokens uncommented in `base.css`.

```css
.note{border-left:3px solid var(--amber);background:var(--amberbg);
  padding:10px 12px;margin:14px 0;font-size:13px}
.note.ok{border-color:var(--ok);background:var(--okbg)}
.note.danger{border-color:var(--danger);background:var(--dangerbg)}
.note>:last-child{margin-bottom:0}
.note .t{font-family:var(--mono);font-size:10.5px;letter-spacing:.1em;
  text-transform:uppercase;color:var(--muted);display:block;margin-bottom:4px}
```

```html
<div class="note">
  <span class="t">Worth knowing</span>
  <p>Auto-merge only reaches where the browser harness reaches.</p>
</div>
```

## Verdict line

A one-line recommendation attached to an option. Reads as a judgement, not
prose — use it wherever the document takes a position.

```css
.rec{display:flex;gap:9px;align-items:baseline;margin:10px 0 0;
  padding-top:9px;border-top:1px dashed var(--line)}
.rec .k{font-family:var(--mono);font-size:10.5px;letter-spacing:.1em;
  text-transform:uppercase;color:var(--muted-2);flex:none}
.rec .v{font-size:13px}
.rec.yes .v{color:var(--ok)} .rec.no .v{color:var(--danger)}
```

```html
<div class="rec yes"><span class="k">Verdict</span>
  <span class="v">Start here — smallest thing that proves the loop.</span></div>
```

## Decision card

For the closing "open decisions" section: the question, what it hinges on,
and the options. Leave the answer blank — that's the point.

```css
.dec{border:1px solid var(--line);border-radius:8px;padding:12px;margin:12px 0}
.dec .q{font-weight:700;color:var(--heading);margin-bottom:5px}
.dec .why{color:var(--muted);font-size:13px;margin-bottom:8px}
.dec ul{margin:0;padding-left:18px;font-size:13px}
.dec li+li{margin-top:3px}
```

```html
<div class="dec">
  <div class="q">Should night one merge anything?</div>
  <div class="why">Decides whether the first run needs a supervisor awake.</div>
  <ul><li>Propose-only — safe, slower</li><li>Merge on green — faster, riskier</li></ul>
</div>
```

## Two-column

For before/after, option-vs-option, pro/con. Collapses on mobile.

```css
.grid2{display:grid;grid-template-columns:1fr 1fr;gap:12px;margin:14px 0}
@media (max-width:560px){.grid2{grid-template-columns:1fr}}
```

## Comparison table

Always wrap a table — a document table will outgrow a phone, and an
unwrapped one makes the whole page pan sideways.

```css
.tscroll{overflow-x:auto;margin:14px 0;-webkit-overflow-scrolling:touch}
table{border-collapse:collapse;width:100%;font-size:13px;min-width:520px}
th,td{text-align:left;padding:7px 10px;border-bottom:1px solid var(--line-soft);
  vertical-align:top}
th{font-family:var(--mono);font-size:10.5px;letter-spacing:.08em;
  text-transform:uppercase;color:var(--muted);border-bottom:1px solid var(--line)}
tbody tr:last-child td{border-bottom:0}
```

```html
<div class="tscroll"><table>…</table></div>
```

## Idea card

For enumerated proposals — a list of things that could be built. The head is
the pitch, the body is the detail.

```css
.idea{border:1px solid var(--line);border-radius:8px;padding:11px 12px;margin:10px 0}
.idea .head{display:flex;gap:9px;align-items:baseline}
.idea .n{font-family:var(--mono);font-size:11px;color:var(--amber);flex:none}
.idea .t{font-weight:700;color:var(--heading)}
.idea p{font-size:13px;color:var(--muted);margin:5px 0 0}
```

```html
<div class="idea">
  <div class="head"><span class="n">04</span><span class="t">Pill links on tags</span></div>
  <p>Clicking a tag filters the page instead of navigating away.</p>
</div>
```

## Step flow

Ordered phases, when order genuinely matters. Don't number things that
aren't sequential.

```css
.step{position:relative;padding:0 0 18px 30px;border-left:1px solid var(--line)}
.step:last-child{border-left-color:transparent;padding-bottom:0}
.step::before{content:attr(data-n);position:absolute;left:-11px;top:0;
  width:21px;height:21px;border-radius:50%;background:var(--panel);
  border:1px solid var(--line);font-family:var(--mono);font-size:10px;
  color:var(--amber);display:grid;place-items:center}
.step .t{font-weight:700;color:var(--heading);margin-bottom:3px}
```

```html
<div class="step" data-n="1"><div class="t">Discover</div><p>…</p></div>
```

## Tier ladder

Escalating levels — autonomy tiers, risk bands, rollout stages. The accent
bar is what makes the ladder read as a ladder.

```css
.tier{border:1px solid var(--line);border-left:4px solid var(--ok);
  border-radius:6px;padding:10px 12px;margin:9px 0}
.tier.t2{border-left-color:var(--amber)}
.tier.t3{border-left-color:var(--danger)}
.tier .t{font-family:var(--mono);font-size:11px;letter-spacing:.06em;
  color:var(--heading);font-weight:600;margin-bottom:3px}
.tier p{font-size:13px;margin:0}
```

## Table of contents

Add one past ~8 sections. Every section needs an `id`; keep ids short and
stable so links into the artifact survive edits.

```css
.toc{border:1px solid var(--line);border-radius:8px;padding:10px 12px;margin:18px 0}
.toc a{display:flex;gap:10px;align-items:baseline;padding:4px 0;
  color:var(--text);text-decoration:none;font-size:13px}
.toc a:hover{color:var(--accent)}
.toc i{font-family:var(--mono);font-size:10.5px;color:var(--muted-2);
  font-style:normal;flex:none;min-width:16px}
```

```html
<nav class="toc" aria-label="Contents">
  <a href="#findings"><i>1</i>Three things worth knowing</a>
</nav>
```

## Code block with copy

The one piece of interactivity worth shipping — `clipboard-write` is
delegated into the artifact frame specifically so this works. Add it only
where there's something worth copying; a document with no snippets needs no
JavaScript at all.

```css
.code{border:1px solid var(--line);border-radius:8px;overflow:hidden;margin:14px 0}
.codebar{background:var(--panel-2);border-bottom:1px solid var(--line);
  padding:6px 10px;display:flex;align-items:center;gap:8px}
.codebar .lbl{font-family:var(--mono);font-size:10.5px;color:var(--muted);flex:1}
.copy{border:1px solid var(--line);background:transparent;cursor:pointer;
  font-family:var(--mono);font-size:10.5px;color:var(--muted);padding:3px 9px;
  border-radius:4px}
.copy:hover{color:var(--accent);border-color:var(--accent)}
.copy.done{color:var(--ok);border-color:var(--ok)}
.code pre{margin:0;padding:11px;background:var(--code-bg);overflow-x:auto;
  font-family:var(--mono);font-size:12px;line-height:1.5}
```

```html
<div class="code">
  <div class="codebar"><span class="lbl">migrations/0055_artifact_x.sql</span>
    <button class="copy" type="button">Copy</button></div>
  <pre><code>INSERT OR IGNORE INTO artifacts …</code></pre>
</div>
```

```js
document.querySelectorAll('.copy').forEach(function (btn) {
  btn.addEventListener('click', function () {
    var pre = btn.closest('.code').querySelector('pre');
    navigator.clipboard.writeText(pre.innerText).then(function () {
      btn.textContent = 'Copied';
      btn.classList.add('done');
      setTimeout(function () {
        btn.textContent = 'Copy';
        btn.classList.remove('done');
      }, 1600);
    });
  });
});
```

## Footer

```html
<div class="foot"><span>Built 2026-08-19</span><span>artifact · night-shift</span></div>
```
