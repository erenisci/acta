# Disciplines → documents (solo tiers)

Six disciplines cover the whole SDLC for a solo builder. Each document belongs to exactly one discipline
and one **tier**. Tiers let `acta-build` offer a right-sized set instead of dumping 70 files on every project.

- **Core** — the minimum a real project should not ship without. Always offered pre-checked.
- **Standard** — most real projects want these. Offered pre-checked when the brief implies real users / deployment.
- **Full** — larger / long-lived projects. Offered unchecked; user opts in.

Team-only artifacts are marked `(solo-light)` — generate a lightweight version, never the heavyweight team process.

---

## product — what & why

| Doc                               | Tier     |
| --------------------------------- | -------- |
| PRD                               | Core     |
| Functional Requirements           | Standard |
| Non-Functional Requirements (NFR) | Standard |
| User Stories                      | Standard |
| Use Cases                         | Full     |
| Feature Specs                     | Standard |
| Business Rules                    | Full     |
| Domain Model                      | Full     |
| Product Roadmap (vision)          | Core     |
| Analytics & Event Tracking Plan   | Full     |

## project — plan & track

| Doc                            | Tier     |
| ------------------------------ | -------- |
| Execution Roadmap / Milestones | Core     |
| PROGRESS                       | Core     |
| CHANGELOG                      | Core     |
| Release Plan                   | Standard |
| Definition of Ready (DoR)      | Standard |
| Definition of Done (DoD)       | Standard |
| Risk Register                  | Full     |
| Technical Debt Log             | Standard |

## code — how it is built (code + architecture)

| Doc                                                   | Tier     |
| ----------------------------------------------------- | -------- |
| Project Structure                                     | Core     |
| Coding Standards                                      | Core     |
| Naming Conventions                                    | Standard |
| Git Workflow / Branching / Commit                     | Core     |
| Self-Review Checklist (solo-light of Code Review)     | Standard |
| Architecture Overview                                 | Core     |
| System Design                                         | Standard |
| ADR (Architecture Decision Records)                   | Core     |
| RFC (solo-light)                                      | Full     |
| Database Design                                       | Standard |
| ERD                                                   | Standard |
| API Documentation (OpenAPI)                           | Standard |
| Diagrams (sequence / component / deployment, mermaid) | Full     |

## quality — confidence

| Doc                            | Tier     |
| ------------------------------ | -------- |
| Testing Strategy               | Standard |
| Unit Testing Guidelines        | Full     |
| Integration Testing Guidelines | Full     |
| E2E Testing Guidelines         | Full     |
| QA Checklist                   | Standard |

## ops — run & protect (operations + security)

| Doc                           | Tier     |
| ----------------------------- | -------- |
| Environment Variables         | Core     |
| Configuration Management      | Standard |
| Error Handling Strategy       | Standard |
| Error Code Catalog            | Full     |
| Logging Strategy              | Standard |
| Monitoring & Observability    | Full     |
| CI/CD Pipeline                | Standard |
| Deployment Guide              | Core     |
| Rollback Strategy             | Standard |
| Backup Strategy               | Full     |
| Disaster Recovery Plan        | Full     |
| Incident Runbook (solo-light) | Full     |
| Performance                   | Full     |
| Scalability                   | Full     |
| Caching                       | Full     |
| Security Guidelines           | Standard |
| Threat Model                  | Full     |

## ai — AI-assisted development

| Doc                       | Tier     |
| ------------------------- | -------- |
| AI Development Guidelines | Core     |
| AI Coding Rules           | Standard |
| AI Context Doc            | Core     |
| AI Prompt Library         | Full     |
| AI Review Checklist       | Standard |
| AI Documentation Rules    | Full     |
| AI Decision Log           | Standard |
| AI Workflow               | Full     |

## knowledge (owned by build/adopt directly, not a user-selectable discipline)

Always present regardless of discipline choice:

- `README.md` (root) — never overwrite if it exists.
- `CLAUDE.md` (root) — the brain / Context Index (marker block only).
- `docs/README.md` — the docs index (regenerated).
- `docs/glossary.md` — shared glossary.
- `docs/onboarding.md`, `docs/maintenance.md` — Standard.
- `CONTRIBUTING.md` — Full, solo-light.

## Domain packs (project-type gated)

The six disciplines above are the universal **core**. For specialized project types, Acta adds a **domain pack** on
top — detected from the brief/code via `project-types.md` — instead of forcing every project into the same shape:

- **ml** — datasets, model card, experiments, evaluation, MLOps, responsible-AI
- **llm** — architecture, prompts, eval-harness, guardrails, RAG sources, cost/latency
- **security** — security architecture, detection rules, methodology, compliance, SBOM, abuse cases (authorized/defensive)
- **data** — data architecture, pipelines, data quality, lineage, governance
- **game** — game design, level design, systems, asset pipeline
- **hardware** — hardware spec, firmware, protocols, power/safety
- **web3** — contracts, security audit, tokenomics, gas/deployment
- **devops** — IaC, orchestration, environments, SRE/SLO, cost
- **robotics** — architecture, control, perception, safety, simulation
- **xr** — experience, interaction, comfort/performance, assets
- **fintech** — payments, ledger, compliance, fraud/risk
- **scientific** — research plan, reproducibility, methods, validation
- **media** — pipeline, delivery, rights/DRM
- **geospatial** — data sources, coordinate systems, spatial queries, rendering

A pack is generated only when its type is selected.

## Product-shipping layers (skill-owned, not build disciplines)

Beyond the six disciplines and the packs, three layers turn a documented project into a **shippable product**. They
are **owned by their own skills** (like the knowledge layer is owned by build/adopt) and written only when the user
runs them — not offered as build disciplines:

- **design** → `docs/design/` — `acta-design` / `acta-design-prompt` (brand, design-system, messaging; synced by `acta-track`).
- **business** → `docs/business/` — `acta-business` (iterative pricing / unit-economics / projections). Git-ignored by default.
- **legal** → `docs/legal/` — `acta-legal` / `acta-legal-brief` (region-aware briefs + lawyer handoff; never binding text; synced by `acta-track`). Git-ignored by default.

> Exact paths, sections, and growth policies for every doc above are in `doc-catalog.md` — that is the contract.
> The skill-owned areas' doc sets live in each skill's `SKILL.md`.
