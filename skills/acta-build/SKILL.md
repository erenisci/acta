---
name: acta-build
description: Step 2 of the acta solo-engineering doc pipeline. Reads a filled <PROJECT>_BRIEF.md, proposes values for "?" fields, asks only about genuine blanks (never about "-" fields), then generates the selected disciplines' documents under docs/ and writes the project "brain" — a CLAUDE.md Context Index + .claude/acta.md registry + docs/README index. Trigger on /acta-build, "build the docs", "generate project docs".
---

# acta-build

Turns a filled brief into a right-sized documentation set **and a brain** that later Claude sessions use.
Shared resources at `~/.claude/acta/`: `doc-catalog.md` (the contract), `disciplines.md`, `templates/`.

## Language
All generated content and your messages are **English**.

## Pre-condition

Find `<PROJECT>_BRIEF.md` at the project root (any `*_BRIEF.md`). If none exists:
```
No project brief found. Run /acta-brief first — it creates <PROJECT>_BRIEF.md for you to fill in.
(Existing codebase with no docs? /acta-adopt reverse-engineers docs from the code instead.)
```
Do not proceed without a brief. (If the user insists on going without one, run the questions in step 2/3
conversationally to reconstruct the brief's answers first.)

## Flow

1. **Read & classify the brief.** For every field, tag it:
   - **filled** — plain text → use as-is.
   - **`?`** — the user wants a suggestion.
   - **`-`** — skip: unknown / not applicable. **Never ask about these.** They become `TBD` or are omitted.
   - **blank** — a real gap.

2. **Resolve `?` fields.** For each, draft a concrete suggestion grounded in the other answers (project type,
   users, stack). Present them for confirmation — batch with `AskUserQuestion` (≤4 per call), recommended value
   first. The user accepts / edits / drops each. Nothing is fabricated silently: a `?` becomes a real value only
   after the user confirms; otherwise it stays `TBD`.

3. **Fill blanks.** Ask about blank fields with `AskUserQuestion`, ≤4 per call, grouped by topic, most blocking
   first. Keep it short — don't interrogate. Anything still unresolved → `TBD` (recorded in the doc's Open Questions).

4. **Choose disciplines & depth.**
   - If the brief's "Which disciplines" section names them, use it. If it's `?` or blank, **recommend** based on
     the project profile and confirm via a multi-select (options: product, project, code, quality, ops, ai;
     depth: core / standard / full). Pre-check the recommended set. Knowledge docs (readme, brain, registry,
     docs-index, glossary…) are always included and not shown as a choice.
   - Default recommendation for a typical solo app: `product, project, code, ops` at `standard`; add `quality`
     if tests matter, `ai` if AI-assisted development is in play (it usually is here).

5. **Resolve the doc set.** From `doc-catalog.md`, include a doc when **its tier ⊆ chosen depth**
   (`core` → core only; `standard` → core+standard; `full` → all) AND its discipline was selected (or it's a
   knowledge/auto doc at a matching tier). Build the final id → path → template list. **Paths and filenames come straight from the
   catalog exactly as listed — do not invent or re-case them.**

6. **Generate each doc.** Render with its dedicated `.tmpl` if the catalog names one, else the universal
   `templates/_doc-format.md` using the catalog's section list. Fill from brief/answers/detected code; unknown →
   `TBD`. Keep sections tight. Create parent folders as needed (folders lowercase; filenames exactly as the catalog lists them — root meta UPPERCASE, docs/ lowercase-kebab).
   **Overwrite guard:** if a target doc already exists, offer merge / overwrite / skip (default skip) — never
   clobber silently.
   - `adr`: create `docs/architecture/adr/` with `README.md` (index) and seed `0001-initial-architecture.md`
     from `ADR.md.tmpl` capturing the initial stack/architecture decision (TBD where unknown).
   - `readme`: create root `README.md` from `README.md.tmpl` **only if absent**; never overwrite an existing README.
   - `changelog`: create root `CHANGELOG.md` from `CHANGELOG.md.tmpl` if absent.

7. **Write the brain (the whole point).**
   - **CLAUDE.md** — inject the `templates/CLAUDE-index-block.md.tmpl` block between
     `<!-- acta:index:start -->` / `<!-- acta:index:end -->`. Create CLAUDE.md with a title if missing; replace
     the block if present (idempotent, never duplicated). Fill each discipline bullet with links to that
     discipline's key generated docs; drop disciplines with no docs.
   - **.claude/acta.md** — render `templates/registry.md.tmpl`: profile (name/type/stack/stage/brief/depth),
     selected disciplines, and a row per generated doc (status `active` or `tbd`).
   - **docs/README.md** — render `templates/docs-README.md.tmpl`, listing every generated doc grouped by discipline.

8. **Finish.**
   - Ask what to do with the brief: **archive** (move to `docs/_brief-archive/<PROJECT>_BRIEF.md`) or **delete** or **keep**. Default archive.
   - Print a short summary: disciplines + depth, count of docs created, how many fields landed as `TBD`, and:
     `Next: build features, then /acta-track to keep these docs current.`

## Rules

- Never fabricate. Unknown → `TBD`; surface `TBD` count so the user can revisit.
- Never overwrite an existing doc/README/CLAUDE content without consent; the brain block is marker-scoped only.
- Idempotent: re-running regenerates the brain/registry/index in place and skips existing docs by default.
- Anti-bloat: generate concise docs; don't pad. Ongoing growth is `acta-track`'s job and follows growth policies.
- Link hygiene: cross-link only to docs generated in this run. Never emit a link — or a `TBD (tier)` placeholder — to a doc that was not generated; omit out-of-scope references.
- English only. Solo right-sizing: render `(solo-light)` docs in their lightweight form.
