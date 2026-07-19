# Acta — shared resources

This folder is **not a skill** (no `SKILL.md`, so it is not a slash command). It is the shared
single-source-of-truth used by the `acta-*` skills so their output stays consistent.

## The Acta family (solo software-engineering doc pipeline)

A pipeline that lets a **single developer, with no team**, apply end-to-end software-engineering
methodology to a project — and, crucially, wires every produced document into a **brain**
(a `CLAUDE.md` "Context Index") so Claude reads the right doc in later sessions.

| Skill      | Slash command | When                            | Job                                                                                  |
| ---------- | ------------- | ------------------------------- | ------------------------------------------------------------------------------------ |
| acta-init | `/acta-init` | project start                   | Create `<PROJECT>_BRIEF.md` for the human to fill (with a sign language).            |
| acta-build | `/acta-build` | after brief filled              | Read brief, ask only real gaps, suggest for `?` fields, generate docs + brain.       |
| acta-track | `/acta-track` | after finishing a chunk of work | Update all relevant docs to the current state — **without bloating them**.           |
| acta-adopt | `/acta-adopt` | existing codebase, missing docs | Generate only the **missing** docs from the code; **never overwrite** existing docs. |
| acta-audit | `/acta-audit` | anytime | **Verify** the memory: doc↔code drift, broken links, stale TBDs, brain/index consistency. Read-only; reports findings. |
| acta-design | `/acta-design` | brand / design | Establish `docs/design/` (brand, design-system, messaging) and **generate real design** (web / logo / deck / ads). |
| acta-design-prompt | `/acta-design-prompt` | need a Claude Design prompt | Scope-locked, on-brand **Claude Design prompts + the real copy**, straight from the design docs. |
| acta-design-track | `/acta-design-track` | design changed in code | Sync `docs/design/` to the code's real styling, in place (design's `acta-track`). |
| acta-business | `/acta-business` | pricing / money | Iterative modeling: pricing, unit economics, best/base/worst projections in `docs/business/`. |
| acta-legal | `/acta-legal` | before shipping | Region-aware legal briefs (KVKK/GDPR/CCPA/…) — warns you, briefs a lawyer; never binding text. |
| acta-legal-track | `/acta-legal-track` | product change | Flags when a change (cookies, new data/market/vendor) needs a lawyer re-review; updates the briefs. |
| acta-legal-brief | `/acta-legal-brief` | before meeting a lawyer | Consolidate the separate legal briefs into ONE hand-to-your-lawyer document; never legal advice. |

## Brief sign language (used by acta-init / acta-build)

In any brief field the human may put a single symbol instead of an answer:

- **`?`** → _suggest one for me_ (acta-build proposes a value, the human confirms).
- **`-`** → _skip_ (unknown / not applicable; acta-build won't ask).
- Blank field → a real gap; acta-build asks about it. Plain text → used as-is.

## Files here

- `disciplines.md` — the six disciplines → which documents belong to each, and the solo tiers (Core / Standard / Full).
- `doc-catalog.md` — master list: every document → id, path, discipline, tier, sections, growth policy. **The contract every skill reads.**
- `project-types.md` — project-type detection profiles → core disciplines + the matching domain pack.
- `principles.md` — Acta's operating principles (senior-engineer role, right-sizing, decision-justification) injected into each project's brain.
- `brief-template.md` — the `<PROJECT>_BRIEF.md` template, including the sign language explanation.
- `templates/` — format-critical templates (`_doc-format.md` universal format, plus ADR / CHANGELOG / PRD / RFC / brain block / registry / docs-index).

## Invariants (all skills obey)

1. **Never fabricate.** Unknown value → `TBD`. Never invent facts, versions, or decisions.
2. **Never overwrite without consent.** Existing doc → offer merge / overwrite / skip (adopt: always skip + report).
3. **Idempotent.** `CLAUDE.md` brain block, registry, and `docs/README.md` are marker-delimited or regenerated — re-running never duplicates.
4. **Anti-bloat.** Current-state docs (PROGRESS, ROADMAP, PRD…) are consolidated in place. Only log-type docs (CHANGELOG, decision logs) get structured appends. Docs must not grow without bound.
5. **Content language.** Generated docs/briefs are written in the project's chosen **content language** (stored in the registry `language:`, default English); talk to the user in the language they use. `SKILL.md`, slash-command triggers, `acta:` markers, and file/folder paths stay English regardless.
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
- Skills: `~/.claude/skills/acta-init`, `acta-build`, `acta-track`, `acta-adopt`, `acta-audit`, `acta-design`, `acta-design-prompt`, `acta-design-track`, `acta-business`, `acta-legal`, `acta-legal-track`, `acta-legal-brief`
- Per-project state written by the skills: `<project>/.claude/acta.md` (registry) + `<project>/CLAUDE.md` (brain block).
