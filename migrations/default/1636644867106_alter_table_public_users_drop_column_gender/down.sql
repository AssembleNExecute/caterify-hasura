comment on column "public"."users"."gender" is E'List of all users';
alter table "public"."users" alter column "gender" drop not null;
alter table "public"."users" add column "gender" text;
