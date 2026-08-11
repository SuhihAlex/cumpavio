# CUMPAVIO — Stage 03

## Data Feasibility & First Store Proof

**Stage:** 3
**Status:** In Progress
**Started:** 2026-08-11
**Completed:** Pending
**Production deployment allowed:** No
**Scope boundary:** No Stage 4+ production ingestion implementation

---

## 1. Objective

Prove that CUMPAVIO can obtain sufficiently structured, attributable and operationally viable retailer data for the frozen V1 categories before building the production multi-store ingestion system.

Stage 3 must validate:

* retailer business fit;
* product discovery feasibility;
* ordinary HTTP accessibility;
* structured-data availability;
* source identifiers;
* manufacturer/article identifiers where available;
* variant attribute quality;
* comparable-price extraction;
* availability semantics;
* locale behavior;
* anti-bot constraints;
* source-specific legal/data-use considerations;
* whether browser rendering is actually required;
* whether at least three production-quality retailer candidates exist.

Stage 3 also includes one constrained First Store Proof after retailer feasibility is established.

The First Store Proof is not the Stage 4 production crawler.

---

## 2. Source of Truth

Canonical product scope:

`docs/product-contract.md`

Status:

`Scope Frozen`

Stage 3 preserves the frozen V1 boundaries:

* Republic of Moldova only;
* Smartphones and Laptops only;
* Romanian primary/default locale;
* Russian secondary locale;
* minimum 3 production-quality retailer sources;
* target 5 only if feasibility and quality justify them;
* no AI;
* no public Auth;
* no additional product categories;
* no live retailer crawling from interactive web requests;
* raw/source data remains separate from canonical data;
* uncertain product matches must not be silently merged;
* source observations must remain auditable;
* rejected/suspicious price observations must not pollute trusted history.

---

## 3. Stage Scope

Stage 3 includes:

* retailer candidate review;
* robots policy inspection;
* sitemap discovery inspection;
* ordinary HTTP product-page sampling;
* structured-data inspection;
* source identifier analysis;
* variant evidence analysis;
* comparable-price semantics validation;
* availability semantics validation;
* locale duplication analysis;
* anti-bot/accessibility assessment;
* source-specific legal/data-use review;
* technical source classification;
* one safe First Store Proof;
* preliminary source strategy for Stage 4;
* Stage 3 documentation and completion audit.

---

## 4. Non-Goals

Stage 3 intentionally does not implement:

* production multi-store crawling;
* production crawl scheduling;
* production retry orchestration;
* browser-fingerprinting bypasses;
* anti-bot circumvention;
* hidden/internal retailer API exploitation;
* normalization engine;
* deterministic product matching engine;
* fuzzy matching;
* manual matching UI;
* canonical catalog population at scale;
* price intelligence;
* public search;
* product pages;
* comparison UI;
* Product Design;
* Data Operations Console;
* production deployment;
* additional V1 categories;
* AI;
* Post-MVP functionality.

Stage 4+ work must not be pulled into Stage 3.

---

## 5. Initial Repository State

Stage 3 began from completed and synchronized Stage 2.

Verified Stage 2 final HEAD:

`53f18b8ccac020d3aeb36f6a03785bc79c0c02b6`

Commit:

`docs: synchronize final Stage 2 state`

At Stage 3 start:

* branch: `main`;
* local `HEAD` matched `origin/main`;
* working tree was clean;
* Product Contract remained Scope Frozen;
* Stage 2 database foundation was complete;
* no production retailer connector existed;
* no production crawler existed;
* no normalization or product matching execution existed.

---

## 6. Retailer Candidate Strategy

The frozen Product Contract does not mandate specific retailers before feasibility testing.

Initial research pool:

* Enter;
* Darwin;
* Bomba;
* Ultra;
* Cactus;
* Maximum;
* other relevant Moldova retailers.

Stage 3 priority:

