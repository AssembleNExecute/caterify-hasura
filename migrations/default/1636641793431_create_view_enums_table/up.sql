CREATE
OR REPLACE VIEW "public"."view_enums" AS
SELECT
  t.typname AS enum_label,
  e.enumsortorder AS enum_order,
  e.enumlabel AS enum_value
FROM
  (
    (
      pg_type t
      JOIN pg_enum e ON ((t.oid = e.enumtypid))
    )
    JOIN pg_namespace n ON ((n.oid = t.typnamespace))
  )
ORDER BY
  t.typname,
  e.enumsortorder;
