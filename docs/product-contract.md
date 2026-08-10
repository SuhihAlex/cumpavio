# CUMPAVIO — Product Contract

**Version:** 1.0
**Status:** Scope Frozen
**Product:** CUMPAVIO
**Working tagline:** Know before you buy.
**Initial market:** Republic of Moldova
**Initial vertical:** Consumer electronics
**V1 categories:** Smartphones, Laptops
**Primary language:** Romanian
**Secondary language:** Russian
**Scope owner:** Product Owner
**Contract role:** Single source of truth for CUMPAVIO V1 scope

---

## 1. Product Summary

CUMPAVIO is a shopping intelligence platform for Moldova.

CUMPAVIO helps people researching consumer electronics:

1. identify the exact product and variant they are interested in;
2. discover which monitored local retailers currently offer it;
3. compare current observed prices;
4. understand how the observed price has changed over time;
5. compare the product with alternatives;
6. determine whether the current observed price appears low, typical, or high relative to recent verified CUMPAVIO data;
7. continue to a retailer to complete the purchase.

CUMPAVIO is not a marketplace and does not sell products directly.

The core product principle is:

**Data → Intelligence → Decision**

The core differentiation must come from:

* data quality;
* freshness;
* canonical product identity;
* accurate product-variant matching;
* auditable offer data;
* price history;
* explainable price intelligence;
* a clear search and comparison experience.

CUMPAVIO must not compete only on the claim that it displays prices from multiple stores.

---

## 2. Problem

Consumers in Moldova researching electronics may encounter:

* different prices for the same product across retailers;
* inconsistent product naming;
* unclear differences between product variants;
* promotional prices mixed with installment or cashback messaging;
* stale availability information;
* difficulty determining whether a sale price is actually attractive;
* difficulty comparing historical and current prices;
* repeated manual visits to multiple retailer websites;
* uncertainty about whether two listings actually represent the same exact product.

A generic price list does not fully solve this problem.

CUMPAVIO must transform fragmented retailer listings into trustworthy, normalized and explainable product information.

---

## 3. Target Market

### V1 geography

Republic of Moldova only.

### V1 vertical

Consumer electronics only.

### V1 categories

* Smartphones
* Laptops

No additional category is part of V1 unless this Product Contract is explicitly amended.

---

## 4. ICP / User Segments

### Primary segment

Consumers in Moldova actively researching a smartphone or laptop before purchase.

Typical characteristics:

* compare multiple retailers;
* care about price;
* want to understand product variants;
* research before buying;
* may delay a purchase if the current price appears unfavorable;
* want to avoid manually checking several stores.

### Secondary segment

Consumers comparing several competing products before choosing one.

Example:

* iPhone vs Samsung;
* MacBook vs Windows laptop;
* two configurations of the same laptop family.

### Not V1 ICP

CUMPAVIO V1 is not built primarily for:

* retailers;
* wholesalers;
* manufacturers;
* advertisers;
* professional procurement teams;
* B2B market analysts.

These may become future user segments.

---

## 5. Product Goals

CUMPAVIO V1 must:

1. provide a trustworthy canonical catalog for supported products;
2. aggregate current offers from multiple viable Moldova retailers;
3. prevent low-confidence product matches from silently corrupting comparisons;
4. show the freshness of offer data;
5. build auditable price history;
6. provide deterministic and explainable price intelligence;
7. let users compare products;
8. send users to the selected retailer to continue the purchase;
9. provide enough internal data tooling to diagnose crawler, matching and price-quality problems;
10. create a production foundation capable of expanding into additional electronics categories later without redesigning the core data architecture.

---

## 6. Non-Goals

CUMPAVIO V1 is not:

* a marketplace;
* an online store;
* a checkout system;
* a payment processor;
* a delivery platform;
* a merchant ERP;
* a merchant CMS;
* a social network;
* a review community;
* an advertising platform;
* an affiliate management platform;
* a universal Moldova shopping platform;
* a native iOS application;
* a native Android application;
* a browser extension;
* an AI-agent platform;
* a general-purpose product recommendation engine;
* a crawler for every Moldova retailer;
* a system covering every product category.

CUMPAVIO does not guarantee knowledge of every retailer or every market price in Moldova.

User-facing wording must refer to **monitored retailers**, **observed prices** and **CUMPAVIO price history** where appropriate.

---

## 7. Core User Journey

The primary V1 journey is:

**Search
→ Choose Canonical Product
→ Inspect Exact Variant
→ Compare Current Offers
→ Understand Price History
→ Understand Current Price Position
→ Optional Product Comparison
→ Choose Retailer
→ Outbound Store Visit**

The system must never require account creation to complete this journey.

Public user registration is not part of V1.

---

## 8. V1 Functional Scope

### Public product

V1 MUST contain:

* landing/home experience;
* product search;
* search results;
* category browsing;
* category-specific filters;
* canonical product families;
* exact product variants;
* canonical product pages;
* current monitored retailer offers;
* lowest current valid observed offer;
* current valid observed price range;
* observed availability;
* freshness information;
* normalized product specifications;
* per-store price observations;
* price history;
* observed historical minimum;
* recent price baseline;
* current price comparison against recent history;
* deterministic price status;
* product comparison;
* outbound retailer links;
* Romanian UI;
* Russian UI;
* SEO foundations;
* analytics foundations.

### Internal product

V1 MUST contain sufficient internal tooling for:

* retailer/data-source status;
* crawl runs;
* crawl failures;
* parser failures;
* stale listings;
* source listings;
* canonical products;
* current offers;
* unmatched listings;
* ambiguous matches;
* manual matching review;
* suspicious price observations;
* data-quality investigation.

### Explicitly excluded

V1 does NOT include:

* public accounts;
* favorites;
* watched products;
* price alerts;
* notification preferences;
* AI shopping assistant;
* AI recommendations;
* AI-generated comparisons;
* AI product matching;
* natural-language LLM search;
* public reviews;
* user comments;
* merchant accounts.

---

## 9. V1 Categories

Only two product categories are frozen for V1.

### 9.1 Smartphones

Canonical matching and comparison may use attributes including:

* manufacturer;
* product family/model;
* manufacturer model identifier;
* GTIN/EAN where available;
* storage capacity;
* RAM where relevant;
* color where the retailer/model semantics require exact separation;
* connectivity/version where relevant;
* other category-critical variant identifiers.

### 9.2 Laptops

Canonical matching and comparison may use attributes including:

* manufacturer;
* family/model;
* manufacturer part/model number;
* GTIN/EAN where available;
* processor;
* RAM;
* storage;
* GPU;
* screen size;
* display configuration where material;
* operating-system configuration where material;
* other manufacturer configuration identifiers.

Two products that differ on a variant-defining attribute must not automatically be treated as the same purchasable variant.

### Deferred categories

All other categories are Post-MVP, including:

* TVs;
* gaming hardware;
* headphones;
* smartwatches;
* tablets;
* appliances.

---

## 10. Store / Data Strategy

V1 requires:

**minimum: 3 production-quality retailer data sources**

Target if feasibility permits:

**5 production-quality retailer data sources**

Potential retailers may include businesses such as:

* Enter;
* Darwin;
* Bomba;
* Ultra;
* Cactus;
* Maximum;
* other relevant Moldova electronics retailers.

This list is a research pool, not a contractual integration guarantee.

No specific retailer becomes a mandatory V1 source until its Data Feasibility review succeeds.

### Source preference order

For each retailer, investigate in this order:

1. official permitted API/feed;
2. sitemap or other documented discovery mechanism;
3. structured data such as JSON-LD;
4. ordinary HTTP retrieval and parsing;
5. browser rendering only when technically necessary and acceptable.

### Every connector requires documented research

At minimum record:

* retailer;
* source domain;
* discovery method;
* data retrieval method;
* robots review;
* relevant terms review;
* rate-limit policy;
* fields available;
* identifier quality;
* image/data provenance considerations;
* browser-rendering requirement;
* technical risks;
* legal/data risks;
* review date.

No API, selector, identifier or private endpoint may be invented.

---

## 11. Search Scope

CUMPAVIO V1 search operates on stored CUMPAVIO data.

A user search must never trigger live retailer crawling.

### Search must support

* brand;
* model;
* product-family terms;
* important variant terms;
* common aliases;
* normalized retailer names where useful;
* Romanian and Russian search usage;
* product/model names that naturally remain in manufacturer language;
* basic typo tolerance where practical.

Examples:

* `iphone 17 pro`
* `iphone 17 pro 256`
* `macbook air m4`
* `asus tuf 4060`

### Smartphone filters

At minimum where data is available:

* brand;
* price;
* storage;
* availability.

