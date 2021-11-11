CREATE TABLE "public"."discounts" ("id" bigserial NOT NULL, "name" text NOT NULL, "description" text, "code" text NOT NULL, "discount_percentage" float8 NOT NULL, "image" text, "start_date" Timestamp NOT NULL DEFAULT now(), "end_date" Timestamp NOT NULL DEFAULT now(), "store_id" bigint NOT NULL, "is_active" boolean NOT NULL DEFAULT true, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("store_id") REFERENCES "public"."stores"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."discounts" IS E'List of all discounts';
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
CREATE TRIGGER "set_public_discounts_updated_at"
BEFORE UPDATE ON "public"."discounts"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_discounts_updated_at" ON "public"."discounts" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
