# Document catalog — the contract

Every `acta-*` skill reads this. It lists, for each document: its **path**, **discipline**, **tier**,
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
- **growth** (how `acta-track` and re-runs treat the file — enforces the anti-bloat rule):
  - `in-place` — current-state doc. Edit/merge in place; never append-grow. Keep it the size of the truth.
  - `append-log` — chronological. Add a new structured entry at the top of the log; never rewrite history.
  - `per-item` — a folder of one file per item (e.g. one ADR per decision). New item = new file; existing files immutable except status.
  - `regenerate` — fully rebuilt from current state every run (index/brain/registry).
- **template**: `_doc-format` is the universal `templates/_doc-format.md`; a named `.tmpl` overrides it.
- `(solo-light)` in a sections list means render the lightweight variant.

**Link hygiene:** a generated doc may cross-link ONLY to docs in the same build selection. Never emit a link (or a
`TBD` placeholder) to a doc that was not generated; omit out-of-scope references entirely.

**Rendering:** `acta-build` / `acta-adopt` render each selected doc via its template, filling values from the
brief/answers/code; unknown → `TBD`. `acta-track` reopens `in-place`/`append-log` docs and updates them.

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
ai-doc-rules        | docs/ai/ai-doc-rules.md        | full     | in-place   | _doc-format | How AI keeps docs updated (points to acta-track)
ai-decision-log     | docs/ai/ai-decision-log.md     | standard | append-log | _doc-format | Entries (date, decision, rationale, by AI/human)
ai-workflow         | docs/ai/ai-workflow.md         | full     | in-place   | _doc-format | Brief -> Build -> code -> Track loop
```

## Discipline → included ids (for build/adopt selection)

- **product**: prd, req-func, req-nfr, user-stories, use-cases, feature-specs, business-rules, domain-model, roadmap-vision, analytics
- **project**: roadmap, progress, changelog, release-plan, dor, dod, risk-register, tech-debt
- **code**: structure, coding-standards, naming, git-workflow, self-review, arch-overview, system-design, adr, rfc, db-design, erd, api, diagrams
- **quality**: testing-strategy, unit-testing, integration-testing, e2e-testing, qa-checklist
- **ops**: env-vars, configuration, error-handling, error-catalog, logging, monitoring, ci-cd, deployment, rollback, backup, dr, runbook, performance, scalability, caching, security, threat-model
- **ai**: ai-guidelines, ai-coding-rules, ai-context, prompt-library, ai-review-checklist, ai-doc-rules, ai-decision-log, ai-workflow
- **knowledge (auto)**: readme, brain, registry, docs-index, glossary, onboarding, maintenance, contributing
