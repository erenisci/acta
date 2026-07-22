---
name: business
description: Iteratively model pricing, unit economics (LTV/CAC/margin) and best/base/worst projections with real numbers → docs/business/. Not a one-shot generator. Trigger on /acta:business, "model pricing", "unit economics", "revenue projection".
---

# acta:business

The **business brain.** Not a one-shot generator — a **modeling partner you come back to.** Every time you rethink
pricing, cost, or growth, it reads the current numbers, **sanity-checks the change against unit economics and
best/base/worst scenarios**, and records the decision. So your thousandth pricing tweak is still grounded, not a guess.

Shared: `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`. Reads `docs/product/*` (PRD, target users), `docs/business/*`, **and the
cost-driving decisions** — `docs/operations/deployment.md`, `docs/architecture/overview.md` (Tech Stack / Key
Decisions), `docs/devops/cost.md` if present, and the LLM/API choices in `docs/llm/*` — so the infra you already
chose flows into the economics instead of a made-up number.

## Language
Generate content in the project's documentation language (registry `language:`, default English); talk to the user in the language they use. Money framework is **global/general** — not tied to any one market or currency.

## What it maintains — `docs/business/`
- `business-model.md` — how it makes money: model (subscription / usage / credits / one-time), the **value metric**, who pays, why.
- `pricing.md` — tiers / packages / price points, with the **value-based rationale** (a general structure, not a locale-specific table).
- `unit-economics.md` — LTV, CAC, gross margin, LTV:CAC, CAC-payback, and **per-unit cost → margin** for your core
  action. **Cost inputs come from the real infra decisions** (hosting, DB, LLM/API per the deployment/architecture
  docs) as fixed vs. per-unit lines — not invented; still unknown → ask / `TBD`.
- `projections.md` — revenue/cost forecast under **best / base / worst-case** assumptions (each assumption named and testable).
- `go-to-market.md` — channels, positioning, launch plan.
- `competitors.md` — competitor scan (offer, price, gap) — research with the user, record findings.

## Flow (intent-driven, iterative)
1. Pick the intent — arg or ask: `establish` (first time) · `pricing` · `scenarios` · `unit-economics` · `competitors` · `go-to-market`.
2. **Read the current state** (`docs/business/*` + product docs). Never start from scratch if docs exist.
3. **Model it *with* the user, not for them.** For a pricing change: compute the impact — does the new price keep
   **gross margin positive**? what happens to **LTV:CAC** and **CAC-payback**? Run it through **best/base/worst**
   scenarios. Surface the numbers; let the user decide. Use the user's real costs/assumptions — **never invent
   market data or a margin**; unknown input → ask, or leave `TBD`.
4. **Persist**: update the relevant `docs/business/*` in place, and record a significant pricing/model change as a
   short decision entry (an ADR under `docs/architecture/adr/` if the project has ADRs, else a dated line in `pricing.md`).
5. **Wire the brain**: refresh the **`{{BUSINESS_LINKS}}`** ("Business & pricing") block in `CLAUDE.md` (marker-scoped) → `business-model.md`, `pricing.md`, `unit-economics.md` — and the docs index.

## Rules
- **Iterative, not one-shot.** Re-running is normal; it reasons from the current numbers and keeps them honest.
- **Never fabricate numbers.** Compute from the user's inputs; unknown → ask / `TBD`. Don't invent CAC, market size, or competitor prices — research them *with* the user.
- **Global framework.** Keep pricing/economics general; a specific market's tax/currency belongs to the user's own figures, not baked in.
- Anti-bloat: in-place, consolidated. Content in the project's documentation language. Operate by `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`.
- Sensitive by default — `docs/business/` is git-ignored by `acta:build` (see its gitignore block); it's your private strategy.
