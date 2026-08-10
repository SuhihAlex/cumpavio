# CUMPAVIO — Project State

**Last updated:** 2026-08-10
**Current Stage:** Stage 0 — Product Contract & Scope Freeze
**Current status:** Stage 0 closeout in progress
**Production status:** Not started

---

## 1. Project

**Name:** CUMPAVIO
**Working tagline:** Know before you buy.
**Market:** Moldova
**Vertical:** Consumer Electronics

CUMPAVIO is a shopping intelligence platform focused on:

**Data → Intelligence → Decision**

---

## 2. Current Stage

### Stage 0 — Product Contract & Scope Freeze

Current objective:

Freeze the CUMPAVIO V1 product scope, architecture direction, roadmap, non-goals and Definition of Done before any engineering implementation begins.

---

## 3. Current Status

Completed in Stage 0:

* product concept reviewed;
* scope risks reviewed;
* V1 categories decided;
* retailer strategy decided;
* matching philosophy decided;
* V1 user/account decision made;
* V1 AI decision made;
* price-intelligence direction decided;
* admin/data-quality requirement decided;
* language scope decided;
* roadmap simplified;
* Product Contract v1.0 prepared.

Remaining before Stage 0 can be marked complete:

* persist Stage 0 documents in repository;
* perform Stage 0 completion audit;
* verify documentation consistency;
* verify git status;
* create Stage 0 commit;
* push only after Product Owner approval;
* create Context Handoff for Stage 1.

No Stage 1 work may begin before this closeout is complete.

---

## 4. Product Contract

Canonical source:

`docs/product-contract.md`

Version:

`1.0`

Status:

`Scope Frozen`

The Product Contract is the single source of truth for CUMPAVIO V1 scope.

---

## 5. Frozen V1 Scope

### Market

Moldova only.

### Categories

* Smartphones
* Laptops

### Data sources

Minimum:

* 3 production-quality retailer sources

Target if feasibility permits:

* 5 production-quality retailer sources

Retailer names are not guaranteed until Data Feasibility review.

### Core public capabilities

* landing/home;
* search;
* categories;
* category filters;
* canonical products;
* exact product variants;
* multiple retailer offers;
* availability observations;
* freshness;
* product specifications;
* price history;
* historical price context;
* deterministic price intelligence;
* product comparison;
* outbound retailer navigation;
* Romanian;
* Russian;
* SEO;
* analytics.

### Core internal capabilities

* retailer health;
* crawl runs/failures;
* parser errors;
* stale listings;
* products;
* source listings;
* offers;
* matching review;
* unmatched/ambiguous listings;
* anomaly review;
* provenance investigation.

---

## 6. Explicitly Deferred / Post-MVP

* public user accounts;
* favorites;
* watched products;
* price alerts;
* notification preferences;
* English UI;
* AI shopping assistant;
* AI recommendations;
* AI matching;
* natural-language AI search;
* AI comparison explanations;
* TVs;
* Gaming;
* Headphones;
* Smartwatches;
* other retail categories;
* merchant accounts;
* affiliate management;
* advertising platform;
* B2B intelligence;
* native applications;
* browser extension.

---

## 7. Current Architecture

No production architecture has been implemented yet.

Frozen conceptual data path:

**Retailer
→ Source Listing / Observation
→ Normalization
→ Product Matching
→ Canonical Product Family
→ Canonical Product Variant
→ Offer
→ Price Observation
→ Price Intelligence
→ Public Experience**

Key rule:

Raw/source representations must remain sufficiently auditable and separate from canonical interpretation.

---

## 8. Technology Decisions

Planned direction:

### Web

* Next.js
* React
* TypeScript strict
* Tailwind CSS
* shadcn/ui
* Zod
* TanStack Query only where justified

### Platform / Data

* Supabase
* PostgreSQL
* Supabase Auth for internal/admin V1 authentication
* Supabase Storage where appropriate
* Row Level Security
* migrations

### Data Collection

* Python
* httpx
* BeautifulSoup/lxml
* Playwright only when necessary

### Search

* PostgreSQL-first

### Testing

* frontend/unit tests where useful
* pytest
* parser fixtures
* matching golden datasets
* Playwright E2E

### Deployment direction

* GitHub
* Vercel
* Supabase
* separate crawler/worker runtime

Exact implementation versions are not frozen until Stage 1.

---

## 9. Architecture Decisions

### ADR-level decisions already frozen

1. CUMPAVIO is not a marketplace.
2. Search never triggers synchronous retailer crawling.
3. Raw/source listings and canonical products are separate.
4. Product Family and Product Variant are distinct concepts.
5. False-positive matching is more dangerous than false-negative matching.
6. Low-confidence products are not auto-merged.
7. V1 matching is deterministic/fuzzy/manual, not LLM-based.
8. Price history is based on source-attributable observations.
9. Price anomalies must not silently corrupt historical metrics.
10. Price intelligence is deterministic and explainable.
11. Public Auth is excluded from V1.
12. AI is excluded from V1.
13. Brand/Product Design occurs before full public product implementation.
14. PostgreSQL search is used before considering a separate search engine.
15. Crawler runtime is separate from interactive web requests.

