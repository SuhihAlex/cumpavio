begin;

select plan(22);

-- Schemas

select has_schema(
  'internal',
  'internal schema should exist'
);

-- Public/canonical tables

select has_table(
  'public',
  'retailers',
  'public.retailers should exist'
);

select has_table(
  'public',
  'product_families',
  'public.product_families should exist'
);

select has_table(
  'public',
  'product_variants',
  'public.product_variants should exist'
);

select has_table(
  'public',
  'product_variant_identifiers',
  'public.product_variant_identifiers should exist'
);

select has_table(
  'public',
  'offers',
  'public.offers should exist'
);

select has_table(
  'public',
  'price_observations',
  'public.price_observations should exist'
);

-- Internal/source tables

select has_table(
  'internal',
  'retailer_sources',
  'internal.retailer_sources should exist'
);

select has_table(
  'internal',
  'crawl_runs',
  'internal.crawl_runs should exist'
);

select has_table(
  'internal',
  'source_listings',
  'internal.source_listings should exist'
);

select has_table(
  'internal',
  'source_listing_observations',
  'internal.source_listing_observations should exist'
);

select has_table(
  'internal',
  'product_match_records',
  'internal.product_match_records should exist'
);

-- Primary keys

select col_is_pk(
  'public',
  'retailers',
  'id',
  'retailers.id should be the primary key'
);

select col_is_pk(
  'public',
  'product_families',
  'id',
  'product_families.id should be the primary key'
);

select col_is_pk(
  'public',
  'product_variants',
  'id',
  'product_variants.id should be the primary key'
);

select col_is_pk(
  'public',
  'offers',
  'id',
  'offers.id should be the primary key'
);

select col_is_pk(
  'public',
  'price_observations',
  'id',
  'price_observations.id should be the primary key'
);

-- Critical relationships

select fk_ok(
  'public',
  'product_variants',
  'family_id',
  'public',
  'product_families',
  'id',
  'product_variants.family_id should reference product_families.id'
);

select fk_ok(
  'internal',
  'source_listings',
  'retailer_source_id',
  'internal',
  'retailer_sources',
  'id',
  'source_listings.retailer_source_id should reference retailer_sources.id'
);

select fk_ok(
  'public',
  'offers',
  'variant_id',
  'public',
  'product_variants',
  'id',
  'offers.variant_id should reference product_variants.id'
);

select fk_ok(
  'public',
  'offers',
  'source_listing_id',
  'internal',
  'source_listings',
  'id',
  'offers.source_listing_id should reference source_listings.id'
);

select fk_ok(
  'public',
  'price_observations',
  'source_listing_observation_id',
  'internal',
  'source_listing_observations',
  'id',
  'price_observations.source_listing_observation_id should reference source_listing_observations.id'
);

select * from finish();

rollback;