Additional category-critical filters may be introduced only if based on reliable normalized attributes.

### Laptop filters

At minimum where data is available:

* brand;
* price;
* CPU family;
* RAM;
* storage;
* GPU;
* screen size;
* availability.

### Search architecture

V1 begins with PostgreSQL search capabilities.

Elasticsearch, OpenSearch, Meilisearch, Typesense or another separate search platform may not be introduced unless PostgreSQL is proven insufficient with measured evidence.

### Not V1

Natural-language AI shopping search is Post-MVP.

---

## 12. Product Page Scope

A canonical product page is one of the primary CUMPAVIO experiences.

It MUST provide, where data is available:

### Product identity

* product name;
* brand/manufacturer;
* product family;
* exact canonical variant;
* product image with acceptable provenance;
* key normalized specifications.

### Current offer information

* lowest current valid observed price;
* number of valid monitored offers;
* current valid observed price range;
* retailer name;
* observed availability;
* current comparable price;
* freshness/last checked information;
* outbound retailer CTA.

### Price intelligence

* price-history visualization;
* observed historical minimum;
* recent price baseline;
* current price versus recent baseline;
* deterministic price status;
* explanation of what the status means.

### Product actions

* add to product comparison;
* visit retailer.

### Trust information

Where appropriate, explain:

* that prices are observed from monitored retailers;
* when data was last checked;
* that retailer price and stock may change after observation;
* how CUMPAVIO determines the displayed price status.

### Not included

Product pages do not contain:

* community reviews;
* comments;
* social feeds;
* AI reviews;
* AI-generated product verdicts.

---

## 13. Comparison Scope

V1 includes side-by-side comparison of:

**maximum 3 products at one time.**

Products must belong to a compatible comparison category.

### Comparison includes

* canonical product identity;
* current lowest valid observed price;
* key normalized specifications;
* price-history indicator;
* major attribute differences;
* current price state where sufficient history exists.

Comparison should emphasize meaningful differences rather than displaying every raw field.

### Not V1

CUMPAVIO does not use an LLM to choose a winner.

It does not claim one product is objectively best for every user.

---

## 14. Price History Scope

Price history is a core V1 capability.

The fundamental historical record is a **price observation**, not only an aggregated daily minimum.

Price observations must remain attributable to their source.

At minimum each relevant observation must be traceable to:

* retailer;
* source listing;
* observed comparable price;
* availability where available;
* observation/check time;
* crawler/parser context required for auditability.

### Historical calculations

CUMPAVIO may calculate from validated observations:

* lowest observed current price;
* price range across monitored retailers;
* daily price statistics;
* recent rolling statistics;
* observed historical minimum.

### Historical wording

CUMPAVIO must not imply possession of price history before it actually began observing the product unless legitimate historical data has been imported from a documented, permitted and auditable source.

The preferred wording is equivalent to:

**Observed historical minimum in CUMPAVIO data**

rather than an unsupported claim about the absolute historical market minimum.

Invalid or rejected anomalies must not influence price-history intelligence.

---

## 15. Price Intelligence Scope

Price intelligence is deterministic in V1.

An LLM is not involved.

### V1 metrics

Where enough verified data exists, CUMPAVIO should provide:

* current lowest valid observed offer;
* current valid monitored price range;
* observed historical minimum;
* rolling 30-day price baseline;
* difference between the current lowest price and the recent baseline.

The preferred recent baseline is a robust statistic such as median rather than a value easily distorted by short-lived anomalies.

The exact production formula and minimum-data threshold must be documented and regression-tested before completion of Stage 8.

### V1 price states

The product may expose clear states such as:

* Low price
* Typical price
* High price
* Insufficient history

Equivalent Romanian and Russian labels will be defined during Product Design.

### Explainability requirement

A classification must be explainable with underlying values.

Example concept:

* current lowest: 18,999 MDL;
* 30-day median: 20,499 MDL;
* current price: 7.3% below recent median.

The interface must favor this explanation over an opaque numerical score.

### Forbidden V1 behavior

Do not display an unexplained `Deal Score 0–100`.

Do not make guaranteed claims such as:

* “This is the best possible time to buy.”
* “The price cannot go lower.”
* “Buy now.”

CUMPAVIO provides decision support, not future price prediction.

---

## 16. User / Auth Scope

### Public users

No public account is required or supported in V1.

The complete public product journey works anonymously.

### Internal users

