# CUMPAVIO

CUMPAVIO is a Moldova-first shopping intelligence platform.

Core principle:

**Data → Intelligence → Decision**

Current development status:

**Stage 1 — Repository & Engineering Foundation**

The product scope is frozen in:

`docs/product-contract.md`

That document is the single source of truth for CUMPAVIO V1.

---

## V1 Scope

Initial market:

- Moldova

Initial categories:

- Smartphones
- Laptops

V1 user interface languages:

- Romanian — primary/default
- Russian — secondary

Current development copy may use Russian for implementation convenience.

English UI is Post-MVP.

---

## Technology Foundation

Current web foundation:

- Next.js 16
- React 19
- TypeScript strict
- Tailwind CSS 4
- ESLint
- Vitest
- React Testing Library
- GitHub Actions CI

Planned future platform direction includes Supabase/PostgreSQL and a separate Python crawler runtime, but those are not implemented during Stage 1.

---

## Requirements

Local development currently uses:

- Node.js 22
- npm 10

Verified Stage 1 baseline:

- Node.js `22.16.0`
- npm `10.9.2`

---

## Local Setup

Clone the repository:

git clone https://github.com/SuhihAlex/cumpavio.git
cd cumpavio

Install dependencies:

npm ci

Start development:

npm run dev

The application is available by default at:

http://localhost:3000

---

## Environment Variables

Stage 1 currently requires no environment variables.

When environment variables are introduced:

1. copy .env.example to .env.local;
2. keep secrets server-only;
3. never commit .env.local or other real environment files;
4. use NEXT_PUBLIC_ only for values intentionally exposed to the browser.

---

## Quality Commands

Lint:

npm run lint

Typecheck:

npm run typecheck

Tests:

npm test

Watch tests:

npm run test:watch

Production build:

npm run build

---

## CI

GitHub Actions runs on pushes and pull requests targeting main.

The CI quality job performs:

1. npm ci
2. npm run lint
3. npm run typecheck
4. npm test
5. npm run build

---

## Repository Structure

cumpavio/
├─ .github/
│  └─ workflows/
│     └─ ci.yml
├─ docs/
│  ├─ product-contract.md
│  ├─ project-state.md
│  └─ stages/
├─ src/
│  ├─ __tests__/
│  └─ app/
├─ .env.example
├─ AGENTS.md
├─ CLAUDE.md
├─ eslint.config.mjs
├─ next.config.ts
├─ package.json
├─ postcss.config.mjs
├─ tsconfig.json
└─ vitest.config.mts

---

## Engineering Rules

Do not introduce functionality outside the active Stage.

Important frozen architecture rules include:

user requests never synchronously crawl retailer websites;
crawler runtime remains separate from interactive web runtime;
raw/source data remains separate from canonical data;
Product Family and Product Variant are distinct concepts;
uncertain products must not be automatically merged;
price observations remain source-attributable;
rejected anomalies must not corrupt price history;
PostgreSQL search is preferred before introducing a separate search engine;
V1 contains no public accounts;
V1 contains no user-facing AI.

See:

docs/product-contract.md

for the complete V1 contract.

---

## Current Stage

Stage 1 only establishes the engineering foundation.

Stage 1 does not implement:

Supabase business schema;
retailer connectors;
crawling;
normalization;
matching;
search;
product pages;
comparison;
price intelligence;
final Product Design.

See:

docs/stages/stage-01.md

for the current Stage record.