# CUMPAVIO — Stage 02

## Supabase & Data Model Foundation

**Stage:** 2
**Status:** Complete — synchronized to GitHub main
**Started:** 2026-08-10
**Completed:** 2026-08-11
**Production deployment allowed:** No

---

## 1. Objective

Create a professional, minimal, reproducible and auditable Supabase/PostgreSQL data foundation for CUMPAVIO without implementing Stage 3+ functionality.

Stage 2 establishes the persistence and security contracts required by the frozen CUMPAVIO data architecture:

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

Stage 2 does not implement crawling, normalization, matching execution, search, price intelligence or public product UX.

---

## 2. Source of Truth

Canonical product scope:

`docs/product-contract.md`

Status:

`Scope Frozen`

Stage 2 preserves the frozen rules:

* Moldova only;
* Smartphones and Laptops only;
* raw/source data remains separate from canonical data;
* Product Family and Product Variant remain distinct;
* source data must be auditable;
* false-positive matching is worse than false-negative matching;
* uncertain records must not be silently auto-merged;
* price observations remain source-attributable;
* rejected/suspicious observations must not silently corrupt trusted history;
* interactive web requests never synchronously crawl retailers;
* crawler runtime remains separate from interactive web runtime;
* public Auth remains excluded from V1;
* AI remains excluded from V1.

---

## 3. Stage Scope

Stage 2 includes:

* Supabase CLI local-development foundation;
* PostgreSQL migration workflow;
* source/provenance schema;
* canonical product schema;
* Offer and Price Observation persistence;
* matching audit persistence;
* RLS/security boundary;
* TypeScript database type generation;
* database structural tests;
* database integrity tests;
* RLS/access tests;
* Stage 2 documentation.

---

## 4. Non-Goals

Stage 2 intentionally does not implement:

* retailer feasibility research;
* production retailer scraping;
* connectors;
* Playwright crawling;
* normalization engine;
* deterministic matching engine;
* fuzzy matching;
* manual matching UI;
* search;
* product pages;
* category UX;
* comparison UI;
* price intelligence calculations;
* Product Design;
* admin console;
* SEO;
* analytics product instrumentation;
* production deployment;
* public accounts;
* alerts;
* AI;
* Post-MVP functionality.

---

## 5. Initial Repository State

Stage 2 began from completed Stage 1.

Verified Stage 1 baseline:

`7430f1fe550ae0b45e71d85defbc388a661c2ce1`

Commit:

`docs: finalize Stage 1 state`

Stage 1 engineering commit:

`447335b0a8e48831a4ebe6014735aa11985bd7b5`

Commit:

`feat: establish Stage 1 engineering foundation`

At Stage 2 start:

* branch: `main`;
* local `main` matched `origin/main`;
* working tree was clean;
* Product Contract remained Scope Frozen;
* web engineering foundation was complete;
* no Supabase business schema existed.

---

## 6. Existing Web Foundation

Stage 1 foundation retained:

* Next.js `16.3.0`;
* React `19.2.8`;
* React DOM `19.2.8`;
* TypeScript `5.9.3`;
* TypeScript strict mode;
* Tailwind CSS `4.3.3`;
* ESLint `9.39.5`;
* App Router;
* `src/` structure;
* `@/*` alias;
* Turbopack;
* Vitest `4.1.10`;
* React Testing Library;
* jsdom;
* GitHub Actions CI.

Local tooling baseline:

* Node.js `22.16.0`;
* npm `10.9.2`;
* Git `2.50.0.windows.1`.

---

## 7. Supabase Tooling Decision

Supabase CLI was introduced as an exact dev dependency:

`supabase@2.113.0`

Reason:

Stage 2 requires a reproducible local migration/test/type-generation workflow.

The CLI version is pinned exactly rather than using a floating semver range.

Local development is used for Stage 2.

A hosted Supabase project is not required for this Stage.

---

## 8. Local Development Strategy

Chosen approach:

**local-first + migrations-first**

Primary workflow:

1. `npx supabase start`
2. modify migrations
3. `npx supabase db reset --debug`
4. `npx supabase test db`
5. `npm run db:types`

Permanent business data is not seeded during Stage 2.

Database tests create controlled transaction-scoped fixtures.

---

## 9. Local Port Isolation

Another local Supabase project already occupied the default Supabase port range.

CUMPAVIO therefore uses a dedicated local range:

* API: `55321`
* PostgreSQL: `55322`
* Studio: `55323`
* Mailpit: `55324`
* Analytics reserved: `55327`
* Pooler reserved: `55329`
* Shadow DB: `55320`