Authentication may be used for authorized internal/admin functionality.

Supabase Auth is the preferred authentication direction for internal users unless Stage 2 identifies a strong technical reason otherwise.

### Post-MVP

Public authentication and customer accounts are Post-MVP.

---

## 17. Alerts Scope

Price alerts are not part of V1.

Deferred capabilities include:

* watched products;
* target-price alerts;
* price-drop alerts;
* notification preferences;
* email notifications;
* other delivery channels.

Alerts require additional account, scheduling, messaging, privacy and reliability infrastructure and must not delay core CUMPAVIO launch.

---

## 18. AI Scope

There are no user-facing LLM/AI capabilities in CUMPAVIO V1.

V1 does not include:

* AI shopping assistant;
* AI recommendation;
* AI product comparison explanation;
* AI buying verdict;
* AI natural-language product discovery;
* LLM-based product matching.

### Matching

V1 matching is based on:

1. GTIN/EAN;
2. manufacturer identifiers;
3. MPN/model identifiers;
4. normalized brand/model;
5. category-specific variant attributes;
6. deterministic rules;
7. constrained fuzzy matching;
8. manual review when confidence is insufficient.

### Future AI principle

If AI is introduced Post-MVP:

* AI must operate over structured CUMPAVIO data;
* AI must not become the source of truth for price, availability, product identity or specifications;
* architecture must not depend on one free LLM provider;
* provider abstraction should be introduced only when an actual AI capability is being implemented.

`free-llm-api-resources` may later be investigated as one possible provider discovery resource, but it is not part of the V1 architecture.

---

## 19. Admin / Data Quality Scope

V1 contains a minimal internal Data Operations Console.

It is not a general CMS.

### Required visibility

Authorized operators must be able to inspect:

* retailer/source status;
* crawl runs;
* crawler failures;
* parser failures;
* stale listings;
* source listings;
* canonical products and variants;
* current offers;
* unmatched listings;
* ambiguous/low-confidence matches;
* suspicious price observations.

### Required operations

The system must support the minimum human actions necessary to:

* review an ambiguous match;
* approve/reject/correct a match;
* investigate a suspicious price;
* approve/reject an anomaly when necessary;
* inspect provenance of a product offer;
* diagnose a stale or broken data source.

Manual decisions affecting product identity should be auditable.

---

## 20. Languages

### V1 UI languages

* Romanian — primary/default
* Russian — secondary

### Post-MVP

* English UI

The working brand tagline may remain:

**Know before you buy.**

### Search language

Search must not depend entirely on UI locale.

It should tolerate:

* manufacturer names;
* model names;
* common Romanian terminology;
* common Russian terminology;
* normalized aliases where justified.

Core product attributes should be represented structurally rather than relying on translated free text wherever practical.

---

## 21. SEO Requirements

Organic search is part of the V1 acquisition foundation.

V1 MUST include:

* crawlable public product pages;
* crawlable category pages;
* stable canonical URLs;
* appropriate page metadata;
* sitemap generation;
* robots directives;
* internal linking;
* locale-aware public-page strategy;
* standards-compliant structured product/offer data where applicable and supported by verified CUMPAVIO data.

### Data-quality gate

CUMPAVIO must not create indexable low-quality pages solely because a raw listing was crawled.

A public/indexable canonical product must satisfy defined data-quality requirements.

Pages with insufficient, duplicate, invalid or untrusted product data may be withheld from indexing.

Mass production of thin SEO pages is outside V1.

---

## 22. Data Freshness Requirements

CUMPAVIO does not promise real-time retailer data.

### Core freshness principle

Every currently displayed offer must have freshness metadata.

### V1 operational target

A normal active offer should generally have:

`last_checked_at <= 24 hours`

subject to the verified safe operating conditions of each retailer connector.

The exact crawl cadence may differ by retailer.

### Stale-data behavior

The system must distinguish:

* active/recent observations;
* stale observations;
* invalid/unavailable observations.

A stale offer must not indefinitely remain eligible to win the “lowest current price” position.

Concrete stale thresholds and ranking behavior must be documented and tested before production launch.

### User transparency

The UI should communicate freshness in understandable form such as:

* checked recently;
* checked X hours ago;
* availability last observed X hours ago.

The system must not imply guaranteed live stock when only a prior observation exists.

---

## 23. Product Matching Requirements

Product Matching is a critical CUMPAVIO subsystem.

