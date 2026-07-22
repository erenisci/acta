# Document catalog — the contract

Every `acta:*` skill reads this. It lists, for each document: its **path**, **discipline**, **tier**,
**growth policy**, its **template** (or `_doc-format`), and its **sections** (the H2 headings).

> The catalog data lives in a fenced `text` code block on purpose: this file is a machine-read contract, and a
> fenced block is never reflowed, realigned, or merged by markdown formatters (Prettier, etc.). Do not convert it
> to a table.

## Conventions (filenames follow the common open-source standard)

- Root meta-files are UPPERCASE: `README.md`, `CHANGELOG.md`, `CONTRIBUTING.md`, `CLAUDE.md`, `LICENSE`.
- `README.md` folder-indexes stay UPPERCASE: `docs/README.md`, `docs/architecture/adr/README.md`.
- Everything else under `docs/` is lowercase kebab-case: `docs/product/prd.md`, `docs/architecture/overview.md`,
  `docs/architecture/adr/0001-initial-architecture.md`. Folders are always lowercase.
- `.claude/acta.md` (registry) is internal agent state — lowercase by design.

## Legend

- **tier**: `core` / `standard` / `full` (see `disciplines.md`).
- **growth** (how `acta:track` and re-runs treat the file — enforces the anti-bloat rule):
  - `in-place` — current-state doc. Edit/merge in place; never append-grow. Keep it the size of the truth.
  - `append-log` — chronological. Add a new structured entry at the top of the log; never rewrite history.
  - `per-item` — a folder of one file per item (e.g. one ADR per decision). New item = new file; existing files immutable except status.
  - `regenerate` — fully rebuilt from current state every run (index/brain/registry).
- **template**: `_doc-format` is the universal `templates/_doc-format.md`; a named `.tmpl` overrides it.
- `(solo-light)` in a sections list means render the lightweight variant.

**Link hygiene:** a generated doc may cross-link ONLY to docs in the same build selection. Never emit a link (or a
`TBD` placeholder) to a doc that was not generated; omit out-of-scope references entirely.

**Rendering:** `acta:build` / `acta:adopt` render each selected doc via its template, filling values from the
brief/answers/code; unknown → `TBD`. `acta:track` reopens `in-place`/`append-log` docs and updates them.

## Catalog

Each row: `id | path | tier | growth | template | sections`

