---
name: adopt
description: Existing codebase with few docs — reverse-engineer only the missing ones from the code; never overwrite. Trigger on /acta:adopt, "document this codebase", "backfill docs".
---

# acta:adopt

The **backfill**. Point it at a real project that's missing docs and it reverse-engineers a right-sized doc set
from the code, then builds the brain — **without touching anything that already exists**.

Shared: `${CLAUDE_PLUGIN_ROOT}/acta/` (`doc-catalog.md`, `disciplines.md`, `templates/`). Same catalog/templates as
`acta:build`, so adopted docs are consistent with built ones. The difference: **source is the code, and the
overwrite policy is always SKIP.**

## Language
Generate content in the project's documentation language (registry `language:`, default English); talk to the user in the language they use. See `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`.

## Flow

1. **Scan the codebase (read-only).** Detect:
   - Stack: `package.json`, `pyproject.toml`/`requirements.txt`, `go.mod`, `Cargo.toml`, `pom.xml`, etc.
   - Structure: top-level folders, entry points, module boundaries.
   - Routes/endpoints: `app/`, `pages/`, `routes/`, controllers, OpenAPI files.
   - Data: schemas, migrations, ORM models → for `db-design`/`erd`.
   - Ops signals: Dockerfile, CI config (`.github/workflows`, etc.), `.env.example` → `env-vars`/`ci-cd`/`deployment`.
     **Read only the committed `.env.example` / `.env.sample` template — never a real `.env`/`.env.local` (secrets); record names, not values.**
   - Tests: presence/kind → `testing-strategy`.
   - Domain signals → project **type + pack** via `${CLAUDE_PLUGIN_ROOT}/acta/project-types.md`: PyTorch/scikit/dataset → `ml`;
     langchain/embeddings/vector store → `llm`; Solidity/Foundry/Hardhat → `web3`; Godot/Unity/Unreal → `game`;
     firmware/Arduino/ESP32/RTOS → `hardware`; Airflow/dbt/Spark → `data`; scanner/detection/exploit tooling → `security`;
     Terraform/k8s/Ansible → `devops`; ROS/actuator/SLAM → `robotics`; ARKit/Unity XR → `xr`; Stripe/payments/ledger → `fintech`;
     simulation/HPC/numerical → `scientific`; ffmpeg/HLS/transcoding → `media`; GIS/GeoJSON/mapping → `geospatial`.
   Report the detected profile (stack + type) in 3–5 lines before doing anything else.

2. **Inventory existing docs.** Check the filesystem and any `.claude/acta.md` registry for docs that already
   exist (README, `docs/**`, CLAUDE.md, CHANGELOG, ADRs). Build two lists: **present** vs **missing**.

3. **Recommend & confirm the doc set.** From the detected profile, recommend core disciplines/depth (e.g. API routes
   → `api`; migrations → `db-design`, `erd`; CI file → `ci-cd`; tests → `testing-strategy`) **plus the matching
   domain pack** for the detected type (e.g. Godot → game pack; langchain → llm pack). Confirm via multi-select
   (default depth `standard`). Intersect with the **missing** list — you only ever generate missing docs.

4. **Short product intake (optional).** Code reveals *how*, not *why*. Ask ≤4 questions to capture product intent
   (what/for whom/goals) so `PRD`/`arch-overview` aren't hollow. Skippable → those fields become `TBD`.

5. **Generate ONLY missing docs** from the code analysis, rendered via the catalog's templates. Unknown → `TBD`.
   Document *what actually exists* — do not invent architecture the code doesn't show.
   - Seed `docs/architecture/adr/0001-initial-architecture.md` describing the **as-is** architecture/stack (only if no ADRs exist).
   - Paths and filenames come straight from `doc-catalog.md` exactly as listed (folders lowercase; root meta UPPERCASE, docs/ lowercase-kebab).

6. **Write/refresh the brain — without clobbering.**
   - `CLAUDE.md`: if absent, create with the index block. If present, inject the marker block; if it already has
     other content, **append** the block once and leave existing content untouched (never rewrite the user's CLAUDE.md prose).
   - `.claude/acta.md`: registry with a row per doc — generated docs `active`; pre-existing docs recorded with
     status `external` so future `acta:track` knows they exist but weren't authored here.
   - `docs/README.md`: if absent, generate it; if present, **skip** (report it).

7. **Backfill the skill-owned layers (detect → offer, don't force).** The catalog disciplines above don't cover
   `docs/design/`, `docs/business/`, `docs/legal/` — those are owned by their own skills. Scan for their signals and,
   if found and the layer is missing, **offer to run the skill** (each reads the same code, so nothing is re-derived):
   - **design** — a styling system in the code (Tailwind config, CSS variables/tokens, a component library, theme
     files) → suggest `/acta:design` to reverse-engineer `tokens.md` + `components.md` + the design-system from it.
   - **business** — pricing/plans/billing in code or config (a Stripe catalog, a `plans` table) → suggest `/acta:business`.
   - **legal** — data collection, cookies/analytics, third-party vendors/sub-processors → suggest `/acta:legal`.
   Offer only; adopt itself never writes these layers (they're conversational and skill-owned).

8. **Summary.** Two clear lists:
   - **Created** (missing docs now generated).
   - **Left untouched** (pre-existing docs — path each), explicitly: *"already present, not modified."*
   - **Suggested layers** (any skill-owned layer detected but not generated — name the skill to run).

## Rules (the defining guarantee)

- **NEVER overwrite an existing doc.** Existing → always skip + report. No merge, no prompt-to-overwrite — adopt
  is safe-by-default on a real project.
- Never fabricate. Reverse-engineer only what the code supports; everything else is `TBD` or an intake question.
- Idempotent: re-running only fills newly-missing gaps; already-present docs stay untouched; brain/registry regenerate in place.
- Content in the project's documentation language (default English). Solo right-sizing applies. After adopt, ongoing updates are `/acta:track`'s job.
