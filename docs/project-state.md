# CUMPAVIO — Project State

**Last updated:** 2026-08-11
**Current Stage:** Stage 2 — Supabase & Data Model Foundation
**Current status:** Stage 2 complete — synchronized to GitHub main
**Production status:** Engineering and database foundations established; retailer feasibility and business ingestion not started

---

## 1. Project

**Name:** CUMPAVIO
**Working tagline:** Know before you buy.
**Market:** Moldova
**Vertical:** Consumer Electronics

CUMPAVIO is a shopping intelligence platform focused on:

**Data → Intelligence → Decision**

The Product Contract remains the single source of truth for V1 scope.

---

## 2. Current Stage

### Stage 2 — Supabase & Data Model Foundation

Objective:

Establish a professional, minimal, reproducible and auditable PostgreSQL/Supabase data foundation for CUMPAVIO without implementing retailer crawling, matching logic, public product flows or Stage 3+ functionality.

Stage 2 engineering implementation is complete locally.

Current work is limited to:

* documentation synchronization;
* completion audit;
* final repository inspection;
* Stage 2 commit;
* push after Product Owner confirmation;
* Russian Stage 2 → Stage 3 Context Handoff.

No Stage 3 implementation has started.

---

## 3. Current Status

Implemented during Stage 2:

* Supabase CLI local-development foundation;
* exact Supabase CLI dependency pin;
* isolated CUMPAVIO local Supabase port range;
* migrations-first database workflow;
* PostgreSQL business schema;
* `public` canonical/public data boundary;
* `internal` source/provenance boundary;
* retailer/source provenance foundation;
* crawl-run audit model;
* source listing model;
* immutable-source-observation foundation;
* canonical Product Family model;
* canonical Product Variant model;
* product identifier model;
* matching decision audit persistence;
* Offer current-state model;
* Price Observation history model;
* price-quality states;
* RLS boundaries;
* least-privilege anonymous/authenticated public access;
* internal schema isolation;
* pgTAP structural tests;
* pgTAP data-integrity tests;
* pgTAP RLS/access tests;
* generated TypeScript database types;
* reproducible `db:types` command;
* ESLint exclusion for generated Supabase CLI temporary runtime files.

Validated successfully:

* `npm run lint`;
* `npm run typecheck`;
* `npm test`;
* `npm run build`;
* `npx supabase test db`;
* `npx supabase db reset --debug`;
* `npm run db:types`;
* `npx supabase migration list --local`;
* `git diff --check`.

Database test result:

* 3 database test files;
* 38 database tests;
* all passing.

RLS validation:

* 11 Stage 2 business tables checked;
* RLS enabled on all 11 tables;
* anonymous/public read behavior tested;
* forbidden writes tested;
* `internal` access denial tested.

---

## 4. Product Contract

Canonical source:

`docs/product-contract.md`

Version:

`1.0`

Status:

`Scope Frozen`

The Product Contract is the single source of truth for CUMPAVIO V1 scope.

No Stage 2 decision changes the frozen product scope.

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

Retailer names are not guaranteed until formal Data Feasibility review.

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

Stage 2 implements the persistence foundation required by this architecture, but does not implement normalization, matching execution, retailer ingestion or price intelligence.

### Database schema boundary

`public`

Contains canonical and potentially public-facing business data.

`internal`

Contains retailer-source, crawl, raw/source observation, provenance and matching-audit data.

The `internal` schema is intentionally excluded from the public Data API exposure boundary.

### Core Stage 2 tables

Public:

* `public.retailers`
* `public.product_families`
* `public.product_variants`
* `public.product_variant_identifiers`
* `public.offers`
* `public.price_observations`

Internal:

* `internal.retailer_sources`
* `internal.crawl_runs`
* `internal.source_listings`
* `internal.source_listing_observations`
* `internal.product_match_records`

---

## 8. Data Model Decisions

### Product Family and Variant

Product Family and Product Variant remain separate entities.

A family represents the canonical product line/model.

A variant represents an exact purchasable configuration belonging to the family.

### Raw/source vs canonical

Retailer-source representations are not canonical product records.

Source data remains attributable and auditable separately from canonical interpretation.

### Matching

Stage 2 contains only matching decision persistence/audit infrastructure.