1. prove at least 3 strong V1 candidates;
2. stop unnecessary retailer research once the minimum is safely satisfied;
3. keep additional candidates as fallbacks unless additional research provides clear value.

Current evaluated retailers:

* Enter;
* Darwin;
* Bomba;
* Ultra.

---

## 7. Source Preference Principle

Preferred source hierarchy remains:

1. official permitted API/feed;
2. sitemap/documented discovery;
3. structured data such as JSON-LD;
4. ordinary HTTP retrieval/parsing;
5. browser rendering only where required and appropriate.

Technical accessibility does not equal unrestricted permission for commercial data use.

CUMPAVIO does not bypass access controls or anti-bot restrictions.

---

## 8. Enter — Feasibility Findings

### Business Fit

Enter supports both frozen V1 categories:

* Smartphones;
* Laptops.

### Robots

`https://enter.online/robots.txt`

Observed:

* HTTP `200`;
* public robots file available;
* no blanket `Disallow: /`;
* search/query and multiple internal-style paths are restricted;
* `/json/` is restricted;
* `/parsers/` is restricted;
* official sitemap is declared.

CUMPAVIO must not use restricted internal-style paths.

### Discovery

Official sitemap:

`https://enter.online/sitemap.xml`

Observed:

* sitemap index;
* category sitemap;
* multiple product sitemap shards;
* product shards contain large product URL sets;
* `lastmod` is widely available.

A sampled product shard contained:

* 25,000 URLs;
* 25,000 `lastmod` values;
* both Smartphones and Laptops.

`lastmod` is treated only as an incremental crawl-priority hint.

It is not a price observation timestamp and is not proof that price or availability changed.

### Product Access

Sampled laptop and smartphone product pages returned:

* HTTP `200`;
* server-rendered HTML;
* Product JSON-LD;
* comparable price;
* MDL currency;
* structured availability.

Playwright was not required for the tested product flow.

### Structured Data

Sampled Product JSON-LD included:

* product name;
* brand;
* price;
* price currency;
* availability;
* seller;
* images;
* price validity metadata.

GTIN/EAN was not present in sampled products.

### Identifier Findings

A retailer-side visible/source code was found in page data.

Example source identifier form:

`00-01191203-001`

The same identifier appeared in retailer analytics data as `item_id`.

This is treated as a retailer/source identifier.

It must not be interpreted as GTIN/EAN or manufacturer MPN without separate evidence.

Enter JSON-LD was observed duplicating internal numeric values into both `sku` and `mpn`.

Therefore Enter JSON-LD `mpn` is not trusted as a manufacturer MPN by default.

### Variant Quality

Useful matching signals exist in product titles and primary product content, including:

* manufacturer;
* model tokens;
* storage;
* RAM;
* processor/configuration;
* color;
* SIM configuration where applicable.

### Price Semantics

Enter may expose multiple monetary values on the same page:

* current selling price;
* old/promotional price;
* cashback;
* installments/credit values.

Product JSON-LD `Offer.price` produced a clear comparable full purchase price in sampled products.

Installment and cashback values must never be silently interpreted as comparable purchase price.

### Availability

Sampled structured availability included:

* `InStock`;
* `OutOfStock`.

Availability remains source-attributable and must be normalized later.

### Legal / Data Use

No public blanket permission for automated commercial catalog redistribution was established during Stage 3 research.

Technical accessibility and robots rules are not treated as a commercial-use license.

Retailer-hosted product images must not be assumed reusable or rehostable without appropriate provenance/permission.

### Preliminary Classification

**Approved with constraints**

Technical feasibility is strong enough for V1 consideration.

Final production-source approval still requires source-specific operational and legal/data-use handling.

---

## 9. Darwin — Feasibility Findings

### Business Fit

Darwin supports both frozen V1 categories:

* Smartphones;
* Laptops.

### Robots

Tested locations:

* `https://darwin.md/robots.txt`;
* `https://www.darwin.md/robots.txt`.

Observed:

* standard robots path returned HTTP `404`;
* `www` resolved to the primary host and also resulted in `404`.

Current Stage 3 interpretation:

**robots policy not published/found at the standard location**

This is neither blanket permission nor blanket prohibition.

### Discovery

Official sitemap:

`https://darwin.md/sitemap.xml`

Observed:

* HTTP `200`;
* sitemap index;
* multiple child sitemaps;
* dedicated product sitemap shards.

A sampled product shard contained:

* 25,000 URLs;
* 25,000 `lastmod` values;
* both V1-category signals.

Romanian and `/ru/` URLs may represent localized versions of the same retailer listing.

Production discovery must avoid treating locale representations as distinct physical products without evidence.

### Product Access

Sampled current laptop and smartphone pages returned:

* HTTP `200`;
* server HTML;
* Product JSON-LD;
* structured price;
* MDL currency;
* structured availability.

Playwright was not required for the tested product flow.

### Structured Data

Sampled Product JSON-LD contained:

* product name;
* brand;
* price;
* price currency;
* availability;
* seller;
* price validity metadata.

GTIN/EAN was not found in the tested products.

### Identifier Findings

Sampled Darwin JSON-LD:

Laptop:

* `sku = 171305`;
* `mpn = 171305`.

Smartphone:

* `sku = 164805`;
* `mpn = 164805`.

The same numeric values also appeared as the underlying product key in server-rendered application data.

Stage 3 interpretation:

* the numeric value is a useful Darwin internal/source product identifier;
* Darwin JSON-LD `mpn` must not be trusted as manufacturer MPN when it simply duplicates the retailer internal ID.

An unscoped first `item_id` match in the full HTML was proven to belong to recommended products rather than the primary product.

Therefore full-page string search is not a safe source of current-product identity.

### Variant Quality

Primary product content contained strong configuration evidence.

Laptop sample included:

* Lenovo IdeaPad Slim 3 15AMN8;
* Ryzen 5 7520U;
* 16 GB RAM;
* 512 GB storage.

Smartphone sample included:

* Samsung Galaxy S25 FE;
* S731 model token;
* 8 GB;
* 256 GB;
* Dual SIM.

### Price / Availability

Sampled Product JSON-LD exposed clear full prices in MDL and `InStock` availability.

### Legal / Data Use

No public blanket permission for automated commercial catalog reuse was established during Stage 3 research.

Technical accessibility does not establish a redistribution license.

Image rights/provenance remain source-specific and unresolved.

### Preliminary Classification

**Approved with constraints**

Technical feasibility is strong enough for V1 consideration.

---

## 10. Bomba — Feasibility Findings

### Business Fit

Bomba is relevant to both V1 categories.

### Robots

`https://bomba.md/robots.txt`

Observed:

* HTTP `200`;
* Cloudflare present;
* general `Allow: /`;
* explicit restrictions for cart/order/user/admin/search paths;
* search/filter/sort/tracking query restrictions;
* official sitemap declared.

The robots policy also contains rules for specific AI and crawler user agents.

Those rules are not automatically equivalent to the policy for a future CUMPAVIO crawler identity.

### Sitemap Access

Declared sitemap:

`https://bomba.md/sitemap.xml`

Ordinary PowerShell HTTP access returned:

`403 Forbidden`

Independent browser-oriented access also exposed verification/challenge behavior during research.

### General HTTP Access

The same ordinary HTTP client was tested against:

* homepage;
* smartphone/tablet category;
* laptop category.

All returned:

`403 Forbidden`

### Browser Access

The site was opened manually in a normal user browser.

Observed:

* site opened normally;
* no visible CAPTCHA;
* no visible blocking challenge.

### Interpretation

Bomba currently differentiates browser traffic from the tested anonymous non-browser HTTP client.

