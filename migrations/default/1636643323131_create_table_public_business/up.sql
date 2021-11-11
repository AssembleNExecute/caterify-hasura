CREATE TABLE "public"."business" ("id" bigserial NOT NULL, "name" text NOT NULL, "phone_number" text NOT NULL, "email" text, "logo_url" text, "website" text, "description" text, "fssai_certificate" text NOT NULL, "photos" jsonb DEFAULT jsonb_build_array(), "cost" text NOT NULL, "business_owner_id" bigint, "is_closed" boolean NOT NULL DEFAULT false, "is_active" boolean NOT NULL DEFAULT true, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("business_owner_id") REFERENCES "public"."users"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."business" IS E'List of all Businesses';
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
CREATE TRIGGER "set_public_business_updated_at"
BEFORE UPDATE ON "public"."business"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_business_updated_at" ON "public"."business" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
