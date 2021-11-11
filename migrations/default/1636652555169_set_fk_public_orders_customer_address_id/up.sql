alter table "public"."orders"
  add constraint "orders_customer_address_id_fkey"
  foreign key ("customer_address_id")
  references "public"."customer_addresses"
  ("id") on update restrict on delete restrict;