This avoids interference with other local projects.

---

## 10. Local Service Decisions

### Analytics

Disabled.

Reason:

Not required by Stage 2 and unnecessary for local database-foundation work.

### Realtime

Disabled.

Reason:

Realtime is not required by the CUMPAVIO Stage 2/V1 data foundation.

Repeated database-reset validation exposed a duplicate local Realtime tenant state:

`realtime-dev`

The failure occurred in Supabase Realtime seed initialization and was unrelated to CUMPAVIO migrations.

Disabling Realtime removed an unnecessary local dependency and restored reliable database resets.

### Seed

Database seed execution is disabled.

Reason:

Stage 2 has no justified permanent business seed data.

Tests create explicit fixtures instead.

---

## 11. Database Schema Boundary

Two business schemas are used.

### `public`

Contains canonical/public-safe business entities.

### `internal`

Contains retailer-source, crawl, source observation, provenance and matching-audit entities.

`internal` is intentionally not included in the public Data API schema exposure list.

This preserves the frozen source/canonical separation.

---

## 12. Core Tables

### Public

* `public.retailers`
* `public.product_families`
* `public.product_variants`
* `public.product_variant_identifiers`
* `public.offers`
* `public.price_observations`

### Internal

* `internal.retailer_sources`
* `internal.crawl_runs`
* `internal.source_listings`
* `internal.source_listing_observations`
* `internal.product_match_records`

---

## 13. Retailer / Source Model

`public.retailers`

Represents the retailer business entity.

`internal.retailer_sources`

Represents a concrete technical source belonging to a retailer.

A retailer may eventually have more than one technical source.

Source identity is therefore not collapsed into retailer identity.

---

## 14. Crawl Provenance

`internal.crawl_runs`

Stores audit metadata such as:

* retailer source;
* run status;
* trigger kind;
* crawler version;
* parser version;
* start/end timestamps;
* run statistics;
* error summary.

This does not implement a crawler.

It creates persistence required by future crawler stages.

---

## 15. Source Listing Model

`internal.source_listings`

Represents the retailer-side listing identity.

Important fields include:

* retailer source;
* source key;
* external ID where available;
* source URL;
* first seen;
* last seen;
* last checked;
* record status.

Source listings remain independent from canonical products.

---

## 16. Source Observation Model

`internal.source_listing_observations`

Represents source-attributable observations of a listing.

It supports:

* observation time;
* crawl-run attribution;
* parse status;
* parser version;
* raw title;
* raw price text;
* raw availability text;
* raw identifiers;
* extracted attributes;
* source payload;
* content hash;
* error details.

This preserves investigation context for future parsing, normalization and matching work.

---

## 17. Canonical Product Model

### Product Family

`public.product_families`

Represents canonical model identity.

Example concept:

`Apple iPhone 17 Pro`

### Product Variant

`public.product_variants`

Represents an exact variant identity belonging to a family.

Example concept:

`Apple iPhone 17 Pro / 256 GB / exact variant`

Family and Variant are intentionally separate.

---

## 18. Product Identifiers

`public.product_variant_identifiers`

Supports identifiers attached to canonical variants.

The schema intentionally does not globally enforce:

`unique(identifier_type, normalized_value)`

Reason:

Real retailer/manufacturer identifier semantics have not yet been proven.

A database uniqueness rule must not create unsafe canonical merging assumptions before Stage 3+ feasibility and matching work.

---

## 19. Matching Audit Model

`internal.product_match_records`

Stage 2 does not implement a matching engine.

It implements auditable persistence for future decisions:

* source listing;
* canonical variant;
* status;
* matching method;
* confidence;
* evidence;
* decision timestamp;
* supersession timestamp.

Supported statuses:

* pending;
* matched;
* ambiguous;
* rejected.

Confidence is constrained to `0..1`.

Matched records require:

* variant;
* method;
* decision timestamp.

The frozen matching philosophy remains:

**When uncertain, do not match automatically.**

---

## 20. Offer Model

`public.offers`

Represents current commercial state after correct canonical association.

Offer is not price history.

It contains current state such as:

* variant;
* retailer;
* source listing;
* current comparable price;
* currency;
* availability;
* record status;
* last observed time.

---

## 21. Price Observation Model

`public.price_observations`

Represents historical comparable-price observations.

Each record remains tied to:

* Offer;
* source listing observation;
* observed timestamp.

Price Observation is separate from Offer current state.

Comparable prices must be positive.

Currency codes must use three uppercase characters.

---

## 22. Price Quality Model

