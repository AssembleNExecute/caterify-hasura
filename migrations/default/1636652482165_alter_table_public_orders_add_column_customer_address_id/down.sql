-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."orders" add column "customer_address_id" bigint
--  not null;

alter table "public"."orders" drop column "customer_address_id";
