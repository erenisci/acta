---
name: acta-audit
description: The consistency / drift checker of the acta pipeline. Read-only by default — it verifies a project's engineering memory is still trustworthy: doc↔code drift, broken links, stale TBDs, brain/index/registry consistency, filename conventions, and doc bloat, then reports findings ranked by severity. Pass --fix to apply only safe mechanical fixes (regenerate brain/index/registry, drop broken links); it never fabricates content. Trigger on /acta-audit, "audit the docs", "check doc drift", "verify the docs".
---

# acta-audit

The **trust check.** Acta's whole value is a trustworthy engineering memory — this verifies the docs haven't drifted
from reality. **Read-only by default:** it reports; it fixes only mechanical things when asked (`--fix`), and it
**never fabricates content or guesses**.

Shared resources at `~/.claude/acta/`: `doc-catalog.md` (the contract), `disciplines.md`, `project-types.md`,
`principles.md`.

## Language
English only.

## Pre-condition

Read `.claude/acta.md` (registry) and `~/.claude/acta/doc-catalog.md`. If there is no registry, this project isn't
forged yet → suggest `/acta-build` (greenfield) or `/acta-adopt` (existing code). Don't guess a doc set without them.

## Checks

Run these read-only checks and collect findings. Rank each **🔴 broken · 🟡 drift/stale · 🔵 hygiene**.

1. **Brain & index integrity** — `CLAUDE.md` has the `<!-- acta:index:start/end -->` block and its links resolve;
   `docs/README.md` lists exactly the docs on disk (no missing, no orphan); registry rows match the filesystem.
2. **Broken links** — every relative link inside `docs/**` (and the brain) points to an existing file.
3. **Doc ↔ code drift** — compare docs against the code and flag mismatches:
   - stack in `arch-overview` / registry vs `package.json` / `pyproject.toml` / `go.mod` / etc.
   - endpoints in `api.md` vs routes; env vars in `env-vars.md` vs `.env(.example)`; `project-structure` tree vs the
     actual top-level folders; tables in `database-design` vs schema/migrations.
   - "doc says X, code says Y" → report both sides.
4. **Stale / empty** — docs still mostly `TBD`; `updated:` far behind recent code changes; scaffolds never filled.
5. **Contradictions** — best-effort scan for conflicting statements across docs (e.g. PRD "no backend" vs
   architecture "REST API"). Flag them; **never resolve by guessing.**
6. **Conventions** — filename casing (root meta UPPERCASE, `docs/**` lowercase kebab-case); docs living outside the
   catalog's paths; disciplines/packs in the registry vs what's actually on disk.
7. **Anti-bloat** — `in-place` docs that have grown append-only (e.g. `PROGRESS.md` accumulating dated log lines
   instead of a snapshot); oversized docs that should be consolidated per their growth policy.

## Output

Print a concise report — **do not create a bloated audit file**:

```
Acta audit — <project>
🔴 Broken (N)      : <one line each>
🟡 Drift/stale (N) : <one line each>
🔵 Hygiene (N)     : <one line each>
Clean              : <areas with no findings>
→ Fix: run /acta-track to re-sync current-state docs; <specific doc> needs <the manual bit only a human can supply>.
```

If everything passes, say so plainly. **By default the audit writes nothing** — the report is printed; no file is
created and no file grows.

## Not losing findings (opt-in, never bloats)

Because the report is ephemeral, offer two ways to keep the findings — the user chooses; **nothing is written without
consent:**

1. **Just re-run `/acta-audit`** next session — it's cheap and reflects the *current* reality, so a real issue is never
   missed (nothing to forget). This is the default.
2. **Record open items into the living memory** (only if the user wants persistence): one concise line per unresolved
   finding into an **existing** doc — never a separate audit file:
   - blocking / do-next → `docs/progress.md` **Blocked** / **Next Up**
   - deferred quality or debt → `docs/project/tech-debt.md` (`TD-N`)
   - a doc's own unknown → that doc's **Open Questions**

   These are **bounded, self-cleaning** docs (a snapshot / an open-debt list) linked from the `CLAUDE.md` brain:
   `acta-track` removes each item once it's fixed, so they track the *current* open set and **shrink as you resolve
   them — never grow without bound.** Anti-bloat: one line per item, dedupe, no audit files.

## Fixing — only with `--fix`, only the safe mechanical set

- Regenerate the `CLAUDE.md` brain block, `docs/README.md` index, and `.claude/acta.md` registry from the current
  filesystem (idempotent, marker-scoped).
- Remove or correct broken internal links.
- Refresh `updated:` dates only on docs you actually changed.
- **NEVER** fabricate content, resolve a contradiction, or fill a `TBD` — those are always reported for the human or
  for `/acta-track`, never invented.

## Rules

- Read-only by default; `--fix` performs only the mechanical set above.
- Never fabricate; unknown / contradiction / gap → **report**, don't invent.
- Idempotent. English only. Operate by `~/.claude/acta/principles.md`.
