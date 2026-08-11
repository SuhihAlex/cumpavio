\set ON_ERROR_STOP on

begin;

-- Stage 3 proof data is intentionally isolated in one transaction.
-- The transaction MUST be rolled back at the end.

insert into public.retailers (
  id,
  slug,
  name,
  website_url,
  status
)
values (
  '03000000-0000-4000-8000-000000000001',
  'ultra-stage3-proof',
  'Ultra',
  'https://ultra.md',
  'active'
);

insert into internal.retailer_sources (
  id,
  retailer_id,
  source_key,
  source_type,
  base_url,
  status
)
values (
  '03000000-0000-4000-8000-000000000002',
  '03000000-0000-4000-8000-000000000001',
  'ultra-public-website-stage3-proof',
  'website',
  'https://ultra.md',
  'active'
);

insert into internal.crawl_runs (
  id,
  retailer_source_id,
  status,
  trigger_kind,
  crawler_version,
  parser_version,
  started_at,
  finished_at,
  stats
)
values (
  '03000000-0000-4000-8000-000000000003',
  '03000000-0000-4000-8000-000000000002',
  'succeeded',
  'stage3_manual_proof',
  'stage3-proof-0.2',
  'ultra-proof-0.2',
  now(),
  now(),
  jsonb_build_object(
    'sample_count', 2,
    'categories', jsonb_build_array(
      'laptop',
      'smartphone'
    ),
    'passed', true
  )
);

-- -------------------------------------------------------------------------
-- Source listings
-- -------------------------------------------------------------------------

insert into internal.source_listings (
  id,
  retailer_source_id,
  source_key,
  external_id,
  source_url,
  status,
  first_seen_at,
  last_seen_at,
  last_checked_at
)
values
(
  '03000000-0000-4000-8000-000000000011',
  '03000000-0000-4000-8000-000000000002',
  'ultra:262576',
  '262576',
  'https://ultra.md/tehnica-computer/laptopuri/lenovo-ideapad-pro-5-16akp10-16-120-hz-24-gb-512-gb-amd-ryzen-ai-7-350-fara-so-grey',
  'active',
  now(),
  now(),
  now()
),
(
  '03000000-0000-4000-8000-000000000012',
  '03000000-0000-4000-8000-000000000002',
  'ultra:145518',
  '145518',
  'https://ultra.md/product/iphone-14-128gb-midnight-md',
  'active',
  now(),
  now(),
  now()
);

-- -------------------------------------------------------------------------
-- Source observations
-- -------------------------------------------------------------------------

insert into internal.source_listing_observations (
  id,
  source_listing_id,
  crawl_run_id,
  observed_at,
  parse_status,
  parser_version,
  title_raw,
  raw_price_text,
  raw_availability_text,
  raw_identifiers,
  extracted_attributes,
  source_payload
)
values
(
  '03000000-0000-4000-8000-000000000021',
  '03000000-0000-4000-8000-000000000011',
  '03000000-0000-4000-8000-000000000003',
  now(),
  'parsed',
  'ultra-proof-0.2',
  'Laptop Lenovo IdeaPad Pro 5 16AKP10 Grey',
  '29 990 lei',
  'În stoc: success; În showroom: danger',
  jsonb_build_object(
    'cod_produs', '262576',
    'articol', '83JN0047RK'
  ),
  jsonb_build_object(
    'category', 'laptop',
    'model', 'IdeaPad Pro 5 16AKP10',
    'display_size', '16"',
    'display_type', 'OLED',
    'refresh_rate_hz', 120,
    'ram_gb', 24,
    'storage_gb', 512,
    'processor', 'AMD Ryzen AI 7 350',
    'online_in_stock', true,
    'showroom_in_stock', false
  ),
  jsonb_build_object(
    'retailer', 'Ultra',
    'visible_price', 29990,
    'json_ld_price', 29990,
    'currency', 'MDL',
    'json_ld_availability', 'https://schema.org/InStock',
    'can_add_to_cart', true,
    'notify_when_available', false,
    'visible_json_ld_availability_disagreement', false
  )
),
(
  '03000000-0000-4000-8000-000000000022',
  '03000000-0000-4000-8000-000000000012',
  '03000000-0000-4000-8000-000000000003',
  now(),
  'parsed',
  'ultra-proof-0.2',
  'Smartphone Apple iPhone 14 Midnight',
  '11 999 lei',
  'În stoc: danger; În showroom: danger; Notifică când este disponibil',
  jsonb_build_object(
    'cod_produs', '145518',
    'articol', 'MPUF3RX/A'
  ),
  jsonb_build_object(
    'category', 'smartphone',
    'model', 'iPhone 14',
    'ram_gb', 6,
    'storage_gb', 128,
    'display_size', '6.1"',
    'refresh_rate_hz', 60,
    'battery_mah', 3279,
    'color', 'Midnight',
    'online_in_stock', false,
    'showroom_in_stock', false
  ),
  jsonb_build_object(
    'retailer', 'Ultra',
    'visible_price', 11999,
    'json_ld_price', 11999,
    'currency', 'MDL',
    'json_ld_availability', 'https://schema.org/InStock',
    'can_add_to_cart', false,
    'notify_when_available', true,
    'visible_json_ld_availability_disagreement', true
  )
);