It does not implement a matching engine.

Future matching priority remains:

1. EAN/GTIN;
2. manufacturer identifiers;
3. MPN/model identifiers;
4. normalized brand/model;
5. category-specific variant attributes;
6. deterministic rules;
7. constrained fuzzy matching;
8. manual review.

False-positive matching remains more dangerous than false-negative matching.

Uncertain records must not be silently auto-merged.

### Offer vs Price Observation

`Offer` represents current retailer/variant state.

`Price Observation` represents historical price state.

Historical observations remain source-attributable.

### Price quality

Price observation quality states:

* `pending`
* `accepted`
* `suspicious`
* `rejected`

Only accepted observations are exposed through the current public RLS read policy.

Suspicious and rejected observations remain available for audit but must not silently enter trusted public history.

### Comparable price

Comparable product price is modeled separately from retailer marketing concepts such as:

* installment payment;
* monthly payment;
* cashback;
* claimed savings;
* promotional text.

### Money

Comparable prices use fixed-precision PostgreSQL numeric values.

Currency is explicit and constrained to uppercase three-character currency codes.

### Time

Database event timestamps use `timestamptz`.

### IDs

Business entities use UUID primary keys.

---

## 9. Security State

**Status:** Stage 2 database boundary implemented.

Implemented:

* RLS enabled on all Stage 2 business tables;
* anonymous/authenticated public roles receive read-only table privileges where explicitly required;
* no public INSERT/UPDATE/DELETE privileges;
* no public write RLS policies;
* inactive retailers/products/offers are excluded by public read policies where applicable;
* only accepted price observations are publicly readable;
* `internal` schema access revoked from `public`, `anon` and `authenticated`;
* default privileges for future postgres-owned internal objects are hardened;
* internal helper trigger function execution revoked from public client roles.

Public Auth remains outside V1.

Supabase Auth domain implementation has not been introduced.

Internal/admin Auth remains deferred until the product reaches the stage where an actual internal workflow requires it.

Server/service credentials must never be exposed through `NEXT_PUBLIC_*`.

---

## 10. Supabase Local Development

Supabase CLI:

`2.113.0`

Installed as an exact dev dependency.

Local development is migrations-first.

Primary local workflow:

1. `npx supabase start`
2. apply/rebuild from migrations with `npx supabase db reset --debug`
3. run database tests with `npx supabase test db`
4. regenerate TypeScript database types with `npm run db:types`

### Local CUMPAVIO port range

CUMPAVIO uses a dedicated local port range to avoid conflicts with other Supabase projects:

* API: `55321`
* PostgreSQL: `55322`
* Studio: `55323`
* Mailpit: `55324`
* Analytics reserved port: `55327`
* Pooler reserved port: `55329`
* Shadow database: `55320`

### Intentionally disabled local services

* Analytics
* Realtime

Realtime is not required by the Stage 2/V1 data foundation and was disabled after local Realtime tenant-state collisions were observed during repeated database reset validation.

Other CLI-managed services may also remain stopped when not required by the current Stage.

Local development credentials are development-only defaults and must never be used as production credentials.

---

## 11. Migration State

Stage 2 migrations:

`20260810191149_create_stage2_data_foundation.sql`

Contains:

* schemas;
* enums;
* shared timestamp helper;
* source/provenance tables;
* canonical catalog tables;
* matching audit persistence;
* offers;
* price observations;
* indexes;
* constraints;
* triggers.

`20260810193139_establish_stage2_rls_boundaries.sql`

Contains:

* RLS activation;
* explicit grants/revokes;
* public read policies;
* internal schema isolation;
* default privilege hardening;
* helper-function privilege hardening.

Both migrations have been successfully applied together from a clean local database using:

`npx supabase db reset --debug`

---

## 12. Generated Database Types

Generated TypeScript database contract:

`src/types/database.generated.ts`

Generated from both:

* `public`
* `internal`

Reproducible command:

`npm run db:types`

Generated files must not be manually edited.

The type contract is regenerated from the migration-built local database.

---

## 13. Testing State

### Web/application tests

Framework:

* Vitest;
* React Testing Library;
* jsdom.

Current application result:

* 1 test file;
* 1 test;
* all passing.

### Database tests

Location:

