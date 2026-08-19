# Artifact types

Default spines, drawn from the artifacts already built. A spine is a starting
order, not a form to fill in — drop sections the material doesn't have, and
add ones it does. What's constant is the ending: every type closes by naming
what's still undecided.

Nothing here is exhaustive. A document that fits none of these is fine; give
it a spine that follows its own argument and keep the conventions.

---

## Options review

*Several ways to do a thing; the reader has to pick one.* The most common
type, and the one that most wants a stated position.

1. **What this is** — one panel, read-this-first. Status, and what's being
   decided.
2. **What holds regardless** — the two or three facts that survive whichever
   option wins. Put them first; they're the cheapest thing the reader can
   take away if they stop reading.
3. **The constraint** — the thing every option bends around.
4. **The options**, one panel each, uniform shape: how it works · what it
   costs · what it needs · verdict line.
5. **The decision rule** — how to choose between them concretely, not "it
   depends".
6. **Cost** — time, money, tokens, risk. Real numbers or say you're guessing.
7. **Where the analysis disagreed with itself** — the honest section. If
   two reasonable readings point different ways, say so here rather than
   flattening it.
8. **The recommendation** — one option, named, with the smallest first step.
9. **Open decisions.**

## System survey

*How something works today, and where it could go.* Written for a reader who
will change the system and needs the current shape first.

1. **How it works** — the mechanism, briefly. Assume the reader can read
   code; don't narrate it.
2. **Where it's supported today** — a table. Surface, what works there,
   what doesn't.
3. **Gaps** — where the model leaks, honestly, including the ones that
   aren't worth fixing.
4. **Where it could go** — numbered idea cards, each a pitch plus a
   sentence of detail. Sized roughly, not specified.
5. **Enhancements to the system itself** — changes to the mechanism rather
   than its reach. Keep separate from the above; they're a different kind
   of bet.
6. **Open decisions.**

## Implementation plan

*A thing that's been decided; this is how it gets built.* The type most
likely to go stale — date it prominently and say what's shipped.

1. **The shape** — one paragraph and, if it earns it, a flow diagram.
2. **How it behaves** — walk the main path end to end.
3. **The hard parts** — the constraints that dictate the design. If there
   are security or data-loss properties, they go here, with the reason each
   one is the way it is, and the failure mode if it's changed. The reader
   most likely to break a load-bearing choice is a future agent who didn't
   know it was load-bearing.
4. **Data model / interface** — schema, routes, file layout. Copy blocks
   earn their place here.
5. **Build order** — numbered phases, each independently shippable.
6. **Loose ends** — known-incomplete, deferred, and explicitly out of scope.

## Postmortem

*Something broke or went sideways.* Blameless, specific, and useful to
someone who wasn't there.

1. **What happened** — one paragraph, plain.
2. **Timeline** — a table. Time, event, who/what noticed.
3. **Impact** — what was actually affected, and for how long.
4. **Root cause** — the mechanism, not the person. Include the thing that
   made it hard to see.
5. **What we changed** — shipped fixes, linked.
6. **What we're not changing, and why** — the section that keeps a
   postmortem honest.
7. **Open decisions.**

## Reference

*A collection meant to be used, not read* — prompts, commands, queries,
snippets. The one type where interactivity carries real weight: every entry
gets a copy button, and grouping beats sequence.

1. **What's in here and how to use it** — short.
2. **Groups**, with a mono eyebrow each, entries as code blocks with copy.
3. **Anything with a gotcha** gets a callout under the block, not a comment
   inside it — comments get copied along with the snippet.

Skip the numbered rail. These are looked up, not worked through, so a TOC
that jumps to a group beats a sequence that implies order.