-- -------------------------------------------------------------------------
-- Controlled canonical records
--
-- These records do NOT represent an automated matching engine.
-- They exist only to prove that a manually controlled Stage 3 association
-- can traverse the Stage 2 persistence model.
-- -------------------------------------------------------------------------

insert into public.product_families (
  id,
  category,
  brand,
  brand_normalized,
  model_name,
  model_normalized,
  display_name,
  status
)
values
(
  '03000000-0000-4000-8000-000000000031',
  'laptop',
  'Lenovo',
  'lenovo',
  'IdeaPad Pro 5 16AKP10',
  'ideapad pro 5 16akp10',
  'Lenovo IdeaPad Pro 5 16AKP10',
  'active'
),
(
  '03000000-0000-4000-8000-000000000032',
  'smartphone',
  'Apple',
  'apple',
  'iPhone 14',
  'iphone 14',
  'Apple iPhone 14',
  'active'
);

insert into public.product_variants (
  id,
  family_id,
  variant_key,
  display_name,
  attributes,
  status
)
values
(
  '03000000-0000-4000-8000-000000000041',
  '03000000-0000-4000-8000-000000000031',
  '83jn0047rk',
  'Lenovo IdeaPad Pro 5 16AKP10 / 24 GB / 512 GB / 83JN0047RK',
  jsonb_build_object(
    'article_identifier', '83JN0047RK',
    'ram_gb', 24,
    'storage_gb', 512,
    'processor', 'AMD Ryzen AI 7 350'
  ),
  'active'
),
(
  '03000000-0000-4000-8000-000000000042',
  '03000000-0000-4000-8000-000000000032',
  'mpuf3rx-a',
  'Apple iPhone 14 / 128 GB / Midnight / MPUF3RX/A',
  jsonb_build_object(
    'article_identifier', 'MPUF3RX/A',
    'storage_gb', 128,
    'color', 'Midnight'
  ),
  'active'
);

-- -------------------------------------------------------------------------
-- Explicit manual match decisions
-- -------------------------------------------------------------------------

insert into internal.product_match_records (
  id,
  source_listing_id,
  variant_id,
  status,
  method,
  confidence,
  evidence,
  decided_at
)
values
(
  '03000000-0000-4000-8000-000000000051',
  '03000000-0000-4000-8000-000000000011',
  '03000000-0000-4000-8000-000000000041',
  'matched',
  'manual',
  1.0000,
  jsonb_build_object(
    'stage', 3,
    'proof', true,
    'reason', 'Controlled manual association for persistence proof',
    'source_product_id', '262576',
    'article_identifier', '83JN0047RK'
  ),
  now()
),
(
  '03000000-0000-4000-8000-000000000052',
  '03000000-0000-4000-8000-000000000012',
  '03000000-0000-4000-8000-000000000042',
  'matched',
  'manual',
  1.0000,
  jsonb_build_object(
    'stage', 3,
    'proof', true,
    'reason', 'Controlled manual association for persistence proof',
    'source_product_id', '145518',
    'article_identifier', 'MPUF3RX/A'
  ),
  now()
);

-- -------------------------------------------------------------------------
-- Current offers
-- -------------------------------------------------------------------------

insert into public.offers (
  id,
  variant_id,
  retailer_id,
  source_listing_id,
  current_comparable_price,
  currency_code,
  availability_status,
  status,
  last_observed_at
)
values
(
  '03000000-0000-4000-8000-000000000061',
  '03000000-0000-4000-8000-000000000041',
  '03000000-0000-4000-8000-000000000001',
  '03000000-0000-4000-8000-000000000011',
  29990.00,
  'MDL',
  'in_stock',
  'active',
  now()
),
(
  '03000000-0000-4000-8000-000000000062',
  '03000000-0000-4000-8000-000000000042',
  '03000000-0000-4000-8000-000000000001',
  '03000000-0000-4000-8000-000000000012',
  11999.00,
  'MDL',
  'out_of_stock',
  'active',
  now()
);

