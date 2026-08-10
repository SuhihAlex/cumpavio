# CUMPAVIO — Stage 00

## Product Contract & Scope Freeze

**Stage:** 0
**Status:** Complete
**Started:** 2026-08-10
**Completed:** 2026-08-10
**Production code allowed:** No

---

## 1. Objective

Define CUMPAVIO professionally before implementation.

Stage 0 must freeze:

* product positioning;
* target market;
* ICP;
* V1 capabilities;
* V1 categories;
* non-goals;
* retailer/data strategy;
* canonical product model;
* matching principles;
* price-history principles;
* price-intelligence boundaries;
* user/auth scope;
* alerts scope;
* AI scope;
* admin/data-quality scope;
* language scope;
* architecture direction;
* technology direction;
* testing direction;
* deployment direction;
* legal/data principles;
* roadmap;
* product Definition of Done;
* scope-freeze governance.

No production application implementation belongs to this Stage.

---

## 2. Inputs

Initial product concept:

CUMPAVIO is a Moldova-first shopping intelligence platform.

Initial idea:

**Search
→ Product
→ Offers
→ Compare
→ Price History
→ Decision
→ Store**

Long-term product principle:

**Data → Intelligence → Decision**

Initial vertical:

Electronics.

Initial candidate categories:

* Smartphones
* Laptops
* TVs
* Gaming
* Headphones
* Smartwatches

Initial retailer research pool:

* Enter
* Darwin
* Bomba
* Ultra
* Cactus
* Maximum
* other Moldova retailers.

Initial technology direction:

* Next.js;
* React;
* TypeScript;
* Tailwind CSS;
* shadcn/ui;
* Zod;
* Supabase/PostgreSQL;
* Python data collection;
* PostgreSQL-first search;
* Vercel;
* separate crawler runtime.

---

## 3. Product Review Findings

The initial direction was strong but V1 was too large.

If all candidate features had remained in V1 simultaneously, CUMPAVIO would effectively have required building:

* a retailer ingestion platform;
* canonical product catalog;
* matching engine;
* product information system;
* search engine;
* price-history platform;
* intelligence engine;
* consumer comparison product;
* account system;
* notifications platform;
* AI product;
* administration platform;
* SEO platform.

This would create high risk of prolonged infrastructure development before product validation.

The Stage 0 goal therefore became reduction rather than expansion.

---

## 4. Product Decisions

Frozen positioning:

CUMPAVIO is not a generic price comparison website.

CUMPAVIO V1 exists to help users:

1. identify an exact product;
2. understand which monitored stores offer it;
3. compare observed prices;
4. understand recent/historical price behavior;
5. compare products;
6. make a better-informed purchase decision.

Core differentiation:

* trustworthy data;
* canonical matching;
* freshness;
* price history;
* explainable price intelligence.

---

## 5. Scope Decisions

### Included

* home;
* search;
* categories;
* filters;
* canonical products;
* exact product variants;
* multiple-store offers;
* availability observations;
* freshness;
* specifications;
* price history;
* historical minimum;
* recent baseline;
* deterministic price status;
* comparison;
* outbound retailer links;
* internal data-quality console;
* SEO;
* analytics.

### Removed from V1

* public accounts;
* favorites;
* watched products;
* alerts;
* notifications;
* all user-facing AI;
* AI matching;
* additional electronics categories;
* native apps;
* browser extension;
* merchant tooling;
* B2B intelligence.

---

## 6. Categories Decision

Frozen V1 categories:

1. Smartphones
2. Laptops

Reason:

The categories provide useful but different matching difficulty.

Smartphones test:

* model identity;
* storage variants;
* colors;
* manufacturer identifiers.

Laptops test:

* configuration-heavy variants;
* CPU;
* RAM;
* storage;
* GPU;
* manufacturer part numbers.

If the canonical model succeeds for both, future electronics-category expansion becomes substantially safer.

All other categories are Post-MVP.

---

## 7. Store Strategy Decision

Do not freeze specific retailer names as mandatory before feasibility testing.

Frozen requirement:

* minimum 3 production-quality retailer data sources.

Target:

* 5 if technical/legal/data-quality feasibility permits.

Potential retailers remain a research pool only.

Every retailer requires individual feasibility analysis before connector implementation.

---