Potential browser-based collection may be technically possible, but Stage 3 does not treat browser rendering as automatically justified.

No anti-bot bypass or header/cookie evasion was attempted.

Because Enter, Darwin and Ultra provide simpler source paths, spending V1 complexity on Bomba is not currently justified.

### Preliminary Classification

**Research further / fallback candidate**

Reasons:

* ordinary anonymous HTTP feasibility failed;
* anti-bot/operational risk is materially higher;
* browser rendering may be required;
* three simpler candidate sources can satisfy the V1 minimum.

---

## 11. Ultra — Feasibility Findings

### Business Fit

Ultra supports both frozen V1 categories:

* Smartphones;
* Laptops.

### Robots

`https://ultra.md/robots.txt`

Observed:

* HTTP `200`;
* nginx;
* no blanket `Disallow: /`;
* search, cart, favorites and compare are restricted;
* filter/sort/query patterns are restricted;
* official sitemap is declared.

### Sitemap Structure

Root sitemap:

`https://ultra.md/sitemap.xml`

Observed:

* HTTP `200`;
* sitemap index;
* Romanian sitemap;
* Russian sitemap.

Romanian sitemap:

`https://ultra.md/sitemap/sitemap-ro.xml`

contains dedicated child maps including:

* static;
* promos;
* filters;
* categories;
* brands;
* products.

Product sitemap:

`https://ultra.md/sitemap/products-ro.xml`

Observed:

* HTTP `200`;
* `urlset`;
* 40,752 product URLs;
* 40,752 `lastmod` values.

Both V1-category signals are strongly represented.

### `lastmod` Interpretation

Many sampled product records shared the same recent `lastmod`.

Therefore Ultra sitemap `lastmod` is treated as a discovery/incremental-crawl hint only.

It is not interpreted as:

* price observation time;
* availability observation time;
* proof of an individual product update.

### Product Access

Sampled product pages returned:

* HTTP `200`;
* server-rendered HTML;
* Product JSON-LD;
* product identity;
* comparable price;
* MDL currency;
* product/article codes.

Playwright was not required for the tested product flow.

### Identifier Quality

Ultra provides unusually strong identifier semantics.

Sample laptop:

* `Cod produs: 204551`;
* `Articol: 82XQ007MRK`;
* JSON-LD `sku = 204551`;
* JSON-LD `mpn = 82XQ007MRK`.

Sample iPhone:

* `Cod produs: 145518`;
* `Articol: MPUF3RX/A`;
* JSON-LD `sku = 145518`;
* JSON-LD `mpn = MPUF3RX/A`.

Available Lenovo sample:

* `Cod produs: 262576`;
* `Articol: 83JN0047RK`.

Stage 3 interpretation:

* `Cod produs` is a strong retailer/source product identifier;
* `Articol` is a strong manufacturer/article matching signal;
* identifier provenance remains tied to Ultra;
* canonical matching must still avoid assuming global uniqueness without validation.

### Variant Extraction Finding

A full-page regex search produced false-positive variant evidence.

Example:

An iPhone 14 128 GB page also contained `512 GB` elsewhere in the HTML due to unrelated page content/recommendations.

Therefore future parsing must scope variant extraction.

Preferred hierarchy:

1. Product JSON-LD where semantically reliable;
2. primary product block;
3. scoped specifications;
4. other HTML only as controlled fallback.

Whole-document substring matching is not acceptable for canonical variant extraction.

### Price Consistency

Sampled visible product prices matched JSON-LD prices.

Examples:

* Lenovo sample: `7 490 lei` ↔ JSON-LD `7490`;
* iPhone sample: `11 999 lei` ↔ JSON-LD `11999`;
* available Lenovo sample: `29 990 lei` ↔ JSON-LD `29990`.

Ultra also exposes credit/installment-related values.

Comparable full purchase price must remain separate from installment values.

### Availability Semantics

Ultra availability required deeper validation.

