# CUMPAVIO — Project State

**Last updated:** 2026-08-10
**Current Stage:** Stage 1 — Repository & Engineering Foundation
**Current status:** Stage 1 complete locally — push pending
**Production status:** Engineering foundation established; business implementation not started

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

### Stage 1 — Repository & Engineering Foundation

Current objective:

Establish a minimal, production-oriented and reproducible engineering foundation for CUMPAVIO without introducing Stage 2+ business implementation.

Implemented foundation:

- Next.js 16.3.0;
- React 19.2.8;
- TypeScript strict;
- Tailwind CSS 4;
- ESLint;
- App Router;
- `src/` structure;
- `@/*` import alias;
- Vitest;
- React Testing Library;
- GitHub Actions CI;
- environment-variable conventions;
- minimal application smoke page;
- developer setup documentation.

Stage 1 intentionally does not implement Supabase business schema, crawling, normalization, matching, search, product experience, price intelligence or Product Design.

Completion audit passed.

---

## 3. Current Status

Stage 1 implementation and completion audit are complete.

Implemented during Stage 1:

- Next.js web foundation;
- React application foundation;
- TypeScript strict mode;
- Tailwind CSS;
- ESLint;
- App Router;
- `src/` structure;
- `@/*` import alias;
- Vitest testing foundation;
- React Testing Library;
- GitHub Actions CI;
- environment-variable conventions;
- minimal smoke application;
- developer setup documentation;
- Stage 1 engineering documentation.

Validated successfully:

- `npm run lint`;
- `npm run typecheck`;
- `npm test`;
- `npm run build`;
- `git diff --check`;
- complete staged Stage 1 scope review.

Stage 1 engineering foundation commit:

`447335b feat: establish Stage 1 engineering foundation`

The final Stage 1 metadata synchronization commit is pending.

No Stage 2 implementation has been introduced.

Remote push is pending Product Owner confirmation.

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

The web engineering foundation is implemented.

Business/data production architecture is not implemented yet.

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

Implemented Stage 1 web-foundation versions are recorded in `docs/stages/stage-01.md`.

Future Stage-specific dependency versions remain unfrozen until they are actually introduced.

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

**Status:** Web testing foundation established.

Stage 1 includes:

- Vitest;
- React Testing Library;
- jsdom;
- React component smoke test.

Current test command:

`npm test`

Current result:

- 1 test file;
- 1 test;
- all passing.

Playwright E2E is intentionally deferred until real user flows exist.

Future testing requirements remain:

- pytest;
- connector fixture tests;
- parser regression tests;
- matching golden dataset;
- price-intelligence regression tests;
- Playwright critical E2E.

---

## 17. Deployment State

**Status:** Production deployment not started.

Current Stage 1 infrastructure:

- GitHub repository;
- GitHub Actions CI.

CI currently validates:

1. dependency installation;
2. lint;
3. typecheck;
4. tests;
5. production build.

Future deployment direction remains:

- Vercel — web;
- Supabase — database/platform;
- separate worker environment — data collection.

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

No blockers currently prevent Stage 1 completion.

Remaining Stage 1 closeout actions:

1. finalize Stage 1 documentation;
2. perform the completion audit;
3. run all final validations;
4. inspect the complete repository diff;
5. create the Stage 1 commit;
6. verify the working tree is clean after commit;
7. push only after Product Owner confirmation;
8. prepare the Russian Stage 1 → Stage 2 Context Handoff.

No Stage 2 implementation may begin before Stage 1 is closed.

---

## 22. Completed Stages

### Stage 0 — Product Contract & Scope Freeze

Completed on 2026-08-10.

Primary scope-freeze commit:

`387245f docs: freeze CUMPAVIO v1 product scope`

Stage 0 closeout commit:

`63fa505 docs: close Stage 0`

Final Stage 0 state commit:

`2ace7f2 docs: correct final Stage 0 state`

Stage 0 is synchronized to GitHub `main`.

### Stage 1 — Repository & Engineering Foundation

**Status:** Complete locally — push pending.

Stage 1 engineering foundation commit:

`447335b feat: establish Stage 1 engineering foundation`

Implemented:

- Next.js application foundation;
- React;
- TypeScript strict;
- Tailwind CSS;
- ESLint;
- App Router;
- test foundation;
- CI foundation;
- environment conventions;
- repository/developer documentation.

No Stage 2 implementation has been introduced.

---

## 23. Last Completed Work

Stage 1 — Repository & Engineering Foundation was completed locally.

Stage 1 commit:

`447335b feat: establish Stage 1 engineering foundation`

Final local validation status:

- lint passes;
- typecheck passes;
- Vitest passes;
- production build passes;
- `git diff --check` passes;
- working tree was clean after the Stage 1 commit.

No Stage 2 implementation has been introduced.

Remote push is pending Product Owner confirmation.

---

## 24. Next Exact Step

Complete the Stage 1 remote closeout:

1. commit final Stage 1 metadata synchronization;
2. verify clean working tree;
3. push `main` only after Product Owner confirmation;
4. verify local `main` matches `origin/main`;
5. prepare the Russian Stage 1 → Stage 2 Context Handoff;
6. prepare the Russian Stage 2 new-chat prompt.

Do not begin Stage 2 in this chat.

---

## 25. Repository Status

Repository:

`https://github.com/SuhihAlex/cumpavio.git`

Visibility:

`Public`

Branch:

`main`

Remote tracking:

`main → origin/main`

Stage 1 has been committed locally and has not yet been pushed to `origin/main`.

The repository now contains:

- Stage 0 documentation;
- Next.js application foundation;
- test foundation;
- GitHub Actions CI;
- Stage 1 documentation.

No Supabase business schema, crawler, retailer connector, matching implementation or public product implementation exists.

---

## 26. Last Commit

Current local Stage 1 engineering foundation commit:

`447335b0a8e48831a4ebe6014735aa11985bd7b5`

Commit:

`feat: establish Stage 1 engineering foundation`

The final Stage 1 metadata synchronization commit will follow before push.

---

## 27. Last Updated

2026-08-10

Update this file at the end of every Stage.