`supabase/tests/database/`

Current suites:

* `001_stage2_structure.test.sql`
* `002_stage2_integrity.test.sql`
* `003_stage2_rls.test.sql`

Current result:

* 3 files;
* 38 tests;
* all passing.

The database suites validate:

* schema/table existence;
* primary keys;
* critical foreign keys;
* price constraints;
* currency constraints;
* matching confidence constraints;
* matching decision consistency;
* source timestamp ordering;
* crawl timestamp ordering;
* valid accepted price insertion;
* public read filtering;
* forbidden public writes;
* internal schema isolation.

Future Stage-specific test suites remain deferred until corresponding functionality exists.

---

## 14. Technology Decisions

### Web

Implemented:

* Next.js 16.3.0
* React 19.2.8
* TypeScript strict
* Tailwind CSS 4
* ESLint
* App Router
* `src/`
* `@/*`
* Vitest
* React Testing Library

Not yet introduced because no current Stage requires them:

* shadcn/ui;
* Zod;
* TanStack Query;
* Playwright.

### Platform / Data

Implemented:

* Supabase local development;
* PostgreSQL;
* migrations;
* RLS;
* generated TypeScript DB types;
* pgTAP database tests.

Not yet implemented:

* hosted Supabase production project integration;
* application Supabase client;
* internal Auth;
* Storage business usage.

### Data Collection

Planned direction:

* Python
* httpx
* BeautifulSoup/lxml
* Playwright only when necessary

No crawler implementation exists yet.

### Search

PostgreSQL-first.

### Deployment direction

* GitHub
* Vercel
* Supabase
* separate crawler/worker runtime

No production deployment exists yet.

---

## 15. Data Sources

**Status:** Formal feasibility validation not started.

Candidate research pool:

* Enter
* Darwin
* Bomba
* Ultra
* Cactus
* Maximum
* other relevant Moldova electronics retailers

No retailer is technically or legally guaranteed yet.

Formal retailer feasibility belongs to Stage 3.

---

## 16. Connector State

**Status:** Not started.

No production retailer connector, parser or crawler exists.

No synchronous crawl can be triggered from a public user request.

Connector implementation must follow formal feasibility validation.

---

## 17. Matching State

**Status:** Database audit foundation implemented; matching execution not started.

Implemented:

* matching status model;
* matching method model;
* optional confidence;
* evidence payload;
* decision timestamp;
* supersession timestamp;
* canonical variant reference.

Not implemented:

* normalization engine;
* deterministic matching engine;
* fuzzy matching;
* manual review workflow;
* matching UI.

AI matching remains Post-MVP.

---

## 18. Public Product State

**Status:** Not started.

No Stage 2 work introduced:

* production landing;
* search;
* category experience;
* product page;
* price history UI;
* comparison UI;
* retailer outbound flow.

Brand and Product Design remain governed by later stages.

---

## 19. Data Quality State

**Status:** Database-level foundation implemented; real-world validation pending.

Implemented:

* provenance entities;
* source observations;
* crawl audit records;
* parser status;
* matching review states;
* observation quality states;
* suspicious/rejected price preservation;
* accepted-history access boundary;
* freshness timestamps.

Not yet validated against real retailer data:

* actual identifier quality;
* real anomaly thresholds;
* source-specific stale thresholds;
* parser behavior;
* crawl cadence;
* retailer-specific data quality.

These require Stage 3 and later data stages.

---

## 20. Environment / Secrets State

`.env.example` remains the tracked environment template.

`.env*` files are ignored except the approved example file.

Rules remain:

* browser-safe variables only may use `NEXT_PUBLIC_*`;
* service/database secrets must remain server-only;
* secrets must never be committed;
* local Supabase development credentials are not production credentials.

Stage 2 did not add application environment variables because no web runtime Supabase integration is currently required.

---

## 21. Known Local Development Notes

1. Another local Supabase project may use the default `5432x` ports, therefore CUMPAVIO uses the dedicated `5532x` range.
2. On this Windows/Docker environment, a normal `supabase db reset` occasionally failed during Supabase service initialization while the same migration reset succeeded with `--debug`.
3. Realtime produced duplicate local `realtime-dev` tenant-state errors during repeated reset validation and is intentionally disabled because Realtime is not required for this Stage.
4. Analytics is disabled because it is not required by the Stage 2 development workflow.
5. `supabase/.temp/**` contains CLI-generated local runtime artifacts and is excluded from ESLint.
6. Git may display LF → CRLF working-copy warnings on Windows; these are not validation failures.