Initial sold-out samples contained labels:

* `În stoc`;
* `În showroom`;

but both labels were rendered with:

* `badge--danger`;
* `svg-close`.

The purchase card offered:

`Notifică când este disponibil`

Therefore the label text alone is not sufficient.

A known available Lenovo sample showed:

* `În stoc` with `badge--success`;
* `svg-check`;
* real cart action;
* one-click purchase action;
* no `Notifică când este disponibil`.

Its `În showroom` state remained independently negative.

Stage 3 conclusion:

Ultra represents at least two separate availability dimensions:

* general/online stock;
* showroom stock.

Parser logic must use scoped badge state/icon and purchase action semantics.

Text-only matching is unsafe.

### JSON-LD Availability Caveat

The sold-out samples still exposed JSON-LD:

`availability = InStock`

while the visible purchase UI indicated the product was unavailable.

Therefore Ultra JSON-LD availability is not trustworthy as the sole source of availability state.

Future ingestion must cross-check visible/scoped availability semantics.

### Official B2B API Opportunity

Ultra exposes an official B2B API/documentation surface.

It appears to support concepts including:

* catalog data;
* categories;
* brands;
* stock;
* incremental changes.

Authenticated partner/dealer access is required for relevant endpoints.

Stage 3 does not assume that:

* CUMPAVIO currently has access;
* partnership exists;
* B2B pricing equals public retail pricing;
* the API automatically grants redistribution rights.

However, under the frozen source preference hierarchy, an officially permitted API/feed would be preferable to scraping if suitable access and public-retail semantics are later confirmed.

### Legal / Data Use

Public technical accessibility does not establish unrestricted commercial reuse rights.

The official B2B/partner path is a potentially cleaner future production-source route, but permissions and exact data semantics remain unresolved.

Product images must not be assumed freely reusable or rehostable.

### Preliminary Classification

**Approved with constraints**

Technical feasibility is strong.

Ultra is currently the strongest candidate for future API/feed investigation in addition to its publicly accessible sitemap/HTML path.

---

## 12. Current Retailer Feasibility Matrix

| Retailer | Smartphones | Laptops | Sitemap                   | Ordinary HTTP       | Structured Product Data | Identifier Quality | Playwright Required | Anti-Bot Risk | Current Classification    |
| -------- | ----------- | ------- | ------------------------- | ------------------- | ----------------------- | ------------------ | ------------------- | ------------- | ------------------------- |
| Enter    | Yes         | Yes     | Strong                    | Yes                 | Strong                  | Good               | No for tested flow  | Low/Medium    | Approved with constraints |
| Darwin   | Yes         | Yes     | Strong                    | Yes                 | Strong                  | Good               | No for tested flow  | Low/Medium    | Approved with constraints |
| Ultra    | Yes         | Yes     | Strong                    | Yes                 | Strong                  | High               | No for tested flow  | Low           | Approved with constraints |
| Bomba    | Yes         | Yes     | Declared but HTTP-blocked | No in tested client | Not validated           | Not validated      | Potentially         | High          | Research further          |

---

## 13. V1 Minimum Source Requirement

Frozen Product Contract requirement:

**minimum 3 production-quality retailer data sources**

Stage 3 feasibility research has now identified three technically strong candidates:

1. Enter;
2. Darwin;
3. Ultra.

All three currently remain:

**Approved with constraints**

This classification means:

* technical feasibility is strong enough to continue;
* no final partnership claim is made;
* no blanket data-use license is assumed;
* source-specific production operation must remain responsible;
* image/content reuse remains separately constrained;
* implementation must preserve provenance and source-specific behavior.

The minimum V1 source feasibility threshold is therefore technically satisfied.

---

## 14. Key Cross-Retailer Findings

### Discovery

Sitemaps are highly valuable for:

* Enter;
* Darwin;
* Ultra.

Search crawling is not required for these sources.

### Browser Rendering

