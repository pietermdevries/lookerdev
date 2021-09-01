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

#########################

explore: parameter_sql_dt {}
include: "/3_snowflake/events.view"
view: parameter_sql_dt {
  extends: [events]
  derived_table: {
    sql:
      SELECT *
      FROM
        "PUBLIC"."EVENTS"
      WHERE
        "CREATED_AT" >= {{ parameter_sql_dt.event_start_date_selector._parameter_value }}
        and
        "CREATED_AT" < {{ parameter_sql_dt.event_end_date_selector._parameter_value }}
      ;;
  }

  parameter: event_start_date_selector {
    type: date_time
    description: "Use this field to select a start date of the event"
  }
  parameter: event_end_date_selector {
    type: date_time
    description: "Use this field to select a end date of the event"
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