None of these issues currently block Stage 2 completion.

---

## 22. Current Blockers

No blocker currently prevents Stage 2 completion.

Remaining Stage 2 closeout actions:

1. finalize `docs/stages/stage-02.md`;
2. synchronize this project-state document;
3. perform Stage 2 completion audit;
4. inspect final diff;
5. stage intended files;
6. run final staged validation;
7. create Stage 2 commit;
8. verify clean working tree;
9. push only after Product Owner confirmation;
10. verify `main` equals `origin/main`;
11. prepare Russian Stage 2 → Stage 3 Context Handoff;
12. prepare Russian Stage 3 new-chat prompt.

No Stage 3 implementation may begin before Stage 2 closeout.

---

## 23. Completed Stages

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

Completed and synchronized to GitHub `main`.

Engineering foundation commit:

`447335b feat: establish Stage 1 engineering foundation`

Final Stage 1 state commit:

`7430f1f docs: finalize Stage 1 state`

Implemented:

* Next.js foundation;
* React;
* TypeScript strict;
* Tailwind CSS;
* ESLint;
* App Router;
* test foundation;
* CI foundation;
* environment conventions;
* repository/developer documentation.

### Stage 2 — Supabase & Data Model Foundation

**Status:** Complete — synchronized to GitHub main.

Implemented:

* Supabase local foundation;
* PostgreSQL schema;
* migrations;
* provenance/source data model;
* canonical product model;
* matching audit persistence;
* offer/history model;
* RLS;
* database security boundary;
* pgTAP tests;
* generated TypeScript database types.

Stage 2 engineering commit:

`cfa42185042e5b242f1edeebd93c7c97e385adb7`

Commit:

`feat: establish Stage 2 data foundation`

---

## 24. Last Completed Work

Stage 2 — Supabase & Data Model Foundation is complete locally.

Final engineering validation:

* `npm run lint` — pass;
* `npm run typecheck` — pass;
* `npm test` — pass;
* `npm run build` — pass;
* `npx supabase test db` — 38/38 pass;
* RLS metadata check — 11/11 business tables enabled;
* `npx supabase db reset --debug` — pass;
* `npm run db:types` — pass;
* both Stage 2 migrations present and applied locally;
* `git diff --check` — pass.

Current work is Stage 2 documentation and repository closeout only.

---

## 25. Next Exact Step

Complete Stage 2 closeout:

1. finalize `docs/stages/stage-02.md`;
2. perform Stage 2 Definition of Done audit;
3. inspect the complete Stage 2 diff;
4. stage only intended Stage 2 files;
5. run staged validation;
6. create the Stage 2 commit;
7. verify clean working tree;
8. push only after Product Owner confirmation;
9. verify local `main` equals `origin/main`;
10. prepare the Russian Stage 2 → Stage 3 Context Handoff;
11. prepare the Russian Stage 3 new-chat prompt.

Do not implement Stage 3 in this chat.

---

## 26. Repository Status

Repository:

`https://github.com/SuhihAlex/cumpavio.git`

Visibility:

`Public`

Branch:

`main`

Remote tracking:

`main → origin/main`

Current remote baseline:

`7430f1f docs: finalize Stage 1 state`

Stage 2 changes currently exist locally and are not yet committed.

The repository now locally contains:

* Stage 0 documentation;
* Stage 1 web engineering foundation;
* GitHub Actions CI;
* Supabase local configuration;
* Stage 2 PostgreSQL migrations;
* Stage 2 database tests;
* generated TypeScript database types;
* Stage 2 documentation.

No crawler, retailer connector, matching engine, public product implementation or production deployment exists.

---

## 27. Last Commit

Current Stage 2 closeout commit:

`bfe446304611dd9285afd233fb29edf6e966c323`

Commit:

`docs: finalize Stage 2 state`

Stage 2 is synchronized to GitHub `main`.

---

## 28. Last Updated

2026-08-11

Update this file at the end of every Stage.