No tested primary product flow for:

* Enter;
* Darwin;
* Ultra

requires Playwright.

Bomba is materially more difficult and may require browser-based access.

### Identifiers

Identifier quality varies significantly by retailer.

Enter:

* strong retailer source code;
* weak/untrusted JSON-LD manufacturer MPN semantics.

Darwin:

* strong internal numeric product ID;
* JSON-LD `mpn` duplicates internal ID and is not manufacturer MPN.

Ultra:

* explicit source product code;
* explicit article/part identifier;
* strongest identifier semantics in the tested set.

### Structured Data

Product JSON-LD is useful but must never be trusted blindly.

Ultra proved that structured availability may conflict with actual visible purchase state.

Structured data remains evidence, not unquestionable truth.

### Variant Extraction

Full-page substring matching is unsafe.

Recommended future extraction priority:

1. structured product object where semantically valid;
2. primary product block;
3. scoped specification data;
4. controlled fallback extraction.

### Price Semantics

Retailers may expose:

* selling price;
* old price;
* discount;
* cashback;
* installment amount;
* credit values.

Only the documented comparable full purchase price belongs in CUMPAVIO current-price comparison.

### Locale

Romanian and Russian retailer pages may represent the same underlying source listing.

Locale representations must not silently create duplicate canonical offers.

---

## 15. Legal / Responsible Sourcing Findings

Stage 3 established the following principles:

* robots accessibility is not a commercial-use license;
* technical HTTP accessibility is not legal permission;
* lack of a robots file is not permission;
* CUMPAVIO must not bypass access controls;
* prohibited/internal paths are not valid ingestion shortcuts;
* public retailer images must not be assumed reusable;
* no retailer partnership may be claimed without an actual agreement;
* source-specific permissions/terms must be reviewed before production launch;
* official API/feed access is preferred where legitimately available and semantically suitable.

No production retailer is currently represented as a formal CUMPAVIO partner.

---

## 16. First Store Proof

Status:

**Validated**

Selected retailer:

**Ultra**

Validated proof scope:

* one available Laptop sample;
* one unavailable Smartphone sample;
* ordinary HTTP retrieval;
* scoped Product JSON-LD parsing;
* scoped visible product parsing;
* retailer source product identifiers;
* article/manufacturer-style identifiers;
* comparable MDL price validation;
* online availability;
* showroom availability;
* cart-action semantics;
* notify-when-available semantics;
* explicit detection of JSON-LD/visible availability disagreement;
* transactional persistence through the Stage 2 data model;
* controlled manual canonical association;
* Offer creation;
* accepted Price Observation creation;
* mandatory transaction rollback.

Observed proof result:

* both product samples passed all parser checks;
* the available Laptop produced `in_stock`;
* the unavailable Smartphone produced `out_of_stock`;
* the unavailable Smartphone simultaneously exposed JSON-LD `InStock`, proving that JSON-LD availability cannot be the sole authority for Ultra;
* both comparable visible prices matched JSON-LD prices;
* all Stage 2 persistence assertions passed;
* proof data was removed successfully by transaction rollback.

The proof remains intentionally non-production.

The First Store Proof must be deliberately narrow.

Its purpose is to prove that the Stage 2 persistence model can consume one real retailer source safely without building the Stage 4 production ingestion platform.

The proof must:

* use one approved-with-constraints retailer;
* use only V1 categories;
* use a small controlled product sample;
* preserve source URL and source identity;
* preserve raw/source observations;
* extract comparable price safely;
* extract availability with retailer-specific semantics;
* preserve relevant identifiers;
* avoid automatic canonical matching when confidence is insufficient;
* avoid large-scale crawling;
* avoid scheduling/orchestration;
* avoid anti-bot bypass;
* remain clearly non-production.

---

## ## 17. First Store Proof Selection Rationale

Selected retailer:

**Ultra**

Selection reasons:

