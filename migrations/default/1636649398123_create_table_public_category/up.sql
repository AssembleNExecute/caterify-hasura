CREATE TABLE "public"."category" ("id" bigserial NOT NULL, "name" text NOT NULL, "photo" text, "description" text, "store_id" bigint NOT NULL, "is_active" boolean NOT NULL DEFAULT true, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("store_id") REFERENCES "public"."stores"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."category" IS E'List of all categories';
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
CREATE TRIGGER "set_public_category_updated_at"
BEFORE UPDATE ON "public"."category"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_category_updated_at" ON "public"."category" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
