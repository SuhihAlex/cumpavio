# CUMPAVIO

**Moldova-first shopping intelligence platform — in development.**

CUMPAVIO is a product engineering project focused on helping users
understand products, retailer offers and price history before making
a purchase decision.

**Core principle:**

**Data → Intelligence → Decision**

Current development status:

**Stage 3 complete — Data Feasibility & First Store Proof**

The project is being developed stage by stage under a frozen V1 Product Contract.

---

## Current Status

CUMPAVIO is currently an **engineering and data foundation project**.

Implemented foundations include:

- Next.js application foundation
- React and TypeScript strict mode
- Tailwind CSS
- ESLint
- Vitest and React Testing Library
- GitHub Actions CI
- local Supabase development
- PostgreSQL migrations
- canonical and source-data schema boundaries
- Row Level Security
- generated TypeScript database types
- pgTAP database tests
- retailer data feasibility research
- constrained First Store Proof
- source provenance and price observation models

The public shopping interface is **not implemented yet**.

Production retailer ingestion has **not started yet**.

---

## Product Direction

Initial market:

**Moldova**

Initial categories:

- Smartphones
- Laptops

V1 interface languages:

- Romanian — primary
- Russian — secondary

The long-term product flow is:

```text
Retailer Data
→ Source Observation
→ Normalization
→ Product Matching
→ Canonical Product
→ Retailer Offers
→ Price History
→ Price Intelligence
→ Public Shopping Experience
```

## Web Foundation

The current application foundation uses:

Next.js 16
React 19
TypeScript
Tailwind CSS 4
App Router
ESLint
Vitest
React Testing Library

### Current Frontend Status

The frontend is intentionally minimal at the current project stage.

Product pages, search, comparison interfaces and final product design
have not been implemented yet.

Current frontend work focuses on maintaining a clean application
foundation for later product stages.

## Data Foundation

Current data-engineering work includes:

Supabase local development
PostgreSQL
migrations-first workflow
canonical product data model
retailer/source provenance
Product Family and Product Variant separation
offers and price observations
price quality states
matching decision audit records
Row Level Security
generated TypeScript database types
database validation with pgTAP

The project intentionally separates retailer-source data from
canonical product data.

## Data Feasibility

Stage 3 evaluated retailer-data feasibility for the V1 categories.

The current engineering direction validated multiple retailer
candidates and completed a constrained First Store Proof.

This stage did not introduce production crawling or automated
multi-store ingestion.

## Testing and Quality

Web quality checks include:

```text
npm run lint
npm run typecheck
npm test
npm run build
```

GitHub Actions runs these checks for pushes and pull requests targeting
the main branch.

Database validation is maintained separately through the Supabase
local-development workflow and pgTAP tests.

## Current Technology

### Application

Next.js · React · TypeScript · Tailwind CSS

### Testing

Vitest · React Testing Library

### Data / Platform

Supabase · PostgreSQL · RLS · pgTAP

### Engineering

Git · GitHub Actions · ESLint

## Not Implemented Yet

The repository does not currently provide:

production retailer crawling
scheduled ingestion
large-scale canonical catalog population
automated product matching
public product search
category browsing
product pages
offer comparison UI
price-history UI
deterministic price intelligence
finished visual design
production deployment

These capabilities belong to later project stages.

## Repository Structure
```text
cumpavio/
├── .github/
│   └── workflows/
├── docs/
│   ├── product-contract.md
│   ├── project-state.md
│   └── stages/
├── src/
│   ├── __tests__/
│   ├── app/
│   └── types/
├── supabase/
│   ├── migrations/
│   └── tests/
├── package.json
└── README.md
```
## Development Approach

CUMPAVIO is intentionally developed in controlled stages.

The Product Contract defines the frozen V1 scope, while
docs/project-state.md records the current implementation state.

This approach keeps product decisions, engineering boundaries and
implemented functionality separate from future plans.

## Author

Built by Alexandr Suhih as an ongoing product engineering project.

My primary professional direction is frontend development, while
CUMPAVIO also gives me practical experience with application architecture,
testing and data-platform foundations.

[GitHub](https://github.com/SuhihAlex) ·
[LinkedIn](https://www.linkedin.com/in/alexandr-suhih-1a4821289/)
