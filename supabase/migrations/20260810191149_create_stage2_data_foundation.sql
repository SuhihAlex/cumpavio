create schema if not exists internal;

create type public.product_category as enum (
  'smartphone',
  'laptop'
);

create type public.record_status as enum (
  'active',
  'inactive',
  'archived'
);

create type public.availability_status as enum (
  'unknown',
  'in_stock',
  'out_of_stock',
  'preorder',
  'backorder'
);

create type public.price_observation_quality as enum (
  'pending',
  'accepted',
  'suspicious',
  'rejected'
);

create type internal.source_type as enum (
  'website',
  'api',
  'feed',
  'sitemap',
  'other'
);

create type internal.run_status as enum (
  'pending',
  'running',
  'succeeded',
  'partially_succeeded',
  'failed',
  'cancelled'
);

create type internal.parse_status as enum (
  'pending',
  'parsed',
  'partial',
  'failed'
);

create type internal.match_status as enum (
  'pending',
  'matched',
  'ambiguous',
  'rejected'
);

create type internal.match_method as enum (
  'gtin',
  'manufacturer_identifier',
  'mpn',
  'normalized_model',
  'deterministic',
  'fuzzy',
  'manual'
);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create table public.retailers (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null,
  website_url text,
  status public.record_status not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint retailers_slug_not_blank
    check (btrim(slug) <> ''),

  constraint retailers_name_not_blank
    check (btrim(name) <> ''),

  constraint retailers_website_url_not_blank
    check (website_url is null or btrim(website_url) <> '')
);

create trigger retailers_set_updated_at
before update on public.retailers
for each row
execute function public.set_updated_at();


create table internal.retailer_sources (
  id uuid primary key default gen_random_uuid(),
  retailer_id uuid not null references public.retailers(id) on delete restrict,
  source_key text not null,
  source_type internal.source_type not null,
  base_url text,
  status public.record_status not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint retailer_sources_source_key_not_blank
    check (btrim(source_key) <> ''),

  constraint retailer_sources_base_url_not_blank
    check (base_url is null or btrim(base_url) <> ''),

  constraint retailer_sources_retailer_source_key_unique
    unique (retailer_id, source_key)
);

create index retailer_sources_retailer_id_idx
  on internal.retailer_sources (retailer_id);

create trigger retailer_sources_set_updated_at
before update on internal.retailer_sources
for each row
execute function public.set_updated_at();


create table internal.crawl_runs (
  id uuid primary key default gen_random_uuid(),
  retailer_source_id uuid not null references internal.retailer_sources(id) on delete restrict,
  status internal.run_status not null default 'pending',
  trigger_kind text,
  crawler_version text,
  parser_version text,
  started_at timestamptz,
  finished_at timestamptz,
  stats jsonb not null default '{}'::jsonb,
  error_summary text,
  created_at timestamptz not null default now(),

  constraint crawl_runs_trigger_kind_not_blank
    check (trigger_kind is null or btrim(trigger_kind) <> ''),

  constraint crawl_runs_crawler_version_not_blank
    check (crawler_version is null or btrim(crawler_version) <> ''),

  constraint crawl_runs_parser_version_not_blank
    check (parser_version is null or btrim(parser_version) <> ''),

  constraint crawl_runs_finished_after_started
    check (
      finished_at is null
      or started_at is null
      or finished_at >= started_at
    ),

  constraint crawl_runs_stats_object
    check (jsonb_typeof(stats) = 'object')
);

create index crawl_runs_retailer_source_id_idx
  on internal.crawl_runs (retailer_source_id);

create index crawl_runs_started_at_idx
  on internal.crawl_runs (started_at desc);


create table internal.source_listings (
  id uuid primary key default gen_random_uuid(),
  retailer_source_id uuid not null references internal.retailer_sources(id) on delete restrict,
  source_key text not null,
  external_id text,
  source_url text not null,
  status public.record_status not null default 'active',
  first_seen_at timestamptz not null,
  last_seen_at timestamptz not null,
  last_checked_at timestamptz not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint source_listings_source_key_not_blank
    check (btrim(source_key) <> ''),

  constraint source_listings_external_id_not_blank
    check (external_id is null or btrim(external_id) <> ''),

  constraint source_listings_source_url_not_blank
    check (btrim(source_url) <> ''),

  constraint source_listings_seen_order
    check (last_seen_at >= first_seen_at),

  constraint source_listings_checked_after_first_seen
    check (last_checked_at >= first_seen_at),

  constraint source_listings_source_key_unique
    unique (retailer_source_id, source_key)
);

