CREATE TABLE "public"."social_media_profiles" ("id" bigserial NOT NULL, "social_media_type" social_media_enum NOT NULL, "social_media_link" text NOT NULL, "business_id" bigint, "store_id" bigint, "is_active" boolean NOT NULL DEFAULT true, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("business_id") REFERENCES "public"."business"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("store_id") REFERENCES "public"."stores"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."social_media_profiles" IS E'List of all social media profiles for Business and Stores';
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
CREATE TRIGGER "set_public_social_media_profiles_updated_at"
BEFORE UPDATE ON "public"."social_media_profiles"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_social_media_profiles_updated_at" ON "public"."social_media_profiles" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
