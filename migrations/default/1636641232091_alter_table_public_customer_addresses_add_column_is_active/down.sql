-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."customer_addresses" add column "is_active" boolean
--  not null default 'true';

alter table "public"."customer_addresses" drop column "is_active";