## 8. Canonical Data Decision

A crawler record is not automatically a canonical product.

Frozen conceptual architecture:

**Retailer
→ Source Listing
→ Normalization
→ Matching
→ Canonical Product Family
→ Canonical Product Variant
→ Offer
→ Price Observation**

Source data must remain sufficiently auditable to investigate later normalization or matching errors.

---

## 9. Matching Decisions

Frozen matching hierarchy:

1. GTIN/EAN
2. Manufacturer identifiers
3. MPN/model identifiers
4. Normalized brand + model
5. Category-specific variant attributes
6. Deterministic rules
7. Constrained fuzzy matching
8. Manual review

Critical rule:

**False positive > false negative in severity.**

When confidence is insufficient:

**do not automatically match.**

AI matching is Post-MVP.

---

## 10. Price Semantics Decision

CUMPAVIO must distinguish a comparable purchase price from unrelated marketing values.

Examples that must not silently become comparable full prices:

* monthly installment;
* loan payment;
* cashback amount;
* potential future benefit.

The comparable-price model must represent the public full purchase price in MDL under the documented V1 methodology.

Promotional/regular/previous price fields may remain separate when available.

The precise normalized price model will be defined during Data Model/Data Connector implementation without changing this principle.

---

## 11. Price History Decisions

Price history is V1 MUST.

History is derived from validated, source-attributable observations.

CUMPAVIO must not fabricate historical data.

Historical minimum wording must reflect CUMPAVIO-observed history unless legitimate imported historical data has documented provenance.

Rejected anomalies do not contribute to intelligence.

---

## 12. Price Intelligence Decisions

Price Intelligence remains in V1.

It must be:

* deterministic;
* explainable;
* reproducible;
* based on validated observations.

Expected V1 concepts:

* current lowest valid observed price;
* current monitored price range;
* observed historical minimum;
* rolling 30-day baseline;
* current price vs baseline;
* price state.

Preferred states:

* Low price
* Typical price
* High price
* Insufficient history

Opaque Deal Score 0–100 is Post-MVP.

No future price prediction is promised.

---

## 13. User / Auth Decision

Public accounts are removed from V1.

Anonymous users must be able to complete the entire core journey.

Auth may exist for internal/admin access only.

---

## 14. Alerts Decision

Price alerts are removed from V1.

Reason:

Alerts imply additional:

* account state;
* scheduling;
* notification delivery;
* retries;
* preferences;
* consent/privacy;
* unsubscribe lifecycle.

They do not justify delaying the core product.

---

## 15. AI Decision

No LLM functionality is part of V1.

This includes:

* shopping assistant;
* recommendations;
* AI product verdict;
* natural-language shopping assistant;
* AI comparisons;
* AI matching.

AI remains a future intelligence layer after real CUMPAVIO structured data exists.

---

## 16. Admin / Data Quality Decision

A minimal internal Data Operations Console is V1 MUST.

It exists to protect product trust, not to become a large CMS.

It must support diagnosis/review of:

* stores;
* crawl runs;
* parser failures;
* stale listings;
* source listings;
* canonical products;
* offers;
* unmatched listings;
* ambiguous matches;
* anomalies.

---

## 17. Language Decision

V1:

* Romanian — primary/default
* Russian — secondary

Post-MVP:

* English UI

Brand tagline may remain English.

Search must handle manufacturer terminology and relevant aliases independently of interface language.

---

## 18. Search Decision

V1 uses PostgreSQL capabilities first.

No separate search service may be introduced without measured necessity.

Search operates over stored CUMPAVIO data.

User search never performs live crawling.

Natural-language LLM search is Post-MVP.

---

## 19. Freshness Decision

CUMPAVIO does not claim real-time prices or availability without a true real-time source.

Every offer must include freshness metadata.

Normal active-offer target:

`last_checked_at <= 24h`

subject to source constraints.

Stale offers cannot remain indefinitely eligible as the current cheapest offer.

Exact stale thresholds will be validated before launch.

---

## 20. Data Provenance Decision

Offers and observations need enough provenance to investigate:

* incorrect prices;
* stale information;
* parser errors;
* duplicate listings;
* wrong matching.

Required concepts include:

* source;
* source URL/identifier where available;
* observation timestamp;
* last checked;
* matching context;
* relevant crawler/parser execution context.

