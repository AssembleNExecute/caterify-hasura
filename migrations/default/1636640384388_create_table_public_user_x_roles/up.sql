CREATE TABLE "public"."user_x_roles" ("id" bigserial NOT NULL, "user_id" bigint NOT NULL, "role_id" integer NOT NULL, "is_active" boolean NOT NULL DEFAULT true, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("role_id") REFERENCES "public"."roles"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."user_x_roles" IS E'Allowed Roles for an User';
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
CREATE TRIGGER "set_public_user_x_roles_updated_at"
BEFORE UPDATE ON "public"."user_x_roles"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_user_x_roles_updated_at" ON "public"."user_x_roles" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
