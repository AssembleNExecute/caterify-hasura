CREATE TABLE "public"."order_x_taxes" ("id" bigserial NOT NULL, "order_id" bigint NOT NULL, "tax_id" bigint NOT NULL, "tax_amount" float8 NOT NULL, "is_active" boolean NOT NULL DEFAULT true, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("tax_id") REFERENCES "public"."taxes"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."order_x_taxes" IS E'List of all taxes for orders';
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
CREATE TRIGGER "set_public_order_x_taxes_updated_at"
BEFORE UPDATE ON "public"."order_x_taxes"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_order_x_taxes_updated_at" ON "public"."order_x_taxes" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