Future formal ADR files may reference these decisions, but must not change them without following Product Contract rules.

---

## 10. Data Sources

**Status:** Not researched in implementation yet.

Candidate research pool:

* Enter
* Darwin
* Bomba
* Ultra
* Cactus
* Maximum
* other relevant Moldova electronics retailers

No source is technically or legally guaranteed yet.

Stage 3 performs formal feasibility validation.

---

## 11. Database State

**Status:** Not started.

Database implementation belongs to Stage 2.

No schema has been created.

---

## 12. Connector State

**Status:** Not started.

Connector implementation begins only after Stage 2 and Stage 3 requirements are reached.

---

## 13. Matching State

**Status:** Concept frozen; implementation not started.

Frozen matching hierarchy:

1. EAN/GTIN;
2. manufacturer identifiers;
3. MPN/model identifiers;
4. normalized brand/model;
5. category-specific variant attributes;
6. deterministic rules;
7. constrained fuzzy matching;
8. manual review.

AI matching is Post-MVP.

---

## 14. Public Product State

**Status:** Not started.

No landing, search, product page or comparison UI has been implemented.

Brand and visual design remain unfrozen until Stage 6.

Previous visual/logo concepts are references only.

---

## 15. Data Quality State

**Status:** Requirements defined; implementation not started.

V1 requires:

* provenance;
* freshness;
* stale handling;
* parser monitoring;
* matching review;
* anomaly handling;
* auditability.

---

## 16. Testing State

**Status:** Not started.

Testing foundation begins Stage 1.

Future requirements include:

* lint;
* typecheck;
* production build;
* application tests;
* pytest;
* connector fixture tests;
* parser regression;
* matching golden dataset;
* price-intelligence tests;
* Playwright critical E2E.

---

## 17. Deployment State

**Status:** Not started.

Direction:

* Vercel — web;
* Supabase — database/platform;
* separate worker environment — data collection.

No production deployment exists.

---

## 18. Security State

**Status:** Requirements frozen; implementation not started.

Important future requirements:

* RLS;
* least privilege;
* server-only service credentials;
* internal admin authorization;
* safe outbound URLs;
* crawler SSRF protection;
* environment secret isolation;
* security launch review.

---

## 19. Legal / Data State

Stage 0 principles:

* technical accessibility is not treated as blanket permission;
* every retailer receives individual feasibility/restrictions review;
* robots and relevant terms are investigated;
* image provenance must be considered;
* CUMPAVIO must not imply retailer partnerships that do not exist;
* applicable Moldova privacy/e-commerce requirements must be reviewed before launch;
* final CUMPAVIO trademark/domain legal verification is required before public commercial launch.

No legal approval for any specific retailer source has been recorded yet.

---

## 20. Known Issues

Current known issues:

1. Specific V1 retailer list is not yet known.
2. Real identifier quality is not yet known.
3. Actual source-page/API structures are not yet known.
4. Crawl cadence cannot be finalized before store feasibility testing.
5. Product-image licensing/provenance strategy requires source-specific research.
6. Exact price-intelligence thresholds require real observation data and Stage 8 validation.

None of these justify expanding V1 scope.

---

## 21. Current Blockers

No Stage 0 product blocker remains.

Operational closeout still required:

* save documentation;
* audit;
* commit;
* optional approved push.

Stage 1 is intentionally blocked until Stage 0 closeout.

---

## 22. Completed Stages

None formally closed yet.

Stage 0 will move here only after completion audit and repository commit.

---

## 23. Last Completed Work

CUMPAVIO Product Contract v1.0 was defined and its V1 scope frozen in the Stage 0 conversation.

Major scope reductions:

* 2 categories instead of 6;
* minimum 3 production stores instead of broad retailer coverage;
* no public accounts;
* no alerts;
* no V1 AI;
* no opaque Deal Score;
* no native/mobile/browser extension scope.

---

## 24. Next Exact Step

Remain inside Stage 0.

Next actions:

1. create/persist `docs/product-contract.md`;
2. create/persist `docs/project-state.md`;
3. create/persist `docs/stages/stage-00.md`;
4. audit all three documents against each other;
5. verify no Stage 1 implementation has been introduced;
6. commit Stage 0 documentation;
7. request Product Owner approval before pushing;
8. prepare Stage 1 Context Handoff and new-chat prompt.

Do **not** scaffold Next.js or Supabase during this step.

---

## 25. Repository Status

At the time this initial Project State document is prepared:

**Repository engineering foundation:** Not started.

Stage 0 is permitted to create only the minimal Git/docs structure required to persist Stage 0 governance documentation.

Update this section after the Stage 0 repository audit.

---

## 26. Last Commit

Not yet created for Stage 0.

Replace after Stage 0 documentation commit with:

The Stage 0 documentation commit hash is recorded in the final Context Handoff after the commit is created.

---

## 27. Last Updated

2026-08-10

Update this file at the end of every Stage.
