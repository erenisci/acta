# Acta — shared resources

This folder is **not a skill** (no `SKILL.md`, so it is not a slash command). It is the shared
single-source-of-truth used by the four `acta-*` skills so their output stays consistent.

## The Acta family (solo software-engineering doc pipeline)

A pipeline that lets a **single developer, with no team**, apply end-to-end software-engineering
methodology to a project — and, crucially, wires every produced document into a **brain**
(a `CLAUDE.md` "Context Index") so Claude reads the right doc in later sessions.

| Skill      | Slash command | When                            | Job                                                                                  |
| ---------- | ------------- | ------------------------------- | ------------------------------------------------------------------------------------ |
| acta-brief | `/acta-brief` | project start                   | Create `<PROJECT>_BRIEF.md` for the human to fill (with a sign language).            |
| acta-build | `/acta-build` | after brief filled              | Read brief, ask only real gaps, suggest for `?` fields, generate docs + brain.       |
| acta-track | `/acta-track` | after finishing a chunk of work | Update all relevant docs to the current state — **without bloating them**.           |
| acta-adopt | `/acta-adopt` | existing codebase, missing docs | Generate only the **missing** docs from the code; **never overwrite** existing docs. |

## Brief sign language (used by acta-brief / acta-build)

In any brief field the human may put a single symbol instead of an answer:

- **`?`** → _suggest one for me_ (acta-build proposes a value, the human confirms).
- **`-`** → _skip_ (unknown / not applicable; acta-build won't ask).
- Blank field → a real gap; acta-build asks about it. Plain text → used as-is.

## Files here

- `disciplines.md` — the six disciplines → which documents belong to each, and the solo tiers (Core / Standard / Full).
- `doc-catalog.md` — master list: every document → id, path, discipline, tier, sections, growth policy. **The contract every skill reads.**
- `brief-template.md` — the `<PROJECT>_BRIEF.md` template, including the sign language explanation.
- `templates/` — format-critical templates (`_doc-format.md` universal format, plus ADR / CHANGELOG / PRD / RFC / brain block / registry / docs-index).

## Invariants (all four skills obey)

1. **Never fabricate.** Unknown value → `TBD`. Never invent facts, versions, or decisions.
2. **Never overwrite without consent.** Existing doc → offer merge / overwrite / skip (adopt: always skip + report).
3. **Idempotent.** `CLAUDE.md` brain block, registry, and `docs/README.md` are marker-delimited or regenerated — re-running never duplicates.
4. **Anti-bloat.** Current-state docs (PROGRESS, ROADMAP, PRD…) are consolidated in place. Only log-type docs (CHANGELOG, decision logs) get structured appends. Docs must not grow without bound.
5. **English only** for all generated content and skill dialogue.
6. **Solo right-sizing.** Team-only artifacts (Contribution guide, agent roles, heavy RFC/incident process) are kept light or marked optional.

## Filename convention (common open-source standard)

- **Root meta-files UPPERCASE**: `README.md`, `CHANGELOG.md`, `CONTRIBUTING.md`, `CLAUDE.md`, `LICENSE`.
- **`README.md` folder-indexes stay UPPERCASE**: `docs/README.md`, `docs/architecture/adr/README.md`.
- **Everything else under `docs/` is lowercase kebab-case**: `docs/product/prd.md`, `docs/architecture/overview.md`,
  `docs/architecture/adr/0001-initial-architecture.md`. Folders always lowercase.
- `.claude/acta.md` (registry) is internal state — lowercase by design. The brief file `<PROJECT>_BRIEF.md` is a
  transient root working file (uppercase).

## Paths

- Shared resources (this folder): `~/.claude/acta/`
- Skills: `~/.claude/skills/acta-brief`, `acta-build`, `acta-track`, `acta-adopt`
- Per-project state written by the skills: `<project>/.claude/acta.md` (registry) + `<project>/CLAUDE.md` (brain block).