* clean sitemap hierarchy;
* dedicated Romanian product sitemap;
* ordinary HTTP works for the tested product flow;
* server-rendered product data is available;
* Product JSON-LD is available;
* strong retailer source identifiers through `Cod produs`;
* strong article/manufacturer-style identifiers through `Articol`;
* comparable visible price can be validated against JSON-LD price;
* online and showroom availability semantics were explicitly proven;
* misleading JSON-LD availability was detected and safely overridden by scoped visible semantics;
* no browser rendering was required for the tested flow;
* the Stage 2 persistence model successfully accepted controlled Ultra observations;
* an official B2B/API path exists for future legitimate source investigation.

Ultra is therefore the validated First Store Proof source and the preferred first implementation source for Stage 4 engineering.

This is a technical implementation decision only.

It does not represent:

* a retailer partnership;
* unrestricted commercial data-use permission;
* permission to reuse or rehost retailer images;
* confirmation that Ultra B2B pricing equals public retail pricing;
* final production-launch legal approval.

---

## 18. Stage 4 Source Strategy

Stage 4 must not be implemented during Stage 3.

Based on the completed retailer feasibility research and the validated Ultra First Store Proof, the initial Stage 4 source strategy is now finalized.

Implementation priority:

1. Ultra;
2. Enter;
3. Darwin.

Bomba remains a fallback/research candidate and is not part of the initial production ingestion implementation.

### Enter

`robots review → sitemap index → product shards → product URL → ordinary HTTP → Product JSON-LD + scoped HTML fallback`

### Darwin

`sitemap index → product shards → canonical locale handling → product URL → ordinary HTTP → Product JSON-LD + scoped HTML fallback`

### Ultra

`sitemap index → Romanian product sitemap → product URL → ordinary HTTP → Product JSON-LD + scoped primary product blocks`

Additionally:

* investigate legitimate B2B/API access before committing to scraping as the long-term Ultra production path.

### Bomba

Do not prioritize for initial Stage 4 implementation unless a simpler permitted source path becomes available or the three primary candidates become insufficient.

### Stage 4 Engineering Constraints

Stage 4 implementation must preserve the following decisions proven during Stage 3:

* crawler/worker execution remains separate from interactive web requests;
* sitemap-first discovery is preferred where available;
* ordinary HTTP is preferred over browser rendering;
* Playwright must not be introduced for Enter, Darwin or Ultra unless new evidence proves it necessary;
* retailer-specific parsers must scope extraction to the primary product context;
* source identifiers must remain separate from canonical identifiers;
* retailer-provided `mpn` values must not be trusted blindly;
* comparable full purchase price must remain separate from installments, cashback and promotional values;
* availability must use retailer-specific semantics rather than generic text matching;
* Ultra visible availability semantics override conflicting JSON-LD availability;
* Romanian/Russian locale representations must not create duplicate physical offers;
* raw/source observations and provenance must remain auditable;
* uncertain product matches must not be silently auto-merged;
* no access-control or anti-bot bypass is permitted;
* official permitted API/feed access remains preferable to scraping where commercially and semantically suitable.

The Ultra B2B/API opportunity should be investigated before treating public HTML parsing as the permanent Ultra production source.

This strategy is an engineering starting point, not a retailer partnership or legal-use approval.

---

## 19. Stage 3 Risks

Current risks:

### Source Stability

Retailer HTML and structured-data contracts may change.

### Availability Semantics

Retailer availability may represent multiple channels:

* online;
* showroom;
* store;
* orderable;
* temporarily unavailable.

### Identifier Semantics

Retailer-provided `sku` or `mpn` fields may not follow schema.org semantics correctly.

### Locale Duplication

RO/RU representations may duplicate the same physical source listing.

### Price Semantics

Installment or promotional values may be mistaken for comparable price if parsing is not scoped.

### Anti-Bot

Retailers such as Bomba may block ordinary non-browser clients.