create index source_listings_retailer_source_id_idx
  on internal.source_listings (retailer_source_id);

create index source_listings_last_checked_at_idx
  on internal.source_listings (last_checked_at desc);

create trigger source_listings_set_updated_at
before update on internal.source_listings
for each row
execute function public.set_updated_at();

create table internal.source_listing_observations (
  id uuid primary key default gen_random_uuid(),
  source_listing_id uuid not null
    references internal.source_listings(id) on delete restrict,
  crawl_run_id uuid
    references internal.crawl_runs(id) on delete restrict,
  observed_at timestamptz not null,
  parse_status internal.parse_status not null default 'pending',
  parser_version text,
  title_raw text,
  raw_price_text text,
  raw_availability_text text,
  raw_identifiers jsonb not null default '{}'::jsonb,
  extracted_attributes jsonb not null default '{}'::jsonb,
  source_payload jsonb not null default '{}'::jsonb,
  content_hash text,
  error_details jsonb,
  created_at timestamptz not null default now(),

  constraint source_listing_observations_parser_version_not_blank
    check (
      parser_version is null
      or btrim(parser_version) <> ''
    ),

  constraint source_listing_observations_content_hash_not_blank
    check (
      content_hash is null
      or btrim(content_hash) <> ''
    ),

  constraint source_listing_observations_raw_identifiers_object
    check (jsonb_typeof(raw_identifiers) = 'object'),

  constraint source_listing_observations_extracted_attributes_object
    check (jsonb_typeof(extracted_attributes) = 'object'),

  constraint source_listing_observations_source_payload_object
    check (jsonb_typeof(source_payload) = 'object'),

  constraint source_listing_observations_error_details_object
    check (
      error_details is null
      or jsonb_typeof(error_details) = 'object'
    )
);

create index source_listing_observations_source_listing_id_idx
  on internal.source_listing_observations (source_listing_id);

create index source_listing_observations_crawl_run_id_idx
  on internal.source_listing_observations (crawl_run_id);

create index source_listing_observations_observed_at_idx
  on internal.source_listing_observations (observed_at desc);

create index source_listing_observations_listing_observed_idx
  on internal.source_listing_observations (
    source_listing_id,
    observed_at desc
  );

create table public.product_families (
  id uuid primary key default gen_random_uuid(),
  category public.product_category not null,
  brand text not null,
  brand_normalized text not null,
  model_name text not null,
  model_normalized text not null,
  display_name text not null,
  status public.record_status not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint product_families_brand_not_blank
    check (btrim(brand) <> ''),

  constraint product_families_brand_normalized_not_blank
    check (btrim(brand_normalized) <> ''),

  constraint product_families_model_name_not_blank
    check (btrim(model_name) <> ''),

  constraint product_families_model_normalized_not_blank
    check (btrim(model_normalized) <> ''),

  constraint product_families_display_name_not_blank
    check (btrim(display_name) <> '')
);

create index product_families_category_idx
  on public.product_families (category);

create index product_families_brand_normalized_idx
  on public.product_families (brand_normalized);

create index product_families_model_normalized_idx
  on public.product_families (model_normalized);

create trigger product_families_set_updated_at
before update on public.product_families
for each row
execute function public.set_updated_at();


create table public.product_variants (
  id uuid primary key default gen_random_uuid(),
  family_id uuid not null references public.product_families(id) on delete restrict,
  variant_key text not null,
  display_name text not null,
  attributes jsonb not null default '{}'::jsonb,
  status public.record_status not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint product_variants_variant_key_not_blank
    check (btrim(variant_key) <> ''),

  constraint product_variants_display_name_not_blank
    check (btrim(display_name) <> ''),

  constraint product_variants_attributes_object
    check (jsonb_typeof(attributes) = 'object'),

  constraint product_variants_family_variant_key_unique
    unique (family_id, variant_key)
);

create index product_variants_family_id_idx
  on public.product_variants (family_id);

create trigger product_variants_set_updated_at
before update on public.product_variants
for each row
execute function public.set_updated_at();


create table public.product_variant_identifiers (
  id uuid primary key default gen_random_uuid(),
  variant_id uuid not null references public.product_variants(id) on delete restrict,
  identifier_type text not null,
  value text not null,
  normalized_value text not null,
  is_primary boolean not null default false,
  created_at timestamptz not null default now(),

  constraint product_variant_identifiers_type_not_blank
    check (btrim(identifier_type) <> ''),

  constraint product_variant_identifiers_value_not_blank
    check (btrim(value) <> ''),

  constraint product_variant_identifiers_normalized_value_not_blank
    check (btrim(normalized_value) <> '')
);