```text
# ---------- knowledge (always present; not user-selectable) ----------
readme        | README.md                | core     | in-place   | templates/README.md.tmpl             | Overview; Features; Getting Started; Project Structure; Docs; License (never overwrite if it already exists)
brain         | CLAUDE.md                | core     | regenerate | templates/CLAUDE-index-block.md.tmpl | marker block only: Project documentation index
registry      | .claude/acta.md          | core     | regenerate | templates/registry.md.tmpl           | Profile; Selected disciplines; Document registry
docs-index    | docs/README.md           | core     | regenerate | templates/docs-README.md.tmpl        | Index of all docs by discipline
glossary      | docs/glossary.md         | core     | in-place   | _doc-format                          | Terms (A-Z)
onboarding    | docs/onboarding.md       | standard | in-place   | _doc-format                          | Prerequisites; Setup; First Run; Where Things Live; Common Tasks
maintenance   | docs/maintenance.md      | standard | in-place   | _doc-format                          | Routine Tasks; Dependencies; Upgrades; Troubleshooting
contributing  | CONTRIBUTING.md          | full     | in-place   | _doc-format                          | How to Propose Changes; Standards; Checks (solo-light)
scratch       | SCRATCH.md               | core     | in-place   | templates/SCRATCH.md.tmpl            | Working scratchpad (🔴🟡🔵) for in-flight bugs/changes; /acta:track DRAINS it into permanent docs; do-not-hand-delete; git-ignored (create if absent, never overwrite notes)

# ---------- product ----------
prd            | docs/product/prd.md                     | core     | in-place | templates/PRD.md.tmpl | Problem; Goals; Non-Goals; Target Users; Scope (v1); Success Metrics; Assumptions; Open Questions
req-func       | docs/product/requirements-functional.md | standard | in-place | _doc-format           | Overview; Functional Requirements (FR-N: description, priority, acceptance)
req-nfr        | docs/product/requirements-nfr.md        | standard | in-place | _doc-format           | Performance; Reliability; Security; Usability; Maintainability; Constraints
user-stories   | docs/product/user-stories.md            | standard | in-place | _doc-format           | Stories (As a X I want Y so that Z; acceptance criteria)
use-cases      | docs/product/use-cases.md               | full     | in-place | _doc-format           | Actors; Use Cases (main / alternate / exceptions)
feature-specs  | docs/product/feature-specs.md           | standard | in-place | _doc-format           | Per-feature: Summary; Behavior; States; Edge Cases; Out of Scope
business-rules | docs/product/business-rules.md          | full     | in-place | _doc-format           | Rules (BR-N: statement, rationale, source)
domain-model   | docs/product/domain-model.md            | full     | in-place | _doc-format           | Entities; Relationships; Invariants; Ubiquitous Language
roadmap-vision | docs/product/roadmap-vision.md          | core     | in-place | _doc-format           | Vision; Themes; Now / Next / Later
analytics      | docs/product/analytics-plan.md          | full     | in-place | _doc-format           | Goals; Key Events; Properties; Funnels; Privacy

# ---------- project ----------
roadmap       | docs/project/roadmap.md             | core     | in-place   | _doc-format                 | Milestones (M-N: goal, scope, status, target); Dependencies
progress      | docs/progress.md                    | core     | in-place   | _doc-format                 | Current Status; In Progress; Done (recent); Blocked; Next Up
changelog     | CHANGELOG.md                        | core     | append-log | templates/CHANGELOG.md.tmpl | Unreleased; version entries (Keep a Changelog + SemVer)
release-plan  | docs/project/release-plan.md        | standard | in-place   | _doc-format                 | Versioning; Release Checklist; Cadence; Environments
dor           | docs/project/definition-of-ready.md | standard | in-place   | _doc-format                 | A task is Ready when ... (checklist)
dod           | docs/project/definition-of-done.md  | standard | in-place   | _doc-format                 | A task is Done when ... (checklist)
risk-register | docs/project/risk-register.md       | full     | in-place   | _doc-format                 | Risks (R-N: description, likelihood, impact, mitigation, status)
tech-debt     | docs/project/tech-debt.md           | standard | in-place   | _doc-format                 | Debt items (TD-N: what, why it exists, cost, remediation)

# ---------- code (code + architecture) ----------
structure        | docs/engineering/project-structure.md      | core     | in-place | _doc-format           | Layout (tree); What Goes Where; Boundaries; Conventions
coding-standards | docs/engineering/coding-standards.md       | core     | in-place | _doc-format           | Language; Formatting/Lint; Patterns; Anti-patterns; Comments
naming           | docs/engineering/naming-conventions.md     | standard | in-place | _doc-format           | Files; Variables/Functions; Types; Branches; Commits
git-workflow     | docs/engineering/git-workflow.md           | core     | in-place | _doc-format           | Branching; Commit Convention; PR/merge; Tags/Releases
self-review      | docs/engineering/self-review-checklist.md  | standard | in-place | _doc-format           | Before Commit; Correctness; Tests; Docs; Security (solo-light)
arch-overview    | docs/architecture/overview.md              | core     | in-place | _doc-format           | Context; Components; Data Flow; Tech Stack; Key Decisions (see ADRs)
system-design    | docs/architecture/system-design.md         | standard | in-place | _doc-format           | Requirements; High-Level Design; Components; Trade-offs; Scaling
adr              | docs/architecture/adr/NNNN-*.md            | core     | per-item | templates/ADR.md.tmpl | Status; Context; Decision; Consequences (also maintain docs/architecture/adr/README.md index)
rfc              | docs/architecture/rfc/NNNN-*.md            | full     | per-item | templates/RFC.md.tmpl | (solo-light) Summary; Motivation; Proposal; Alternatives; Risks (also maintain docs/architecture/rfc/README.md index)
db-design        | docs/architecture/database-design.md       | standard | in-place | _doc-format           | Data Model; Tables/Collections; Indexes; Migrations
erd              | docs/architecture/erd.md                   | standard | in-place | _doc-format           | ERD (mermaid); Entities; Relationships
api              | docs/architecture/api.md                   | standard | in-place | _doc-format           | Overview; Auth; Endpoints; Errors; Versioning (link OpenAPI if present)
diagrams         | docs/architecture/diagrams.md              | full     | in-place | _doc-format           | Sequence; Component; Deployment (mermaid)

# ---------- quality ----------
testing-strategy    | docs/quality/testing-strategy.md    | standard | in-place | _doc-format | Philosophy; Test Pyramid; Coverage Goals; Tools; What/When to Test
unit-testing        | docs/quality/unit-testing.md        | full     | in-place | _doc-format | Scope; Conventions; Mocking; Examples
integration-testing | docs/quality/integration-testing.md | full     | in-place | _doc-format | Scope; Fixtures; Environments; Examples
e2e-testing         | docs/quality/e2e-testing.md         | full     | in-place | _doc-format | Scope; Tooling; Critical Flows; Data
qa-checklist        | docs/quality/qa-checklist.md        | standard | in-place | _doc-format | Pre-release manual checks

# ---------- ops (operations + security) ----------
env-vars      | docs/operations/env-vars.md          | core     | in-place | _doc-format | Variables (name, purpose, required, example - no secrets)
configuration | docs/operations/configuration.md     | standard | in-place | _doc-format | Config Sources; Precedence; Per-Environment
error-handling| docs/operations/error-handling.md    | standard | in-place | _doc-format | Principles; Error Types; Propagation; User-Facing vs Internal
error-catalog | docs/operations/error-catalog.md     | full     | in-place | _doc-format | Codes (CODE: meaning, cause, action)
logging       | docs/operations/logging.md           | standard | in-place | _doc-format | Levels; Format; What to Log; What Not to Log
monitoring    | docs/operations/monitoring.md        | full     | in-place | _doc-format | Metrics; Alerts; Dashboards; SLIs/SLOs
ci-cd         | docs/operations/ci-cd.md             | standard | in-place | _doc-format | Pipeline Stages; Triggers; Gates; Secrets
deployment    | docs/operations/deployment.md        | core     | in-place | _doc-format | Environments; Steps; Prerequisites; Verification
rollback      | docs/operations/rollback.md          | standard | in-place | _doc-format | When; How; Data Considerations
backup        | docs/operations/backup.md            | full     | in-place | _doc-format | What; Frequency; Location; Restore Test
dr            | docs/operations/disaster-recovery.md | full     | in-place | _doc-format | Scenarios; RTO/RPO; Recovery Steps
runbook       | docs/operations/runbook.md           | full     | in-place | _doc-format | (solo-light) Common Incidents -> Steps
performance   | docs/operations/performance.md       | full     | in-place | _doc-format | Targets; Bottlenecks; Budgets
scalability   | docs/operations/scalability.md       | full     | in-place | _doc-format | Growth Assumptions; Scaling Strategy; Limits
caching       | docs/operations/caching.md           | full     | in-place | _doc-format | What; Where; Invalidation; TTLs
security      | docs/operations/security.md          | standard | in-place | _doc-format | AuthN/AuthZ; Secrets; Data Protection; Dependencies; Checklist
threat-model  | docs/operations/threat-model.md      | full     | in-place | _doc-format | Assets; Threats (STRIDE); Mitigations; Trust Boundaries

# ---------- ai (AI-assisted development) ----------
ai-guidelines       | docs/ai/ai-guidelines.md       | core     | in-place   | _doc-format | How AI is used here; Boundaries; Review expectations
ai-coding-rules     | docs/ai/ai-coding-rules.md     | standard | in-place   | _doc-format | Do/Don't; Patterns to follow; Files AI must not touch
ai-context          | docs/ai/ai-context.md          | core     | in-place   | _doc-format | Project summary for AI; Key facts; Pointers to docs
prompt-library      | docs/ai/prompt-library.md      | full     | in-place   | _doc-format | Reusable prompts by task
ai-review-checklist | docs/ai/ai-review-checklist.md | standard | in-place   | _doc-format | What to verify in AI-generated code
ai-doc-rules        | docs/ai/ai-doc-rules.md        | full     | in-place   | _doc-format | How AI keeps docs updated (points to acta:track)
ai-decision-log     | docs/ai/ai-decision-log.md     | standard | append-log | _doc-format | Entries (date, decision, rationale, by AI/human)
ai-workflow         | docs/ai/ai-workflow.md         | full     | in-place   | _doc-format | Brief -> Build -> code -> Track loop

# ========== DOMAIN PACKS (project-type gated; generated ONLY when that type is selected) ==========

# ---------- pack: ml (machine learning / data science) ----------
ml-problem     | docs/ml/problem-framing.md | core     | in-place   | _doc-format | Problem; Success Metric (offline + online); Baseline; Constraints
dataset-card   | docs/ml/dataset-card.md    | core     | in-place   | _doc-format | Source; Schema; Size; Splits; Labeling; Biases; License/PII
experiments    | docs/ml/experiments.md     | core     | append-log | _doc-format | Log entries (date, hypothesis, setup, metric, result)
model-card     | docs/ml/model-card.md      | core     | in-place   | _doc-format | Model; Intended Use; Training Data; Metrics; Limitations; Ethical Considerations
ml-evaluation  | docs/ml/evaluation.md      | standard | in-place   | _doc-format | Metrics; Test Sets; Slices; Acceptance Thresholds
mlops          | docs/ml/mlops.md           | standard | in-place   | _doc-format | Serving; Versioning; Monitoring; Drift; Retraining
responsible-ai | docs/ml/responsible-ai.md  | full     | in-place   | _doc-format | Fairness; Bias; Privacy; Transparency

# ---------- pack: llm (LLM application: agent / RAG / chatbot) ----------
llm-architecture | docs/llm/architecture.md | core     | in-place | _doc-format | Approach (RAG/agent/fine-tune); Model(s); Data Sources; Flow
prompts          | docs/llm/prompts.md      | core     | in-place | _doc-format | System Prompts; Templates; Versioning
eval-harness     | docs/llm/eval-harness.md | core     | in-place | _doc-format | Eval Sets; Metrics (accuracy, faithfulness); Regression Checks
guardrails       | docs/llm/guardrails.md   | standard | in-place | _doc-format | Input/Output Validation; Safety; Refusals; PII
rag-sources      | docs/llm/rag-sources.md  | standard | in-place | _doc-format | Corpora; Chunking; Embeddings; Retrieval; Refresh
cost-latency     | docs/llm/cost-latency.md | standard | in-place | _doc-format | Token Budget; Caching; Latency Targets; Fallbacks

# ---------- pack: security (authorized / defensive security product or research) ----------
sec-architecture | docs/security/architecture.md    | core     | in-place | _doc-format | Components; Trust Boundaries; Data Handling
detection-rules  | docs/security/detection-rules.md | core     | in-place | _doc-format | Rules (id, logic, data source, false-positive rate)
methodology      | docs/security/methodology.md     | core     | in-place | _doc-format | Scope; Approach; Tools; Rules of Engagement (authorized use only)
compliance       | docs/security/compliance.md      | standard | in-place | _doc-format | Frameworks (SOC2/ISO/GDPR); Controls; Gaps
sbom             | docs/security/sbom.md            | standard | in-place | _doc-format | Dependencies; SBOM; Provenance; Update Policy
abuse-cases      | docs/security/abuse-cases.md     | full     | in-place | _doc-format | Misuse/abuse scenarios; Mitigations

# ---------- pack: data (data engineering) ----------
data-architecture | docs/data/architecture.md | core     | in-place | _doc-format | Sources; Storage; Layers (raw/staged/marts); Flow
pipelines         | docs/data/pipelines.md    | core     | in-place | _doc-format | Jobs; Schedule; Dependencies; Idempotency
data-quality      | docs/data/data-quality.md | standard | in-place | _doc-format | Checks; SLAs; Freshness; Alerting
lineage           | docs/data/lineage.md      | standard | in-place | _doc-format | Sources -> Transforms -> Outputs
data-governance   | docs/data/governance.md   | full     | in-place | _doc-format | Ownership; PII; Retention; Access

# ---------- pack: game ----------
gdd            | docs/game/game-design.md    | core     | in-place | _doc-format | Concept; Core Loop; Mechanics; Win/Lose; Progression
level-design   | docs/game/level-design.md   | standard | in-place | _doc-format | Levels; Pacing; Difficulty Curve
game-systems   | docs/game/systems.md        | standard | in-place | _doc-format | Entities; State; Save/Load; Economy/Balance
asset-pipeline | docs/game/asset-pipeline.md | standard | in-place | _doc-format | Art/Audio Assets; Formats; Import; Naming

# ---------- pack: hardware (embedded / IoT) ----------
hardware-spec | docs/hardware/hardware-spec.md | core     | in-place | _doc-format | MCU/Board; Peripherals; Pinout; Power
firmware      | docs/hardware/firmware.md      | core     | in-place | _doc-format | Architecture; Build/Flash; RTOS/Loop; Memory
protocols     | docs/hardware/protocols.md     | standard | in-place | _doc-format | Interfaces (I2C/SPI/UART/BLE); Message Formats
power-safety  | docs/hardware/power-safety.md  | full     | in-place | _doc-format | Power Budget; Thermal; Safety/Compliance

# ---------- pack: web3 (smart contracts) ----------
contracts      | docs/web3/contracts.md      | core     | in-place | _doc-format | Contracts; Responsibilities; Interfaces; Upgradeability
contract-audit | docs/web3/security-audit.md | core     | in-place | _doc-format | Threats (reentrancy, overflow, access control); Checks; Audit Status
tokenomics     | docs/web3/tokenomics.md     | standard | in-place | _doc-format | Token; Supply; Incentives; Flows (if applicable)
gas-deployment | docs/web3/gas-deployment.md | standard | in-place | _doc-format | Networks; Deploy; Gas; Verification

# ---------- pack: devops (infrastructure / platform / SRE) ----------
iac           | docs/devops/infrastructure-as-code.md | core     | in-place | _doc-format | Providers; Modules; State; Environments
orchestration | docs/devops/orchestration.md          | core     | in-place | _doc-format | Containers; k8s/Compose; Services; Scaling
environments  | docs/devops/environments.md           | standard | in-place | _doc-format | Dev/Staging/Prod; Promotion; Secrets
sre-slo       | docs/devops/sre-slo.md                | standard | in-place | _doc-format | SLIs/SLOs; Error Budget; On-call; Alerts
infra-cost    | docs/devops/cost.md                   | full     | in-place | _doc-format | Cost Drivers; Budgets; Optimization

# ---------- pack: robotics ----------
robot-architecture | docs/robotics/architecture.md | core     | in-place | _doc-format | Nodes/Topics; Compute; Actuators/Sensors; Comms
control            | docs/robotics/control.md      | core     | in-place | _doc-format | Kinematics; Control Loops; Motion Planning
perception         | docs/robotics/perception.md   | standard | in-place | _doc-format | Sensors; Fusion; Localization/Mapping
robot-safety       | docs/robotics/safety.md       | core     | in-place | _doc-format | Failure Modes; E-stop; Operating Envelope
robot-simulation   | docs/robotics/simulation.md   | standard | in-place | _doc-format | Sim Environment; Sim-to-Real; Test Scenarios

# ---------- pack: xr (AR / VR / mixed reality) ----------
xr-experience       | docs/xr/experience.md          | core     | in-place | _doc-format | Concept; Immersion; Scenes; User Journey
xr-interaction      | docs/xr/interaction.md         | core     | in-place | _doc-format | Input (hands/controllers/gaze); Locomotion; Feedback
comfort-performance | docs/xr/comfort-performance.md | core     | in-place | _doc-format | Framerate Budget; Comfort (motion sickness); LOD
xr-assets           | docs/xr/assets.md              | standard | in-place | _doc-format | 3D/Audio Assets; Formats; Optimization

# ---------- pack: fintech (payments / regulated finance) ----------
payments       | docs/fintech/payments.md   | core     | in-place | _doc-format | Flows; Providers; Idempotency; Refunds/Disputes
ledger         | docs/fintech/ledger.md     | core     | in-place | _doc-format | Double-entry; Reconciliation; Balances; Audit Trail
fin-compliance | docs/fintech/compliance.md | core     | in-place | _doc-format | KYC/AML; PCI-DSS; Regulatory; Reporting
fraud-risk     | docs/fintech/fraud-risk.md | standard | in-place | _doc-format | Risk Signals; Limits; Monitoring

# ---------- pack: scientific (research / simulation / HPC) ----------
research-plan   | docs/scientific/research-plan.md   | core     | in-place | _doc-format | Question; Hypotheses; Methods; Success Criteria
reproducibility | docs/scientific/reproducibility.md | core     | in-place | _doc-format | Environment; Seeds; Data/Code Versioning; Rerun Steps
methods         | docs/scientific/methods.md         | standard | in-place | _doc-format | Algorithms; Parameters; Assumptions
validation      | docs/scientific/validation.md      | standard | in-place | _doc-format | Numerical Accuracy; Benchmarks; Error Analysis

# ---------- pack: media (media / streaming) ----------
media-pipeline | docs/media/pipeline.md   | core     | in-place | _doc-format | Ingest; Encoding/Transcoding; Formats/Codecs; Storage
delivery       | docs/media/delivery.md   | core     | in-place | _doc-format | Streaming (HLS/DASH); CDN; Adaptive Bitrate; Latency
rights-drm     | docs/media/rights-drm.md | standard | in-place | _doc-format | Licensing; DRM; Access Control

# ---------- pack: geospatial (GIS / mapping) ----------
geo-data           | docs/geospatial/data-sources.md       | core     | in-place | _doc-format | Sources; Formats (GeoJSON/Shapefile/raster); Licensing
coordinate-systems | docs/geospatial/coordinate-systems.md | core     | in-place | _doc-format | CRS/Projections; Datums; Transforms
spatial-queries    | docs/geospatial/spatial-queries.md    | standard | in-place | _doc-format | Indexing; Queries; Performance
geo-rendering      | docs/geospatial/rendering.md          | standard | in-place | _doc-format | Tiling; Layers; Styling; Interaction

# ========== SKILL-OWNED LAYER: design (owned by acta:design / acta:design-prompt; NOT built from disciplines) ==========
# Listed here so acta:audit knows the paths/sections and treats them as valid, not orphans. Generated only when the
# user runs acta:design — tiered like the disciplines (core/standard/full). A non-UI project gets only brand +
# design-principles + messaging (light or no design-system); web/components/visual docs are skipped.
brand              | docs/design/brand.md                 | core     | in-place   | _doc-format      | Identity; Positioning; Voice & Tone; Mood/Character; Audience
design-principles  | docs/design/design-principles.md     | core     | in-place   | _doc-format      | Principles; Do; Don't; Priorities (what wins when they conflict)
design-system      | docs/design/design-system.md         | core     | in-place   | _doc-format      | Approach (detected, not dictated); How To Use; Rules (states/variants/reuse); Index of design docs
tokens             | docs/design/tokens.md                | core     | in-place   | _doc-format      | Tokens (color / typography / spacing / radius / elevation / motion in ONE fenced `text` block — formatter-proof)
messaging          | docs/design/messaging.md             | core     | in-place   | _doc-format      | Voice; Taglines; Value Props; Section Copy; CTA Copy; FAQ Copy
components         | docs/design/components.md            | core     | in-place   | _doc-format      | Inventory (per component: variants; states hover/focus/disabled; usage)
typography         | docs/design/typography.md            | standard | in-place   | _doc-format      | Families; Type Scale; Weights; Line-height/Tracking; Usage
color              | docs/design/color.md                 | standard | in-place   | _doc-format      | Palette; Semantic Roles; State Colors; Contrast Pairings; Dark Mode
spacing-layout     | docs/design/spacing-layout.md        | standard | in-place   | _doc-format      | Spacing Scale; Grid; Breakpoints; Layout Patterns; Density
iconography        | docs/design/iconography.md           | standard | in-place   | _doc-format      | Icon Set/Source; Sizing; Style; Usage; Do/Don't
imagery            | docs/design/imagery.md               | standard | in-place   | _doc-format      | Photography/Illustration Style; Treatment; Aspect Ratios; Do/Don't
motion             | docs/design/motion.md                | standard | in-place   | _doc-format      | Principles; Durations; Easing; What Animates; Reduced-Motion
accessibility      | docs/design/accessibility.md         | standard | in-place   | _doc-format      | Contrast (WCAG AA); Focus; Keyboard; Reduced-Motion; ARIA Patterns; Targets
content-style      | docs/design/content-style-guide.md   | standard | in-place   | _doc-format      | Grammar; Capitalization; Terminology; Numbers/Dates; Tone Rules
ux-flows           | docs/design/ux-flows.md              | standard | in-place   | _doc-format      | Information Architecture; Key Flows; Screens; States (empty/loading/error)
references         | docs/design/references.md            | standard | in-place   | _doc-format      | Reference Sites/Images; What To Borrow (layout/feel only); Moodboard; Anti-references
ddr                | docs/design/decisions/NNNN-*.md      | full     | per-item   | templates/DDR.md.tmpl | Status; Context; Decision; Consequences (also maintain docs/design/decisions/README.md index)
design-qa          | docs/design/design-qa-checklist.md   | full     | in-place   | _doc-format      | Visual QA; Interaction QA; Responsive; Accessibility; Cross-surface Consistency
design-index       | docs/design/README.md                | core     | regenerate | templates/docs-README.md.tmpl | Index of all design docs by tier
# Surfaces (generated on request; the live preview is a real Artifact, spec saved here):
surface-web        | docs/design/web.md                   | full     | in-place   | _doc-format      | Sections/Screens; Content; Layout; States (spec for the generated web Artifact)
surface-logo       | docs/design/logo.md                  | full     | in-place   | _doc-format      | Concept; Variants (mark/wordmark); Clearspace; Sizing; Color (spec for the generated logo Artifact)
surface-deck       | docs/design/deck.md                  | full     | in-place   | _doc-format      | Narrative; Slides; Layout; Content (spec for the generated deck Artifact)
surface-ads        | docs/design/ads.md                   | full     | in-place   | _doc-format      | Formats/Sizes; Message; Layout; Copy (spec for the generated ads Artifact)
surface-og         | docs/design/og-image.md              | full     | in-place   | _doc-format      | Dimensions; Layout; Copy; Brand Marks (spec for the generated og-image Artifact)
```

