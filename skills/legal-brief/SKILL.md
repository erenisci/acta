---
name: legal-brief
description: Consolidate the separate legal briefs into ONE document to hand to a lawyer — never legal advice. Trigger on /acta:legal-brief, "brief for the lawyer", "prepare for legal counsel".
---

# acta:legal-brief

The **lawyer handoff.** `acta:legal` keeps the legal groundwork as separate briefs (good — each area stays focused),
but you can't walk into a lawyer's office with seven files. This produces **one self-contained document** that has
everything counsel needs to advise you, in the order they'll want it.

> ⚠️ **NOT LEGAL ADVICE.** This is a *briefing you give to a qualified lawyer* so they can prepare the real,
> binding documents. It contains no enforceable legal text and makes you compliant of nothing by itself.

Shared: `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`. Reads `docs/legal/*`, `docs/product/*`, `docs/architecture/overview.md`, and
the registry (`.claude/acta.md`) for the project identity.

## Language
Write the brief in the project's documentation language (registry `language:`, default English); talk to the user in
the language they use. See `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`.

## Pre-condition
`docs/legal/` must exist. If not → run `/acta:legal` first (and `/acta:track` to catch recent changes).

## Output — one file: `docs/legal/lawyer-brief.md`
Regenerated in place each run (never appended). Self-contained, printable, in this order:

1. **Cover / identity** — project (and company/entity if known) name, contact, what the product does in 2–3 lines,
   stage, and the date. Pull the name from the registry/product docs; unknown → `TBD` for the user to fill.
2. **What we do with data** — a plain-language summary + a **data inventory** (what's collected, from whom — including
   third parties whose data may appear, e.g. in user-supplied content).
3. **Where data goes** — **sub-processors and cross-border transfers** (hosting, DB, LLM/API, analytics), pulled from
   `data-processing.md` — the map counsel needs for transfer questions.
4. **Which regimes apply** — the region-aware list from `overview.md` (KVKK / GDPR / CCPA / PIPL / APPI …) and why.
5. **Decisions for counsel** — the **consolidated question list**: every "decision you must make" and every
   **⚠️ needs lawyer re-review** item gathered from all the briefs, deduped, so nothing is missed in the meeting.
6. **Open gaps** — anything still `TBD` that the lawyer will ask about (retention period, entity, etc.).

## Inform the user (always)
End by telling the user, plainly: *this single file is what you take to the lawyer; print/export it; it is a
briefing, not legal advice, and the lawyer produces the binding documents.* Point to its path.

## Rules
- **Never write binding legal text, never give legal advice.** Consolidate the briefs + the decision list only.
- **Never fabricate** an identity, a fact, or a regime → `TBD` / ask. Deduplicate; don't invent items not in the briefs.
- Regenerate in place (single doc, no bloat). It is git-ignored with the rest of `docs/legal/`. Operate by `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`.
