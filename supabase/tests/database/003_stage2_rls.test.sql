begin;

select plan(8);

-- ------------------------------------------------------------
-- Fixtures created as postgres
-- ------------------------------------------------------------

insert into public.retailers (
  id,
  slug,
  name,
  status
)
values
(
  '10000000-0000-0000-0000-000000000001',
  'active-retailer',
  'Active Retailer',
  'active'
),
(
  '10000000-0000-0000-0000-000000000002',
  'inactive-retailer',
  'Inactive Retailer',
  'inactive'
);

insert into internal.retailer_sources (
  id,
  retailer_id,
  source_key,
  source_type
)
values (
  '10000000-0000-0000-0000-000000000003',
  '10000000-0000-0000-0000-000000000001',
  'website',
  'website'
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
  '10000000-0000-0000-0000-000000000004',
  '10000000-0000-0000-0000-000000000003',
  'listing',
  'https://example.test/listing',
  now(),
  now(),
  now()
);


insert into internal.source_listing_observations (
  id,
  source_listing_id,
  observed_at,
  parse_status
)
values
(
  '10000000-0000-0000-0000-000000000005',
  '10000000-0000-0000-0000-000000000004',
  now(),
  'parsed'
),
(
  '10000000-0000-0000-0000-000000000006',
  '10000000-0000-0000-0000-000000000004',
  now(),
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
  '10000000-0000-0000-0000-000000000007',
  'smartphone',
  'Example',
  'example',
  'Phone',
  'phone',
  'Example Phone'
);


insert into public.product_variants (
  id,
  family_id,
  variant_key,
  display_name
)
values (
  '10000000-0000-0000-0000-000000000008',
  '10000000-0000-0000-0000-000000000007',
  'base',
  'Example Phone'
);


insert into public.offers (
  id,
  variant_id,
  retailer_id,
  source_listing_id,
  current_comparable_price,
  currency_code,
  status
)
values (
  '10000000-0000-0000-0000-000000000009',
  '10000000-0000-0000-0000-000000000008',
  '10000000-0000-0000-0000-000000000001',
  '10000000-0000-0000-0000-000000000004',
  10000,
  'MDL',
  'active'
);


insert into public.price_observations (
  offer_id,
  source_listing_observation_id,
  observed_at,
  comparable_price,
  currency_code,
  quality_status
)
values
(
  '10000000-0000-0000-0000-000000000009',
  '10000000-0000-0000-0000-000000000005',
  now(),
  9999,
  'MDL',
  'accepted'
),
(
  '10000000-0000-0000-0000-000000000009',
  '10000000-0000-0000-0000-000000000006',
  now(),
  1,
  'MDL',
  'suspicious'
);


-- ------------------------------------------------------------
-- anon role
-- ------------------------------------------------------------

set local role anon;

select results_eq(
  $$
    select count(*)::bigint
    from public.retailers
  $$,
  array[1::bigint],
  'anon should see only active retailers'
);

select results_eq(
  $$
    select count(*)::bigint
    from public.price_observations
  $$,
  array[1::bigint],
  'anon should see only accepted price observations'
);

select throws_ok(
  $$
    insert into public.retailers (
      slug,
      name
    )
    values (
      'forbidden',
      'Forbidden'
    )
  $$,
  '42501',
  null,
  'anon must not insert public data'
);

select throws_ok(
  $$
    update public.offers
    set current_comparable_price = 5000
  $$,
  '42501',
  null,
  'anon must not update offers'
);

select throws_ok(
  $$
    select *
    from internal.source_listings
  $$,
  '42501',
  null,
  'anon must not access internal source listings'
);


-- ------------------------------------------------------------
-- authenticated role
-- ------------------------------------------------------------

reset role;
set local role authenticated;

select results_eq(
  $$
    select count(*)::bigint
    from public.retailers
  $$,
  array[1::bigint],
  'authenticated should currently have the same public read boundary'
);

select throws_ok(
  $$
    delete from public.offers
  $$,
  '42501',
  null,
  'authenticated must not delete offers'
);

select throws_ok(
  $$
    select *
    from internal.product_match_records
  $$,
  '42501',
  null,
  'authenticated must not access internal matching records'
);

reset role;

select * from finish();

rollback;