Quality states:

* `pending`
* `accepted`
* `suspicious`
* `rejected`

Suspicious/rejected records remain available for audit.

Only accepted price observations are exposed through the current public read boundary.

This prepares future price intelligence to avoid silently consuming rejected anomalies.

Stage 2 does not implement price-intelligence calculations.

---

## 23. Comparable Price Rule

Comparable product price must not be confused with:

* monthly installment amount;
* installment marketing value;
* cashback;
* discount amount;
* claimed savings;
* future promotional benefit.

The Stage 2 schema models comparable price independently.

---

## 24. Core Data Types

Primary IDs:

UUID using PostgreSQL-generated UUID defaults.

Time:

`timestamptz`

Money:

`numeric(12,2)`

Currency:

explicit three-character uppercase code.

JSON payloads:

`jsonb` with object-shape constraints where appropriate.

---

## 25. Freshness Decision

The schema records timestamps required for future freshness logic, including:

* first seen;
* last seen;
* last checked;
* observed time.

A permanent `is_stale` boolean is not introduced.

Staleness should later be derived from observed/check timestamps plus source-specific thresholds proven by real retailer feasibility and operational behavior.

---

## 26. RLS Strategy

RLS is enabled on all 11 Stage 2 business tables.

Verified result:

**11/11 tables have `rowsecurity = true`.**

Public roles:

* `anon`
* `authenticated`

receive explicit read privileges only where required.

No public INSERT/UPDATE/DELETE privileges are granted.

No public write RLS policies exist.

---

## 27. Public Read Boundary

Current read rules include:

* active retailers only;
* active product families only;
* active product variants only;
* identifiers belonging to active variants;
* active offers only;
* accepted price observations only.

`authenticated` currently receives the same public read boundary as `anon`.

This does not introduce public Auth.

---

## 28. Internal Security Boundary

For the `internal` schema, access is revoked from:

* `public`
* `anon`
* `authenticated`

This applies to:

* schema usage;
* tables;
* sequences;
* functions.

Default privileges for future postgres-owned internal objects are also hardened.

The helper trigger function:

`public.set_updated_at()`

has public execution revoked because it exists for database triggers rather than client RPC usage.

---

## 29. Auth Decision

Public Auth remains excluded from CUMPAVIO V1.

Stage 2 does not implement user/account tables or public authentication.

Supabase local Auth service may exist as part of the platform stack, but no CUMPAVIO Auth domain implementation was added.

Internal/admin authentication is deferred until a real internal/admin workflow requires it.

---

## 30. Environment Decision

`.env.example` remains the tracked environment template.

Real `.env*` files remain ignored except the approved example.

Stage 2 did not add application Supabase environment variables because no web runtime Supabase client integration is required yet.

Rules remain:

* browser-safe variables only may use `NEXT_PUBLIC_*`;
* database/service secrets remain server-only;
* secrets must never be committed;
* local CLI development credentials are not production credentials.

---

## 31. Migrations

Stage 2 created two migrations.

### Data foundation

`supabase/migrations/20260810191149_create_stage2_data_foundation.sql`

Contains:

* `internal` schema;
* enums;
* updated-at helper;
* source/provenance model;
* canonical model;
* matching audit model;
* offers;
* price observations;
* constraints;
* indexes;
* triggers.

### Security boundary

`supabase/migrations/20260810193139_establish_stage2_rls_boundaries.sql`

Contains:

* RLS activation;
* explicit grants/revokes;
* public read policies;
* internal isolation;
* default privilege hardening;
* function privilege hardening.

Both migrations successfully rebuild together from a fresh local database.

---

## 32. Database Type Generation

Generated TypeScript database contract:

`src/types/database.generated.ts`

Schemas generated:

* `public`
* `internal`

Reproducible command:

`npm run db:types`

Current script:

`supabase gen types typescript --local --schema public --schema internal > src/types/database.generated.ts`

Generated types must not be manually edited.

---

## 33. Database Tests

Location:

`supabase/tests/database/`

Suites:

* `001_stage2_structure.test.sql`
* `002_stage2_integrity.test.sql`
* `003_stage2_rls.test.sql`

Current result:

* Files: `3`
* Tests: `38`
* Result: `PASS`

---

## 34. Structural Tests

The structural suite verifies:

* `internal` schema existence;
* public tables;
* internal tables;
* primary keys;
* critical foreign keys;
* source/canonical relationships.

---

## 35. Integrity Tests

The integrity suite verifies rejection of invalid data including:

* zero comparable price;
* negative current offer price;
* lowercase/invalid currency code;
* matching confidence above `1`;
* invalid matched-record state;
* last-seen timestamp before first-seen timestamp;
* crawl finish before crawl start.

It also verifies that a valid accepted price observation can be written.

---

## 36. RLS / Access Tests

The RLS suite verifies actual role behavior.

For `anon`:

* only active retailer rows are visible;
* only accepted price observations are visible;
* INSERT into public data is denied;
* Offer UPDATE is denied;
* internal source data access is denied.

For `authenticated`:

* the same current public read boundary applies;
* public DELETE is denied;
* internal matching audit access is denied.

---

## 37. ESLint Integration Note

Supabase CLI creates temporary local runtime artifacts under:

`supabase/.temp/**`

These are CLI-generated artifacts rather than CUMPAVIO source code.

`eslint.config.mjs` now ignores:

`supabase/.temp/**`

This prevents ESLint from linting generated Supabase runtime bundles.

---

## 38. Commands Used

Important Stage 2 commands included:

* `npm install -D -E supabase@2.113.0`
* `npx supabase init`
* `npx supabase start`
* `npx supabase stop`
* `npx supabase status`
* `npx supabase migration new ...`
* `npx supabase migration list --local`
* `npx supabase db reset --debug`
* `npx supabase test db`
* `npx supabase gen types ...`
* `npm run db:types`
* `npm run lint`
* `npm run typecheck`
* `npm test`
* `npm run build`
* `git diff --check`
* `git status`

---

## 39. Validation Results

Final engineering validation completed successfully.

### Web / tooling

`npm run lint`

PASS.

`npm run typecheck`

PASS.

`npm test`

PASS.

Result:

* 1 test file;
* 1 test;
* all passing.

`npm run build`

PASS.

Next.js production build completes successfully.

### Database

`npx supabase test db`

PASS.

Result:

* 3 test files;
* 38 tests;
* all passing.

`npx supabase db reset --debug`

PASS.

Both Stage 2 migrations apply from a recreated local database.

`npm run db:types`

PASS.

Generated types rebuild from the reset database.

`npx supabase migration list --local`

Shows both Stage 2 migrations.

### Repository hygiene

`git diff --check`

PASS.

---

## 40. Issues Encountered

### Default Supabase port collision

Default local ports were already occupied by another Supabase project.

Resolution:

CUMPAVIO received dedicated `5532x` ports.

### Transient reset/service initialization failures

On this Windows/Docker environment, normal reset occasionally failed during local service initialization.

Running:

`npx supabase db reset --debug`

successfully applied the CUMPAVIO migrations and became the Stage 2 validation command.

### Realtime duplicate tenant state

Repeated reset validation produced:

`tenants_external_id_index`

for:

`realtime-dev`

This originated in local Supabase Realtime seed state, not CUMPAVIO SQL.

Resolution:

Realtime disabled because it is not required by Stage 2.

### Analytics local runtime

Analytics was unnecessary and caused avoidable local runtime complexity.

Resolution:

Analytics disabled.

### Type generation multi-schema invocation

The initial invocation using a single:

`--schema public,internal`

did not generate the intended database contract in this CLI environment.

Verified working invocation:

`--schema public --schema internal`

### ESLint temporary Supabase artifacts

ESLint initially traversed `supabase/.temp/**`.

Resolution:

CLI-generated temp directory explicitly ignored.

---

## 41. Files Created / Changed

Stage 2 includes changes to:

* `package.json`
* `package-lock.json`
* `eslint.config.mjs`
* `docs/project-state.md`
* `docs/stages/stage-02.md`
* `src/types/database.generated.ts`
* `supabase/.gitignore`
* `supabase/config.toml`
* `supabase/migrations/20260810191149_create_stage2_data_foundation.sql`
* `supabase/migrations/20260810193139_establish_stage2_rls_boundaries.sql`
* `supabase/tests/database/001_stage2_structure.test.sql`
* `supabase/tests/database/002_stage2_integrity.test.sql`
* `supabase/tests/database/003_stage2_rls.test.sql`

Temporary Supabase CLI files remain untracked according to Supabase local configuration.

---

## 42. Dependencies Added

### `supabase@2.113.0`

Type:

dev dependency.

Exact version pinned.

Reason:

* local Supabase lifecycle;
* migration management;
* database reset;
* pgTAP database testing;
* TypeScript database type generation.

No application Supabase JavaScript client was added because Stage 2 does not yet contain a web runtime Supabase use case.

---

## 43. Decisions Explicitly Deferred

