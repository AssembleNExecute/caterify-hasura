CREATE TABLE "public"."stores" ("id" bigserial NOT NULL, "name" text NOT NULL, "business_id" bigint NOT NULL, "description" text, "logo_url" text, "photos" jsonb DEFAULT jsonb_build_array(), "store_owner_id" bigint NOT NULL, "address_line_1" text NOT NULL, "address_line_2" text, "landmark" text, "directions" text, "city" text NOT NULL, "state" text NOT NULL, "country" text NOT NULL, "pincode" text NOT NULL, "geo_location" jsonb NOT NULL DEFAULT jsonb_build_object(), "email" text, "phone_number" text NOT NULL, "website" text, "is_closed" boolean NOT NULL DEFAULT false, "is_active" boolean NOT NULL DEFAULT true, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("store_owner_id") REFERENCES "public"."users"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("business_id") REFERENCES "public"."business"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."stores" IS E'List of all Stores';
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
CREATE TRIGGER "set_public_stores_updated_at"
BEFORE UPDATE ON "public"."stores"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_stores_updated_at" ON "public"."stores" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