---

## 21. Anomaly Decision

Price anomaly protection is V1 MUST.

Example risk:

A parser error turns:

`21,999 MDL`

into:

`2,199 MDL`

Without safeguards this could permanently corrupt the historical-low calculation.

V1 must therefore support deterministic anomaly safeguards and manual investigation of suspicious observations.

No ML anomaly system is required.

---

## 22. Product Comparison Decision

Comparison remains V1 MUST.

Limit:

**maximum 3 products**

Comparison is category-compatible and uses normalized important specifications.

No AI-generated winner is included.

---

## 23. Architecture Decisions

Frozen high-level principles:

1. Web and crawler runtime are separate concerns.
2. Interactive requests never perform synchronous crawling.
3. Raw/source data remains distinct from canonical data.
4. Canonical Product Family is distinct from Product Variant.
5. Matching decisions are auditable.
6. Price observations are source-attributable.
7. Historical intelligence ignores rejected anomalies.
8. Search begins in PostgreSQL.
9. Public accounts are not required.
10. V1 contains no LLM dependency.

---

## 24. Technology Decisions

Technology direction remains:

### Web

* Next.js
* React
* TypeScript strict
* Tailwind CSS
* shadcn/ui
* Zod
* TanStack Query where justified

### Data

* Supabase
* PostgreSQL
* Supabase Auth
* Supabase Storage where appropriate
* RLS
* migrations

### Crawling

* Python
* httpx
* BeautifulSoup/lxml
* Playwright only where required

### Testing

* frontend/application tests
* pytest
* parser fixtures
* matching regression
* Playwright E2E

### Deployment

* GitHub
* Vercel
* Supabase
* separate crawler/worker environment

Exact dependency versions belong to Stage 1.

---

## 25. Legal / Data Decisions

Technical accessibility does not equal automatic permission for unrestricted data use.

Every production retailer requires source-specific review.

Review includes as relevant:

* robots;
* terms;
* APIs/feeds;
* automation restrictions;
* rate policy;
* images;
* attribution;
* data provenance;
* privacy implications.

CUMPAVIO does not bypass access controls.

Applicable Moldova personal-data and electronic-commerce requirements must be reviewed before public launch.

Final trademark/domain review of `CUMPAVIO` remains a pre-launch requirement.

---

## 26. Risks Identified

Major risks:

### Product/data

* inaccurate product matching;
* variant collision;
* stale prices;
* parser changes;
* missing identifiers;
* inconsistent specifications.

### Technical

* retailer anti-bot systems;
* browser-heavy crawling;
* connector instability;
* crawler scaling;
* search quality degradation.

### Legal/data

* retailer-specific automation restrictions;
* product-media rights;
* changing terms;
* privacy requirements.

### Project

* scope creep;
* adding categories too early;
* premature AI;
* overbuilding admin infrastructure;
* implementing public UI before data feasibility is proven.

---

## 27. Risk Mitigations

* two categories only;
* three-store minimum;
* Store Feasibility checkpoint;
* raw/source preservation;
* confidence-safe matching;
* manual review;
* parser fixtures;
* matching golden dataset;
* anomaly safeguards;
* freshness visibility;
* PostgreSQL-first search;
* no V1 public Auth;
* no V1 alerts;
* no V1 AI;
* Product Contract scope freeze.

---

## 28. Roadmap Changes

Initial roadmap contained Stage 0–14.

Final V1 roadmap contains Stage 0–12.

Changes:

* Brand/Product Design moved before full public-product implementation.
* Public Accounts/Favorites/Alerts removed from V1.
* AI Stage removed from V1.
* Admin/Data Quality retained but narrowly scoped.
* Security/QA consolidated.
* Launch remains a finite production stage.

Final roadmap:

0. Product Contract & Scope Freeze
1. Repository & Engineering Foundation
2. Supabase & Data Model Foundation
3. Data Feasibility & First Store Proof
4. Multi-Store Ingestion & Observability
5. Normalization & Product Matching
6. Brand, UX Architecture & Design System
7. Search & Product Experience
8. Comparison & Price Intelligence
9. Data Console & Quality Operations
10. SEO, Analytics & Performance
11. Security & QA
12. Production & Launch Validation

---

## 29. Deliverables

Stage 0 deliverables:

