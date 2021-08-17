explore: extend_events {}
include: "/3_snowflake/events.view"
view: extend_events {
extends: [events]
derived_table: {
  sql:
  SELECT *
  FROM
  {% assign date_param = date_start date_filter%}
  {% assign current_date = 'today' %}
  {% if date_param | date: "%Y-%m-%d" == current_date | date: "%Y-%m-%d"%}
    "PUBLIC"."EVENTS"
  {% else %}
    {{date_param | date: "%Y-%m-%d"}} and {{current_date | date: "%Y-%m-%d"}}
  {% endif %}
  ;;
}

filter: date_filter {
  type: date
}

dimension: display_filter {
  type: date
  sql: {% date_start date_filter | date: "%Y-%m-%d"  %} ;;
}

dimension: display_current_date {
  type: date
  sql: {{ 'now' | date: "%Y-%m-%d" }} ;;
}

}