### Fundamental entities

The architecture must distinguish at minimum:

**Source Listing
→ Canonical Product Family
→ Canonical Product Variant
→ Offer / Price Observation**

Raw retailer data must not become the canonical catalog by direct overwrite.

### Matching priority

1. GTIN/EAN;
2. manufacturer identifiers;
3. MPN/model identifiers;
4. normalized brand + model;
5. category-specific variant attributes;
6. deterministic rules;
7. constrained fuzzy matching;
8. manual review.

### Critical rule

**False-positive matching is more damaging than a false negative.**

Therefore:

**When uncertain, do not match automatically.**

Low-confidence listings must remain unmatched or enter review rather than being silently merged.

### Variant safety

A high textual similarity score must never override known contradictory variant-defining attributes.

Examples:

* different storage capacity;
* different RAM;
* different CPU;
* different GPU;
* materially different model/part numbers.

### Auditability

The system should retain enough information to understand:

* the original source representation;
* normalized representation;
* matching method;
* confidence where applicable;
* matching decision;
* review/manual override;
* relevant algorithm/version context.

Matching algorithms must be regression-tested against a curated golden dataset.

---

## 24. Security Requirements

V1 MUST follow least-privilege principles.

### Requirements

* Supabase Row Level Security where browser-accessible database paths require it;
* service-role credentials must never reach the browser;
* crawler secrets remain server/worker side;
* admin permissions are checked server-side;
* strict validation for external/input data;
* no arbitrary public user-controlled crawler destinations;
* protection against SSRF-style crawler misuse;
* safe handling of outbound retailer URLs;
* environment-specific secrets;
* database migrations under version control;
* dependencies reviewed and updated appropriately;
* no sensitive information written unnecessarily to logs;
* authorized internal operations protected from anonymous access.

Security review is launch-blocking.

---

## 25. Performance Requirements

Public user requests must use stored CUMPAVIO data.

### Hard rule

**A public page request or user search must never synchronously crawl a retailer.**

Crawler workloads run separately from interactive web requests.

### Product targets

The application should:

* be mobile-first;
* target good Core Web Vitals on representative production traffic;
* minimize blocking JavaScript;
* optimize product images;
* avoid unnecessary client-side data loading;
* use server rendering/static strategies where suitable;
* provide responsive search and filter interactions;
* paginate or otherwise constrain large result sets;
* avoid expensive unbounded database queries.

Performance regression checks are part of launch QA.

---

## 26. Accessibility Requirements

CUMPAVIO V1 targets WCAG 2.2 AA level practices for public user experiences.

At minimum:

* keyboard-accessible navigation and controls;
* visible focus states;
* semantic HTML;
* meaningful labels;
* appropriate form errors;
* sufficient contrast;
* alt text or appropriate decorative treatment for images;
* accessible comparison structures;
* chart information must not depend only on color;
* price-history information must have a non-visual textual interpretation;
* mobile layouts must remain usable without precision pointing.

Accessibility problems that block critical user flows are launch-blocking.

---

## 27. Analytics Requirements

V1 requires privacy-conscious product analytics.

At minimum track the funnel events necessary to evaluate product usefulness:

* `search_submitted`
* `search_zero_results`
* `search_result_selected`
* `product_viewed`
* `price_history_viewed`
* `compare_started`
* `compare_product_added`
* `retailer_offer_clicked`

The primary product funnel is:

**Search → Product → Offer → Retailer click**

Analytics must avoid collecting unnecessary personally identifiable information.

Analytics tooling/vendor selection is an implementation decision and must not expand V1 scope.

---

## 28. Architecture Direction

### High-level architecture

CUMPAVIO consists of separate concerns:

1. Public Web Application
2. Database / Data Platform
3. Data Collection Workers
4. Normalization
5. Matching
6. Offer / Price Observation Storage
7. Price Intelligence
8. Internal Data Operations

### Data pipeline

Conceptually:

**Retailer
→ Source Listing / Observation
→ Normalization
→ Product Matching
→ Canonical Product Variant
→ Offer
→ Price Observation
→ Price Intelligence
→ Public Experience**

### Raw-data principle

Source observations must remain sufficiently preserved and auditable to allow matching/parser corrections without pretending the earlier normalized interpretation was original retailer data.

### Separation principle

Crawler failures must not break public application availability.

Public application traffic must not control crawler targets.

### Search principle