* `docs/product-contract.md`
* `docs/project-state.md`
* `docs/stages/stage-00.md`

The Product Contract must contain all required frozen sections.

---

## 30. Validation Checklist

Before marking Stage 0 complete verify:

* [x] Product Summary defined
* [x] Problem defined
* [x] Target Market defined
* [x] ICP defined
* [x] Product Goals defined
* [x] Non-Goals defined
* [x] Core User Journey frozen
* [x] V1 Functional Scope frozen
* [x] V1 Categories frozen
* [x] Store/Data Strategy frozen
* [x] Search Scope frozen
* [x] Product Page Scope frozen
* [x] Comparison Scope frozen
* [x] Price History Scope frozen
* [x] Price Intelligence Scope frozen
* [x] User/Auth Scope frozen
* [x] Alerts Scope frozen
* [x] AI Scope frozen
* [x] Admin/Data Quality Scope frozen
* [x] Languages frozen
* [x] SEO requirements defined
* [x] Freshness requirements defined
* [x] Matching requirements defined
* [x] Security requirements defined
* [x] Performance requirements defined
* [x] Accessibility requirements defined
* [x] Analytics requirements defined
* [x] Architecture direction defined
* [x] Technology stack direction defined
* [x] Testing strategy defined
* [x] Deployment strategy defined
* [x] Legal/data considerations defined
* [x] Post-MVP defined
* [x] Stage roadmap frozen
* [x] V1 Definition of Done defined
* [x] Scope Freeze rules defined
* [x] Documents persisted in repository
* [x] Cross-document final audit performed
* [x] Git status verified
* [x] Stage 0 commit created
* [x] Push approved by Product Owner
* [x] Stage 1 Context Handoff prepared

---

## 31. Known Issues at Stage Closeout

Not blockers for Stage 0:

1. Production retailers are not yet selected.
2. Source feasibility is unknown until Stage 3.
3. Exact database schema is not designed.
4. Exact crawl frequency is not yet proven.
5. Exact price-state thresholds require implementation/testing.
6. Final brand identity remains unfrozen.
7. Product image sourcing strategy requires retailer/manufacturer-specific validation.

These are intentionally deferred to their designated Stages.

---

## 32. Definition of Done — Stage 0

Stage 0 is complete when:

1. Product Contract v1.0 is accepted.
2. Scope is explicitly frozen.
3. Project State exists.
4. Stage 00 documentation exists.
5. The documents are internally consistent.
6. No production application work has started.
7. Repository contains only the allowed Stage 0 documentation/foundation if initialized here.
8. Git status is understood and clean after commit.
9. Stage 0 documentation commit exists.
10. Product Owner approves push before pushing.
11. Context Handoff for Stage 1 is prepared.
12. The Stage 1 prompt is prepared for a new chat.

---

## 33. Completion Audit

**Product scope:** Approved
**Architecture direction:** Approved
**V1 categories:** Approved
**Non-goals:** Approved
**Post-MVP boundary:** Approved
**Roadmap:** Approved
**Product Contract:** Persisted
**Repository persistence:** Complete
**Git audit:** Complete
**Scope-freeze commit:** `387245f`
**Working tree after scope-freeze commit:** Clean
**Remote repository:** Confirmed as `SuhihAlex/cumpavio`
**Remote synchronization:** Complete
**Context Handoff:** Prepared

Stage 0 is complete.

All Stage 0 product, documentation, repository and remote synchronization requirements are satisfied.

Stage 1 must begin in a new chat.

No Stage 1 implementation was performed in this chat.

---

## 34. Git Commit

Primary scope-freeze commit:

`387245f docs: freeze CUMPAVIO v1 product scope`

Stage 0 closeout commit:

`63fa505 docs: close Stage 0`

Stage 0 handoff-state commit:

`3b71bda docs: finalize Stage 0 handoff state`

---

## 35. Handoff to Stage 01

Prepare only after Stage 0 completion audit.

The Stage 1 handoff must state clearly:

* Product Contract is authoritative;
* V1 scope is frozen;
* only Stage 1 may be executed;
* no Supabase schema, crawler or public-product implementation may be pulled forward;
* all engineering decisions must preserve the frozen CUMPAVIO product contract.

**Do not start Stage 1 inside this chat.**
