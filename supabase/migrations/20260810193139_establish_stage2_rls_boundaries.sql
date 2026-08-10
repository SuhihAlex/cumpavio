-- ============================================================
-- Public Data API boundary
-- ============================================================

alter table public.retailers
  enable row level security;

alter table public.product_families
  enable row level security;

alter table public.product_variants
  enable row level security;

alter table public.product_variant_identifiers
  enable row level security;

alter table public.offers
  enable row level security;

alter table public.price_observations
  enable row level security;


-- Remove any broader privileges that may exist because of
-- platform/default privilege differences between environments.

revoke all on table public.retailers
  from anon, authenticated;

revoke all on table public.product_families
  from anon, authenticated;

revoke all on table public.product_variants
  from anon, authenticated;

revoke all on table public.product_variant_identifiers
  from anon, authenticated;

revoke all on table public.offers
  from anon, authenticated;

revoke all on table public.price_observations
  from anon, authenticated;


-- Public CUMPAVIO V1 is anonymous/read-only.
-- authenticated receives the same read boundary for now so
-- introducing internal Auth later cannot accidentally expand
-- access beyond the public data surface.

grant select on table public.retailers
  to anon, authenticated;

grant select on table public.product_families
  to anon, authenticated;

grant select on table public.product_variants
  to anon, authenticated;

grant select on table public.product_variant_identifiers
  to anon, authenticated;

grant select on table public.offers
  to anon, authenticated;

grant select on table public.price_observations
  to anon, authenticated;


-- ============================================================
-- Public read policies
-- ============================================================

create policy retailers_public_read
on public.retailers
for select
to anon, authenticated
using (
  status = 'active'
);


create policy product_families_public_read
on public.product_families
for select
to anon, authenticated
using (
  status = 'active'
);


create policy product_variants_public_read
on public.product_variants
for select
to anon, authenticated
using (
  status = 'active'
);


create policy product_variant_identifiers_public_read
on public.product_variant_identifiers
for select
to anon, authenticated
using (
  exists (
    select 1
    from public.product_variants as variant
    where variant.id = product_variant_identifiers.variant_id
      and variant.status = 'active'
  )
);


create policy offers_public_read
on public.offers
for select
to anon, authenticated
using (
  status = 'active'
);


create policy price_observations_public_read
on public.price_observations
for select
to anon, authenticated
using (
  quality_status = 'accepted'
);


-- ============================================================
-- Internal/source boundary
-- ============================================================

alter table internal.retailer_sources
  enable row level security;

alter table internal.crawl_runs
  enable row level security;

alter table internal.source_listings
  enable row level security;

alter table internal.source_listing_observations
  enable row level security;

alter table internal.product_match_records
  enable row level security;


-- The internal schema is deliberately not part of api.schemas.
-- These revokes provide an additional least-privilege boundary.

revoke all on schema internal
  from public, anon, authenticated;

revoke all on all tables in schema internal
  from public, anon, authenticated;

revoke all on all sequences in schema internal
  from public, anon, authenticated;

revoke all on all functions in schema internal
  from public, anon, authenticated;


-- Prevent future postgres-owned internal objects from becoming
-- reachable by client roles through inherited/default privileges.

alter default privileges for role postgres in schema internal
  revoke all on tables
  from public, anon, authenticated;

alter default privileges for role postgres in schema internal
  revoke all on sequences
  from public, anon, authenticated;

alter default privileges for role postgres in schema internal
  revoke execute on functions
  from public, anon, authenticated;


-- ============================================================
-- Helper function hardening
-- ============================================================

-- PostgreSQL functions normally receive EXECUTE for PUBLIC unless
-- restricted. This helper exists only for database triggers and is
-- not a public RPC endpoint.

revoke execute on function public.set_updated_at()
  from public, anon, authenticated;