PostgreSQL capabilities are the default V1 search foundation.

### Future-proofing

Architecture may allow future:

* additional categories;
* additional stores;
* public accounts;
* alerts;
* AI;
* B2B intelligence.

It must not build those features before they enter scope.

---

## 29. Technology Stack

The planned V1 technology direction is:

### Web

* Next.js
* React
* TypeScript strict
* Tailwind CSS
* shadcn/ui
* Zod
* TanStack Query only where server-state/client-interaction requirements justify it

Exact package versions are selected and frozen during Stage 1 based on supported current stable versions.

### Data / Platform

* Supabase
* PostgreSQL
* Supabase Auth for authorized internal access
* Supabase Storage only where appropriate and rights/provenance permit
* Row Level Security
* SQL migrations under version control

### Data Collection

* Python
* httpx
* BeautifulSoup and/or lxml
* Playwright only when ordinary HTTP retrieval is insufficient and use is appropriate

### Search

* PostgreSQL capabilities first

No dedicated external search engine without measured need.

### Testing

* TypeScript/frontend tests where useful
* pytest
* parser fixtures
* matching golden datasets
* Playwright E2E

---

## 30. Testing Strategy

CUMPAVIO requires product, application and data-quality testing.

### 30.1 Connector fixture tests

Each production connector must have representative stored fixtures where legally/technically appropriate for parser regression testing.

### 30.2 Parser regression tests

Tests must detect meaningful failures caused by retailer markup/data changes.

Silent mass corruption is unacceptable.

### 30.3 Matching golden dataset

Maintain examples representing:

* obvious true matches;
* exact identifier matches;
* aliases;
* variant differences;
* difficult negatives;
* ambiguous cases;
* known past matching failures.

### 30.4 Price intelligence tests

Every production price-intelligence formula must be deterministic and unit-tested.

### 30.5 Database tests

Cover relevant:

* constraints;
* migrations;
* data invariants;
* access policies/RLS.

### 30.6 Frontend tests

Focus on critical user-facing behavior rather than arbitrary coverage targets.

### 30.7 E2E

Critical production journey:

**Search
→ Product
→ Offers / Price History
→ Compare
→ Retailer outbound action**

### Launch checks

Relevant commands/checks must include:

* lint;
* typecheck;
* production build;
* automated tests;
* parser regression;
* matching regression;
* critical E2E;
* security/access review.

---

## 31. Deployment Strategy

### Web

Vercel.

### Database / Platform

Supabase.

### Crawling

Separate execution environment/worker appropriate for scheduled Python collection jobs.

Crawler jobs must not depend on Vercel request execution.

### Repository

GitHub is the source-code repository and change-history source.

### Environment separation

Secrets and configuration must be separated appropriately between local/development and production environments.

Preview/testing environments may be used where useful without creating unnecessary permanent infrastructure.

### Production principle

There is one intentional public V1 production launch after security and QA criteria are satisfied.

---

## 32. Legal / Data Considerations

CUMPAVIO must not assume that technical accessibility automatically grants unrestricted permission to collect, republish or commercialize data.

Every retailer/source requires an individual assessment.

### Source review

Review as applicable:

* robots directives;
* website terms;
* available official APIs/feeds;
* rate limitations;
* copyright/database considerations;
* product image usage;
* attribution requirements;
* identifiers and source provenance;
* restrictions on automated access.

CUMPAVIO must not intentionally bypass access controls or anti-bot restrictions to obtain data.

### Personal data

Public V1 intentionally minimizes personal-data processing because it contains no public user accounts.

Internal/admin and analytics data still require privacy-conscious handling.

Before launch, the service must review applicable Moldova personal-data requirements, including the regime under Law No. 195/2024, and any other then-current requirements.

### Electronic service

Before public launch, CUMPAVIO Terms, Privacy information and service model must be reviewed against applicable Moldova law, including relevant electronic-commerce requirements such as Law No. 284/2004 as then applicable.

### Images and content

Product-media usage must have acceptable provenance.

Do not assume every retailer image may automatically be copied and permanently redistributed.

### Brand

`CUMPAVIO` is approved as the working development brand.

Final trademark/domain/legal brand review is required before public commercial launch.

### Relationship wording

CUMPAVIO must not imply an official retailer partnership unless such a partnership actually exists.

### Legal disclaimer

This Product Contract defines engineering/product requirements and is not a substitute for professional legal advice.

---

