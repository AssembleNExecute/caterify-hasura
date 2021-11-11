CREATE TABLE "public"."items" ("id" bigserial NOT NULL, "name" text NOT NULL, "description" text, "image" Text, "store_id" bigint NOT NULL, "category_id" bigint NOT NULL, "quantity" text, "actual_price" text, "selling_price" text NOT NULL, "calories" text, "is_active" boolean NOT NULL DEFAULT true, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("category_id") REFERENCES "public"."category"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("store_id") REFERENCES "public"."stores"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."items" IS E'List of all items';
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
CREATE TRIGGER "set_public_items_updated_at"
BEFORE UPDATE ON "public"."items"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_items_updated_at" ON "public"."items" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
