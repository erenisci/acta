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

> Exact paths, sections, and growth policies for every doc above are in `doc-catalog.md` — that is the contract.