## 33. Post-MVP

The following capabilities are explicitly deferred.

### Categories

* TVs
* Gaming
* Headphones
* Smartwatches
* Tablets
* Appliances
* Other Moldova retail categories

### Users

* public registration/login;
* profiles;
* favorites;
* watched products.

### Alerts

* price alerts;
* stock alerts;
* email notifications;
* notification preferences.

### AI

* natural-language shopping queries;
* AI shopping assistant;
* AI recommendations;
* AI comparison explanations;
* AI buying explanations;
* LLM matching fallback.

### Product

* community reviews;
* comments;
* social features;
* editorial buyer guides;
* broad deals portal.

### Business

* merchant accounts;
* merchant dashboards;
* paid placement;
* advertising platform;
* affiliate management system;
* B2B market-intelligence product.

### Platforms

* native mobile applications;
* browser extension.

Post-MVP items must not alter or delay V1 unless the Product Contract is explicitly amended.

---

## 34. Stage Roadmap

One Stage is executed in one separate ChatGPT chat.

Stages must not be mixed.

### Stage 0 — Product Contract & Scope Freeze

Define the product, architecture direction, scope boundaries and Definition of Done.

Only documentation/repository actions needed to persist Stage 0 are allowed.

No application scaffolding or production code.

### Stage 1 — Repository & Engineering Foundation

Establish application repository structure, Next.js engineering foundation, strict TypeScript, quality commands, environment conventions and testing foundation.

### Stage 2 — Supabase & Data Model Foundation

Establish database schema, migrations, core data entities, access model and Supabase integration.

### Stage 3 — Data Feasibility & First Store Proof

Research candidate retailers and build one production-quality data proof.

This is a major go/no-go checkpoint.

### Stage 4 — Multi-Store Ingestion & Observability

Reach at least three viable production sources and implement reliable crawl orchestration, retries, health and source observability.

### Stage 5 — Normalization & Product Matching

Implement canonical families/variants, normalization, deterministic matching, fuzzy safeguards, manual review and matching regression datasets.

### Stage 6 — Brand, UX Architecture & Design System

Finalize visual identity for V1, product UX architecture, responsive patterns and reusable design system before full public UI implementation.

### Stage 7 — Search & Product Experience

Implement home, category/search results and canonical product experience against real CUMPAVIO data.

### Stage 8 — Comparison & Price Intelligence

Implement comparison, price-history UX, verified price metrics and deterministic buying-decision support.

### Stage 9 — Data Console & Quality Operations

Complete internal data-quality operations for store health, matching, anomalies and diagnosis.

### Stage 10 — SEO, Analytics & Performance

Complete indexability rules, metadata, structured-data work, analytics funnel and performance optimization.

### Stage 11 — Security & QA

Perform security, access, RLS, connector, matching, regression, accessibility and E2E review.

### Stage 12 — Production & Launch Validation

Deploy production systems, validate real data, verify monitoring and complete V1 launch.

No Stage 13 is required for V1.

AI, accounts and alerts are not hidden additional V1 stages.

---

## 35. Definition of Done for CUMPAVIO V1

CUMPAVIO V1 is complete only when all conditions below are satisfied.

### Product

A real public user can complete:

**Search
→ Canonical Product
→ Current Offers
→ Price History
→ Price Understanding
→ Optional Compare
→ Retailer**

without an account.

### Categories

Both frozen categories are functional:

* Smartphones
* Laptops

### Data sources

At least **3 production-quality retailer sources** are operating with real data.

Mocks do not satisfy this requirement.

### Canonical data

The production system contains:

* source listings;
* canonical product families;
* exact canonical variants;
* offers;
* price observations;
* provenance/freshness metadata.

### Matching

The system includes:

* deterministic identifier matching;
* normalized/category-specific matching;
* constrained fuzzy handling;
* safe ambiguity handling;
* manual review;
* matching golden regression tests.

Known low-confidence matches are not silently auto-merged.

### Price data

The system supports:

* current valid monitored offers;
* current lowest valid observed price;
* current valid price range;
* availability observation;
* freshness;
* per-source price history;
* anomaly protection.

### Intelligence

Where data is sufficient:

* observed historical minimum works;
* rolling recent baseline works;
* current-vs-baseline calculation works;
* deterministic price status works;
* underlying values are explainable.

When data is insufficient, the product says so rather than fabricating confidence.

### Comparison