### Legal / Data Rights

Technical feasibility does not guarantee commercial reuse rights.

### Product Matching

Strong retailer data does not eliminate canonical matching risk.

False-positive matching remains more severe than false-negative matching.

---

## 20. Risk Mitigations

Stage 3 mitigation decisions:

* sitemap-first discovery;
* ordinary HTTP before browser rendering;
* no access-control bypass;
* scoped product parsing;
* retailer-specific availability semantics;
* explicit source identifiers;
* preserve raw/source evidence;
* treat questionable MPN fields conservatively;
* separate source observations from canonical products;
* no automatic canonical merge without sufficient evidence;
* comparable-price validation;
* locale deduplication strategy;
* source-specific legal review;
* official API/feed preference where available;
* one constrained First Store Proof before multi-store ingestion.

---

## 21. Repository Changes

Current Stage 3 repository changes:

* `.gitignore`
* `docs/stages/stage-03.md`
* `proofs/stage-03/ultra/pyproject.toml`
* `proofs/stage-03/ultra/proof.py`
* `proofs/stage-03/ultra/persistence-proof.sql`

The Ultra proof is intentionally isolated under `proofs/stage-03/`.

No production crawler, scheduler, worker or multi-store connector has been introduced.

Generated/local Python artifacts such as `.venv`, `__pycache__`, `.pytest_cache` and `*.egg-info` are ignored.

---

## 22. Definition of Done — Stage 3

Stage 3 is complete when:

* [x] Stage 2 completion state audited
* [x] repository baseline verified
* [x] Product Contract scope confirmed
* [x] retailer research pool defined
* [x] Enter feasibility investigated
* [x] Darwin feasibility investigated
* [x] Bomba feasibility investigated
* [x] Ultra feasibility investigated
* [x] minimum 3 technically strong V1 retailer candidates identified
* [x] sitemap/discovery strategy validated for primary candidates
* [x] ordinary HTTP feasibility validated for primary candidates
* [x] structured-data quality sampled
* [x] comparable-price semantics sampled
* [x] availability semantics sampled
* [x] retailer/source identifier semantics sampled
* [x] variant-quality risks documented
* [x] locale duplication risk documented
* [x] anti-bot constraints documented
* [x] legal/responsible-sourcing constraints documented
* [x] browser-rendering need assessed
* [x] First Store Proof retailer finalized
* [x] First Store Proof implemented
* [x] First Store Proof validated
* [x] Stage 4 source strategy finalized from proof evidence
* [x] `docs/project-state.md` updated
* [x] final Stage 3 repository audit passes
* [x] relevant quality validation passes
* [x] `git diff --check` passes
* [x] staged diff reviewed
* [x] Stage 3 commit created
* [x] working tree clean after commit
* [ ] push performed only after Product Owner confirmation
* [ ] Stage 3 → Stage 4 Context Handoff prepared in Russian
* [ ] Stage 4 new-chat prompt prepared in Russian

---

## 23. Current Stage Status

Retailer feasibility research is sufficiently complete to proceed.

Current source classifications:

* Enter — Approved with constraints;
* Darwin — Approved with constraints;
* Ultra — Approved with constraints;
* Bomba — Research further / fallback candidate.

The frozen minimum requirement of three technically strong retailer candidates has been satisfied.

Stage 3 implementation and local validation are complete.

Final closeout remains pending:

* push after Product Owner confirmation;
* Russian Stage 3 → Stage 4 Context Handoff;
* Russian Stage 4 new-chat prompt.

Next work:

**synchronize `docs/project-state.md` and perform the final Stage 3 completion audit.**

---

## 24. Handoff to Stage 4

Pending.

Stage 4 must not begin in this chat until:

* First Store Proof is complete;
* Stage 3 completion audit passes;
* Stage 3 state is persisted;
* commit/push workflow is completed with Product Owner approval;
* Russian Context Handoff is prepared.
