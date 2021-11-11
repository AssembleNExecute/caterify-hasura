CREATE TABLE "public"."orders" ("id" bigserial NOT NULL, "order_id" text, "store_id" bigint NOT NULL, "customer_id" bigint NOT NULL, "status" order_status NOT NULL, "bill_amount" float8 NOT NULL, "total_amount" float8 NOT NULL, "is_paid" boolean NOT NULL DEFAULT false, "is_active" boolean NOT NULL DEFAULT true, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("store_id") REFERENCES "public"."stores"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("customer_id") REFERENCES "public"."users"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."orders" IS E'List of all orders';
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_orders_updated_at"
BEFORE UPDATE ON "public"."orders"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_orders_updated_at" ON "public"."orders" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