## Discipline → included ids (for build/adopt selection)

- **product**: prd, req-func, req-nfr, user-stories, use-cases, feature-specs, business-rules, domain-model, roadmap-vision, analytics
- **project**: roadmap, progress, changelog, release-plan, dor, dod, risk-register, tech-debt
- **code**: structure, coding-standards, naming, git-workflow, self-review, arch-overview, system-design, adr, rfc, db-design, erd, api, diagrams
- **quality**: testing-strategy, unit-testing, integration-testing, e2e-testing, qa-checklist
- **ops**: env-vars, configuration, error-handling, error-catalog, logging, monitoring, ci-cd, deployment, rollback, backup, dr, runbook, performance, scalability, caching, security, threat-model
- **ai**: ai-guidelines, ai-coding-rules, ai-context, prompt-library, ai-review-checklist, ai-doc-rules, ai-decision-log, ai-workflow
- **knowledge (auto)**: readme, brain, registry, docs-index, glossary, onboarding, maintenance, contributing, scratch

## Domain packs → included ids (added when the project type matches; see `project-types.md`)

- **ml**: ml-problem, dataset-card, experiments, model-card, ml-evaluation, mlops, responsible-ai
- **llm**: llm-architecture, prompts, eval-harness, guardrails, rag-sources, cost-latency
- **security**: sec-architecture, detection-rules, methodology, compliance, sbom, abuse-cases
- **data**: data-architecture, pipelines, data-quality, lineage, data-governance
- **game**: gdd, level-design, game-systems, asset-pipeline
- **hardware**: hardware-spec, firmware, protocols, power-safety
- **web3**: contracts, contract-audit, tokenomics, gas-deployment
- **devops**: iac, orchestration, environments, sre-slo, infra-cost
- **robotics**: robot-architecture, control, perception, robot-safety, robot-simulation
- **xr**: xr-experience, xr-interaction, comfort-performance, xr-assets
- **fintech**: payments, ledger, fin-compliance, fraud-risk
- **scientific**: research-plan, reproducibility, methods, validation
- **media**: media-pipeline, delivery, rights-drm
- **geospatial**: geo-data, coordinate-systems, spatial-queries, geo-rendering

