# Project types — detection & structure profiles

`acta:build` (from the brief) and `acta:adopt` (from the code) read this to **detect what kind of project this is**
and propose a **fitting structure** — the universal core disciplines at a sensible depth, **plus the matching domain
pack** — instead of generating every possible doc.

## How detection works

1. Gather signal: the brief's "What are you building?" + "Tech preferences" (build), or detected stack/deps/files (adopt).
2. Match against the `signals` below; pick the single best `type`. If two are close, present the top two and let the user pick.
3. Propose that type's `core` disciplines at its `depth`, plus its `packs`. Show the detection and evidence in 2–3 lines,
   then let the user confirm or adjust (change type, toggle disciplines/packs, change depth) via `AskUserQuestion`.
4. Unknown / no clear match → fall back to `generic` and ask the user to confirm the type.

Domain packs (their documents) are defined in `doc-catalog.md` under the DOMAIN PACKS section. A pack is only
generated when its type is selected. Core disciplines are `product, project, code, quality, ops, ai`.

## Profiles

Each row: `type | signals (any-of) | core disciplines @ depth | packs`

```text
web-app        | web app, SaaS, dashboard, website, frontend, Next.js, React, Vue, Svelte, Tailwind        | product, project, code, quality, ops @ standard | -
api-service    | API, backend, REST, GraphQL, microservice, server, Express, FastAPI, Nest, Django, Rails   | product, project, code, quality, ops @ standard | -
mobile-app     | mobile, iOS, Android, React Native, Expo, Flutter, SwiftUI, Kotlin                          | product, project, code, quality, ops @ standard | -
desktop-app    | desktop, Electron, Tauri, native app, WPF, Qt                                               | product, project, code, quality, ops @ standard | -
cli-tool       | CLI, command-line, terminal tool, shell tool                                                | project, code, quality @ standard (product core) | -
library        | library, SDK, package, framework, npm package, pip package, crate, gem                      | project, code, quality @ standard (product core) | -
static-site    | blog, static site, docs site, portfolio, landing, Hugo, Astro, Jekyll, Eleventy            | project, code @ core (product core)             | -
extension      | browser extension, Chrome extension, Firefox add-on, manifest v3                            | product, project, code, quality @ standard      | -
automation     | bot, scraper, crawler, automation, Discord bot, Telegram bot, cron, workflow               | project, code, ops @ standard                   | -
ml             | machine learning, ML, model, training, dataset, scikit, PyTorch, TensorFlow, CV, NLP model | product, project, code, quality, ops @ standard | ml
llm-app        | LLM, GPT, Claude, RAG, chatbot, agent, embeddings, prompt, vector, retrieval, LangChain     | product, project, code, ops @ standard          | llm
data-eng       | ETL, data pipeline, warehouse, Airflow, dbt, Spark, streaming, ingestion, lakehouse         | project, code, quality, ops @ standard          | data
security       | security tool, scanner, pentest, exploit, detection, SIEM, malware analysis, CTF, vuln, C2  | product, project, code, quality, ops @ standard | security
game           | game, Godot, Unity, Unreal, roguelike, platformer, gameplay, level, sprite, ECS             | product, project, code, quality @ standard      | game
embedded       | embedded, firmware, microcontroller, Arduino, ESP32, Raspberry Pi, RTOS, sensor, IoT        | project, code, quality, ops @ standard          | hardware
web3           | blockchain, smart contract, Solidity, Ethereum, web3, DeFi, NFT, on-chain, Foundry, Hardhat | product, project, code, quality, ops @ standard | web3
devops         | infrastructure, DevOps, Terraform, Kubernetes, k8s, Ansible, Pulumi, IaC, platform, SRE, homelab | project, code, quality, ops @ standard          | devops
robotics       | robot, robotics, ROS, ROS2, drone, actuator, kinematics, autonomous, SLAM, motor            | project, code, quality, ops @ standard          | robotics
xr             | AR, VR, XR, augmented reality, virtual reality, mixed reality, Quest, ARKit, ARCore, Unity XR | product, project, code, quality @ standard      | xr
fintech        | fintech, payments, banking, trading, ledger, invoicing, Stripe, wallet, PCI, KYC, billing   | product, project, code, quality, ops @ standard | fintech
scientific     | research, simulation, HPC, scientific, numerical, physics, computational, bioinformatics, quant | project, code, quality @ standard               | scientific
media          | video, audio, streaming, media, transcoding, encoding, podcast, VOD, live stream            | product, project, code, quality, ops @ standard | media
geospatial     | GIS, geospatial, mapping, maps, geo, spatial, GPS, cartography, OpenStreetMap, routing      | product, project, code, quality @ standard      | geospatial
generic        | (fallback when nothing above clearly matches)                                               | product, project, code, quality, ops @ standard | -
```

## Notes

- `ai` (AI-assisted development) is offered for any type but pre-checked for `llm-app` and `ml` (and whenever the
  brief says AI is used to build). It is about *using AI to build*, distinct from the `ml`/`llm` product packs.
- `(product core)` means: include the product discipline but only at `core` depth even if the rest is `standard`.
- The `security` pack is scoped to **authorized/defensive** work (rules of engagement, detection, hardening).
- Multiple packs can apply (e.g. an LLM app that also ships a model → `llm` + `ml`); propose both and let the user trim.