-- -------------------------------------------------------------------------
-- Price observations
-- -------------------------------------------------------------------------

insert into public.price_observations (
  id,
  offer_id,
  source_listing_observation_id,
  observed_at,
  comparable_price,
  currency_code,
  availability_status,
  quality_status,
  quality_reason
)
values
(
  '03000000-0000-4000-8000-000000000071',
  '03000000-0000-4000-8000-000000000061',
  '03000000-0000-4000-8000-000000000021',
  now(),
  29990.00,
  'MDL',
  'in_stock',
  'accepted',
  'Stage 3 proof: scoped visible comparable price matches JSON-LD price'
),
(
  '03000000-0000-4000-8000-000000000072',
  '03000000-0000-4000-8000-000000000062',
  '03000000-0000-4000-8000-000000000022',
  now(),
  11999.00,
  'MDL',
  'out_of_stock',
  'accepted',
  'Stage 3 proof: price is valid; visible availability overrides conflicting JSON-LD availability'
);

-- -------------------------------------------------------------------------
-- Assertions
-- -------------------------------------------------------------------------

do $$
declare
  source_listing_count integer;
  observation_count integer;
  match_count integer;
  offer_count integer;
  price_observation_count integer;
begin
  select count(*)
  into source_listing_count
  from internal.source_listings
  where id in (
    '03000000-0000-4000-8000-000000000011',
    '03000000-0000-4000-8000-000000000012'
  );

  select count(*)
  into observation_count
  from internal.source_listing_observations
  where id in (
    '03000000-0000-4000-8000-000000000021',
    '03000000-0000-4000-8000-000000000022'
  );

  select count(*)
  into match_count
  from internal.product_match_records
  where id in (
    '03000000-0000-4000-8000-000000000051',
    '03000000-0000-4000-8000-000000000052'
  )
  and status = 'matched'
  and method = 'manual';

  select count(*)
  into offer_count
  from public.offers
  where id in (
    '03000000-0000-4000-8000-000000000061',
    '03000000-0000-4000-8000-000000000062'
  );

  select count(*)
  into price_observation_count
  from public.price_observations
  where id in (
    '03000000-0000-4000-8000-000000000071',
    '03000000-0000-4000-8000-000000000072'
  )
  and quality_status = 'accepted';

  if source_listing_count <> 2 then
    raise exception
      'Expected 2 source listings, found %',
      source_listing_count;
  end if;

  if observation_count <> 2 then
    raise exception
      'Expected 2 source observations, found %',
      observation_count;
  end if;

  if match_count <> 2 then
    raise exception
      'Expected 2 controlled manual matches, found %',
      match_count;
  end if;

  if offer_count <> 2 then
    raise exception
      'Expected 2 offers, found %',
      offer_count;
  end if;

  if price_observation_count <> 2 then
    raise exception
      'Expected 2 accepted price observations, found %',
      price_observation_count;
  end if;
end
$$;

-- -------------------------------------------------------------------------
-- Proof output before rollback
-- -------------------------------------------------------------------------

select
  pf.category,
  pv.display_name as canonical_variant,
  sl.external_id as source_product_id,
  slo.raw_price_text,
  o.current_comparable_price,
  o.currency_code,
  o.availability_status,
  po.quality_status,
  pmr.method as match_method
from public.offers o
join public.product_variants pv
  on pv.id = o.variant_id
join public.product_families pf
  on pf.id = pv.family_id
join internal.source_listings sl
  on sl.id = o.source_listing_id
join internal.source_listing_observations slo
  on slo.source_listing_id = sl.id
join public.price_observations po
  on po.offer_id = o.id
  and po.source_listing_observation_id = slo.id
join internal.product_match_records pmr
  on pmr.source_listing_id = sl.id
  and pmr.variant_id = pv.id
  and pmr.superseded_at is null
where o.id in (
  '03000000-0000-4000-8000-000000000061',
  '03000000-0000-4000-8000-000000000062'
)
order by pf.category;

rollback;

-- -------------------------------------------------------------------------
-- Rollback verification
-- -------------------------------------------------------------------------

select count(*) as proof_rows_after_rollback
from public.retailers
where id = '03000000-0000-4000-8000-000000000001';