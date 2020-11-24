explore: extend_events {}
include: "/3_snowflake/events.view"
view: extend_events {
extends: [events]
derived_table: {
  sql:
  SELECT *
  FROM "PUBLIC"."EVENTS";;
}

}