The following remain deliberately unresolved until real-world requirements exist:

* production Supabase project creation/linking;
* application Supabase client integration;
* internal Auth implementation;
* Storage business integration;
* exact retailer set;
* crawl cadence;
* stale thresholds;
* parser implementation;
* normalization;
* matching engine;
* identifier uniqueness semantics beyond current safe schema;
* anomaly thresholds;
* price intelligence;
* search indexes for production query behavior.

---

## 44. Definition of Done — Stage 2

Stage 2 is complete when:

* [x] Supabase foundation defined
* [x] exact CLI dependency introduced
* [x] local development workflow established
* [x] migration workflow works
* [x] database schema exists in migrations
* [x] source/canonical layers are separate
* [x] Product Family and Product Variant are separate
* [x] provenance/auditability is represented
* [x] crawl/parser provenance persistence exists
* [x] matching decision audit persistence exists
* [x] matching engine is not pulled into Stage 2
* [x] Offer and Price Observation are separate
* [x] price-quality states exist
* [x] suspicious/rejected observations can remain auditable
* [x] RLS strategy implemented
* [x] public writes denied
* [x] internal schema isolated
* [x] public Auth not introduced
* [x] secrets remain untracked
* [x] generated TypeScript database type workflow exists
* [x] structural DB tests pass
* [x] integrity DB tests pass
* [x] RLS/access DB tests pass
* [x] `npm run lint` passes
* [x] `npm run typecheck` passes
* [x] `npm test` passes
* [x] `npm run build` passes
* [x] clean migration rebuild passes
* [x] generated types regenerate successfully
* [x] `git diff --check` passes
* [x] `docs/project-state.md` synchronized
* [x] `docs/stages/stage-02.md` synchronized
* [x] final complete repository diff reviewed
* [x] intended files staged
* [x] staged diff validation complete
* [x] Stage 2 commit created
* [x] working tree clean after commit
* [x] push approved by Product Owner
* [x] local `main` verified equal to `origin/main`
* [ ] Russian Stage 2 → Stage 3 Context Handoff prepared
* [ ] Russian Stage 3 new-chat prompt prepared

---

## 45. Completion Audit

### Product Contract

Preserved.

No Product Contract changes were made.

### Scope

Stage 2 implementation remained within Supabase/data-foundation scope.

No Stage 3+ retailer feasibility, connector or crawler implementation was introduced.

No public product implementation was introduced.

### Architecture

PASS.

Source and canonical layers are distinct.

Family and Variant are distinct.

Offer and Price Observation are distinct.

Provenance is preserved.

Matching decisions are auditable.

### Database

PASS.

Two migrations successfully rebuild the Stage 2 schema and security boundary.

### Security

PASS.

RLS is enabled on all 11 Stage 2 business tables.

Public write access is denied.

Internal schema client access is denied.

### Tests

PASS.

Database:

`38 / 38`

Application:

`1 / 1`

### Web Engineering

PASS.

* lint;
* typecheck;
* unit test;
* production build.

### Repository hygiene

PASS so far.

`git diff --check` passes.

Final staging/commit audit remains pending.

### Stage status

Engineering work is complete.

Administrative closeout remains:

* final diff inspection;
* staging;
* staged validation;
* commit;
* clean-tree verification;
* Product Owner-approved push;
* remote synchronization verification;
* Russian Context Handoff;
* Russian Stage 3 prompt.

---

## 46. Commit

Stage 2 engineering commit:

`cfa42185042e5b242f1edeebd93c7c97e385adb7`

Commit:

`feat: establish Stage 2 data foundation`

Engineering implementation and completion audit are complete.

Final metadata synchronization and remote push remain pending.

---

## 47. Push

Stage 2 was pushed to `origin/main`.

Verified final synchronized commit:

`bfe446304611dd9285afd233fb29edf6e966c323`

Local `HEAD` and `origin/main` were verified equal after push.

---

## 48. Handoff to Stage 3

Prepare after the Stage 2 commit and remote synchronization are complete.

The Russian Stage 2 → Stage 3 Context Handoff must include:

* final Stage 2 commit hash;
* verified `HEAD === origin/main`;
* clean working tree;
* Supabase CLI version;
* local port decisions;
* disabled local services;
* schema architecture;
* migration filenames;
* table model;
* RLS/security model;
* database test results;
* generated types workflow;
* known local development notes;
* explicit Stage 2 non-goals;
* Product Contract rules that remain frozen;
* exact Stage 3 objective.

Stage 3 must begin in a new chat.

Do not implement Stage 3 in this chat.
