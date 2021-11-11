CREATE TABLE "public"."customer_addresses" ("id" bigserial NOT NULL, "user_id" bigint NOT NULL, "address_line_1" text NOT NULL, "address_line_2" text, "city" text NOT NULL, "state" text NOT NULL, "pincode" text NOT NULL, "country" text NOT NULL, "directions" text, "landmark" text, "display_name" text NOT NULL, "geo_location" jsonb NOT NULL DEFAULT jsonb_build_object(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."customer_addresses" IS E'Saved address for customers';
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
CREATE TRIGGER "set_public_customer_addresses_updated_at"
BEFORE UPDATE ON "public"."customer_addresses"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_customer_addresses_updated_at" ON "public"."customer_addresses" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