Users can compare up to three compatible products with meaningful normalized specifications and price context.

### Public UX

Romanian and Russian V1 experiences work across supported critical flows and responsive screen sizes.

### Data Console

An authorized operator can diagnose:

* broken/stale retailer collection;
* parser failure;
* unmatched listing;
* ambiguous matching;
* suspicious price;
* source provenance.

### SEO

Quality-approved public category/product pages have appropriate technical SEO foundations and low-quality raw catalog records are not blindly indexed.

### Analytics

The Search → Product → Retailer funnel can be measured.

### Security

Relevant authentication, authorization, RLS, secret handling and crawler-security review pass.

### Accessibility

Critical public journeys have no known launch-blocking accessibility issues.

### Performance

Critical public experiences meet the agreed production performance criteria and perform no synchronous retailer crawling.

### Testing

Relevant checks pass:

* lint;
* typecheck;
* production build;
* automated application tests;
* database/security tests where relevant;
* parser regression tests;
* matching regression tests;
* critical Playwright E2E.

### Production

Web application, database and crawler infrastructure operate with real production configuration and real permitted/approved data sources.

### Documentation

At completion:

* `docs/product-contract.md` remains current;
* `docs/project-state.md` reflects actual state;
* every completed Stage has a Stage document;
* known issues are recorded;
* architecture decisions are documented.

### Repository

Production launch requires:

* clean expected git status;
* all V1 work committed;
* main branch current;
* launch commit identifiable.

### Scope

No mandatory V1 capability remains unfinished.

Post-MVP features are not required for V1 completion.

---

## 36. Scope Freeze Rules

This Product Contract is the single source of truth for CUMPAVIO V1 scope.

### Rule 1

A feature not explicitly included in V1 scope is not part of CUMPAVIO V1.

### Rule 2

Any new product idea proposed after Scope Freeze is automatically classified as **Post-MVP** unless the Product Owner explicitly approves an amendment to this contract.

### Rule 3

Post-MVP work must not delay, complicate or change the frozen V1 implementation.

### Rule 4

Engineering may not quietly expand scope under labels such as:

* “future-proofing”;
* “while we are here”;
* “it will be useful later”;
* “small improvement”;
* “nice to have”.

Only infrastructure necessary for frozen V1 requirements may be built.

### Rule 5

No new retailer, category, user feature, AI feature, notification system or business model enters V1 automatically.

### Rule 6

An implementation detail may change without a Product Contract amendment if:

* it preserves product behavior;
* it does not expand V1;
* it improves correctness/security/maintainability;
* it is documented where architecturally material.

### Rule 7

A Product Contract amendment is required when changing:

* supported V1 categories;
* mandatory user journeys;
* required V1 capabilities;
* public account scope;
* AI scope;
* marketplace/payment scope;
* retailer minimum requirement;
* core matching policy;
* core product positioning.

### Rule 8

False-positive product matching remains a critical data defect.

The implementation must prefer an unmatched item to a confident-looking incorrect merge.

### Rule 9

One Stage is completed in one chat.

The next Stage starts in a new chat only after completion audit and Product Owner confirmation.

### Rule 10

At the end of every Stage:

1. audit delivered work;
2. execute all relevant checks;
3. update `docs/project-state.md`;
4. update the corresponding `docs/stages/stage-XX.md`;
5. record architecture decisions;
6. record known issues;
7. verify repository status;
8. commit the completed Stage;
9. push to `main` only when explicitly approved by the Product Owner;
10. prepare Context Handoff;
11. prepare the exact prompt for the next Stage chat.

### Stage 0 repository exception

Because Stage 1 owns the full engineering foundation, Stage 0 may perform only the minimum repository work necessary to persist governance documentation:

* initialize/create the Git repository if necessary;
* create `docs/`;
* create Stage 0 documentation;
* commit documentation.

Stage 0 must not:

* scaffold Next.js;
* install application dependencies;
* configure Supabase;
* implement a crawler;
* write production application code;
* implement UI.

---

# Frozen V1 Statement

CUMPAVIO V1 is a Moldova-first shopping intelligence product for **Smartphones and Laptops**, using real data from at least **three production-quality monitored retailers**, built around trustworthy canonical product matching, current offers, freshness, price history, transparent price intelligence and product comparison.

Public accounts, favorites, alerts, additional categories and all LLM/AI capabilities are Post-MVP.

**Scope Frozen — Version 1.0**
