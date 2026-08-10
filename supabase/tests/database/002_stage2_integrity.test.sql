begin;

select plan(8);

-- ------------------------------------------------------------
-- Fixtures
-- ------------------------------------------------------------

insert into public.retailers (
  id,
  slug,
  name,
  website_url
)
values (
  '00000000-0000-0000-0000-000000000001',
  'test-retailer',
  'Test Retailer',
  'https://example.test'
);

insert into internal.retailer_sources (
  id,
  retailer_id,
  source_key,
  source_type,
  base_url
)
values (
  '00000000-0000-0000-0000-000000000002',
  '00000000-0000-0000-0000-000000000001',
  'website',
  'website',
  'https://example.test'
);

insert into internal.source_listings (
  id,
  retailer_source_id,
  source_key,
  source_url,
  first_seen_at,
  last_seen_at,
  last_checked_at
)
values (
  '00000000-0000-0000-0000-000000000003',
  '00000000-0000-0000-0000-000000000002',
  'listing-1',
  'https://example.test/product/1',
  '2026-08-10 10:00:00+00',
  '2026-08-10 11:00:00+00',
  '2026-08-10 11:00:00+00'
);

insert into internal.source_listing_observations (
  id,
  source_listing_id,
  observed_at,
  parse_status
)
values (
  '00000000-0000-0000-0000-000000000004',
  '00000000-0000-0000-0000-000000000003',
  '2026-08-10 11:00:00+00',
  'parsed'
);

insert into public.product_families (
  id,
  category,
  brand,
  brand_normalized,
  model_name,
  model_normalized,
  display_name
)
values (
  '00000000-0000-0000-0000-000000000005',
  'smartphone',
  'Example',
  'example',
  'Phone Pro',
  'phone pro',
  'Example Phone Pro'
);

insert into public.product_variants (
  id,
  family_id,
  variant_key,
  display_name
)
values (
  '00000000-0000-0000-0000-000000000006',
  '00000000-0000-0000-0000-000000000005',
  '256gb',
  'Example Phone Pro 256 GB'
);

insert into public.offers (
  id,
  variant_id,
  retailer_id,
  source_listing_id,
  current_comparable_price,
  currency_code,
  availability_status,
  last_observed_at
)
values (
  '00000000-0000-0000-0000-000000000007',
  '00000000-0000-0000-0000-000000000006',
  '00000000-0000-0000-0000-000000000001',
  '00000000-0000-0000-0000-000000000003',
  10000.00,
  'MDL',
  'in_stock',
  '2026-08-10 11:00:00+00'
);

-- ------------------------------------------------------------
-- Price integrity
-- ------------------------------------------------------------

select throws_ok(
  $$
    insert into public.price_observations (
      offer_id,
      source_listing_observation_id,
      observed_at,
      comparable_price,
      currency_code
    )
    values (
      '00000000-0000-0000-0000-000000000007',
      '00000000-0000-0000-0000-000000000004',
      now(),
      0,
      'MDL'
    )
  $$,
  '23514',
  null,
  'price observations must reject zero comparable prices'
);

select throws_ok(
  $$
    update public.offers
    set current_comparable_price = -1
    where id = '00000000-0000-0000-0000-000000000007'
  $$,
  '23514',
  null,
  'offers must reject negative comparable prices'
);

select throws_ok(
  $$
    update public.offers
    set currency_code = 'mdl'
    where id = '00000000-0000-0000-0000-000000000007'
  $$,
  '23514',
  null,
  'currency codes must be three uppercase characters'
);

-- ------------------------------------------------------------
-- Matching integrity
-- ------------------------------------------------------------

select throws_ok(
  $$
    insert into internal.product_match_records (
      source_listing_id,
      variant_id,
      status,
      method,
      confidence,
      decided_at
    )
    values (
      '00000000-0000-0000-0000-000000000003',
      '00000000-0000-0000-0000-000000000006',
      'matched',
      'manual',
      1.5,
      now()
    )
  $$,
  '23514',
  null,
  'matching confidence must reject values greater than one'
);

select throws_ok(
  $$
    insert into internal.product_match_records (
      source_listing_id,
      status
    )
    values (
      '00000000-0000-0000-0000-000000000003',
      'matched'
    )
  $$,
  '23514',
  null,
  'matched records must require a variant, method, and decision time'
);

-- ------------------------------------------------------------
-- Source provenance integrity
-- ------------------------------------------------------------

select throws_ok(
  $$
    insert into internal.source_listings (
      retailer_source_id,
      source_key,
      source_url,
      first_seen_at,
      last_seen_at,
      last_checked_at
    )
    values (
      '00000000-0000-0000-0000-000000000002',
      'invalid-time-order',
      'https://example.test/product/invalid',
      '2026-08-10 12:00:00+00',
      '2026-08-10 11:00:00+00',
      '2026-08-10 12:00:00+00'
    )
  $$,
  '23514',
  null,
  'source listings must reject last_seen before first_seen'
);

select throws_ok(
  $$
    insert into internal.crawl_runs (
      retailer_source_id,
      status,
      started_at,
      finished_at
    )
    values (
      '00000000-0000-0000-0000-000000000002',
      'failed',
      '2026-08-10 12:00:00+00',
      '2026-08-10 11:00:00+00'
    )
  $$,
  '23514',
  null,
  'crawl runs must reject finished_at before started_at'
);

-- ------------------------------------------------------------
-- Valid history still works
-- ------------------------------------------------------------

select lives_ok(
  $$
    insert into public.price_observations (
      offer_id,
      source_listing_observation_id,
      observed_at,
      comparable_price,
      currency_code,
      availability_status,
      quality_status
    )
    values (
      '00000000-0000-0000-0000-000000000007',
      '00000000-0000-0000-0000-000000000004',
      '2026-08-10 11:00:00+00',
      9999.00,
      'MDL',
      'in_stock',
      'accepted'
    )
  $$,
  'valid accepted price observations should be insertable'
);

select * from finish();

rollback;