## Skill-owned areas (outside this scaffold — not generated by build/adopt)

Three areas are **owned by their own skills**, not scaffolded from this catalog. They live under `docs/` but are
created and maintained only when the user runs the relevant skill. `acta:audit` treats them as **valid, not orphans**,
and only checks them if the folder exists:

- `docs/design/` — owned by `acta:design` / `acta:design-prompt`. A **tiered senior-designer doc-base** (rows above,
  under "SKILL-OWNED LAYER: design"): core (brand, design-principles, design-system, tokens, messaging, components,
  README index), standard (typography, color, spacing-layout, iconography, imagery, motion, accessibility,
  content-style-guide, ux-flows, references), full (DDR decision records under `docs/design/decisions/`, design-qa
  checklist) + on-request surface specs (web/logo/deck/ads/og-image). Synced by `acta:track`; wired into the brain via
  the `{{DESIGN_LINKS}}` index block.
- `docs/business/` — owned by `acta:business` (business-model, pricing, unit-economics, projections, go-to-market, competitors). Git-ignored by default.
- `docs/legal/` — owned by `acta:legal` / `acta:legal-brief` (overview, privacy, terms, cookies, consent, data-processing, compliance-checklist, and the consolidated `lawyer-brief.md`); synced by `acta:track`. Git-ignored by default.

These follow the same invariants (never fabricate, in-place/anti-bloat, project content language) but their exact doc set is defined in
each skill's `SKILL.md`, not here — because they are conversational/iterative, not a fixed scaffold.