create index product_variant_identifiers_variant_id_idx
  on public.product_variant_identifiers (variant_id);

create index product_variant_identifiers_lookup_idx
  on public.product_variant_identifiers (
    identifier_type,
    normalized_value
  );

create table internal.product_match_records (
  id uuid primary key default gen_random_uuid(),
  source_listing_id uuid not null
    references internal.source_listings(id) on delete restrict,
  variant_id uuid
    references public.product_variants(id) on delete restrict,
  status internal.match_status not null default 'pending',
  method internal.match_method,
  confidence numeric(5,4),
  evidence jsonb not null default '{}'::jsonb,
  decided_at timestamptz,
  superseded_at timestamptz,
  created_at timestamptz not null default now(),

  constraint product_match_records_confidence_range
    check (
      confidence is null
      or (confidence >= 0 and confidence <= 1)
    ),

  constraint product_match_records_evidence_object
    check (jsonb_typeof(evidence) = 'object'),

  constraint product_match_records_decision_consistency
    check (
      (
        status = 'pending'
        and variant_id is null
        and decided_at is null
      )
      or
      (
        status = 'matched'
        and variant_id is not null
        and method is not null
        and decided_at is not null
      )
      or
      (
        status in ('ambiguous', 'rejected')
        and decided_at is not null
      )
    ),

  constraint product_match_records_superseded_after_decision
    check (
      superseded_at is null
      or (
        decided_at is not null
        and superseded_at >= decided_at
      )
    )
);

create index product_match_records_source_listing_id_idx
  on internal.product_match_records (source_listing_id);

create index product_match_records_variant_id_idx
  on internal.product_match_records (variant_id);

create index product_match_records_status_idx
  on internal.product_match_records (status);

create index product_match_records_active_listing_idx
  on internal.product_match_records (
    source_listing_id,
    created_at desc
  )
  where superseded_at is null;

create table public.offers (
  id uuid primary key default gen_random_uuid(),
  variant_id uuid not null
    references public.product_variants(id) on delete restrict,
  retailer_id uuid not null
    references public.retailers(id) on delete restrict,
  source_listing_id uuid not null
    references internal.source_listings(id) on delete restrict,
  current_comparable_price numeric(12,2),
  currency_code text not null default 'MDL',
  availability_status public.availability_status not null default 'unknown',
  status public.record_status not null default 'active',
  last_observed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint offers_current_comparable_price_positive
    check (
      current_comparable_price is null
      or current_comparable_price > 0
    ),

  constraint offers_currency_code_format
    check (
      currency_code ~ '^[A-Z]{3}$'
    ),

  constraint offers_variant_source_listing_unique
    unique (variant_id, source_listing_id)
);

create index offers_variant_id_idx
  on public.offers (variant_id);

create index offers_retailer_id_idx
  on public.offers (retailer_id);

create index offers_source_listing_id_idx
  on public.offers (source_listing_id);

create index offers_current_price_idx
  on public.offers (current_comparable_price)
  where current_comparable_price is not null;

create trigger offers_set_updated_at
before update on public.offers
for each row
execute function public.set_updated_at();


create table public.price_observations (
  id uuid primary key default gen_random_uuid(),
  offer_id uuid not null
    references public.offers(id) on delete restrict,
  source_listing_observation_id uuid not null
    references internal.source_listing_observations(id) on delete restrict,
  observed_at timestamptz not null,
  comparable_price numeric(12,2) not null,
  currency_code text not null default 'MDL',
  availability_status public.availability_status not null default 'unknown',
  quality_status public.price_observation_quality not null default 'pending',
  quality_reason text,
  created_at timestamptz not null default now(),

  constraint price_observations_comparable_price_positive
    check (comparable_price > 0),

  constraint price_observations_currency_code_format
    check (
      currency_code ~ '^[A-Z]{3}$'
    ),

  constraint price_observations_quality_reason_not_blank
    check (
      quality_reason is null
      or btrim(quality_reason) <> ''
    ),

  constraint price_observations_offer_source_observation_unique
    unique (offer_id, source_listing_observation_id)
);

create index price_observations_offer_id_idx
  on public.price_observations (offer_id);

create index price_observations_observed_at_idx
  on public.price_observations (observed_at desc);

create index price_observations_offer_observed_idx
  on public.price_observations (
    offer_id,
    observed_at desc
  );

create index price_observations_accepted_history_idx
  on public.price_observations (
    offer_id,
    observed_at desc
  )
  where quality_status = 'accepted';