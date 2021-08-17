explore: test_param_yesno {}
include: "/3_snowflake/events.view"
view: test_param_yesno {
  extends: [events]
  derived_table: {
    sql:
      SELECT *
      FROM
      {% if choose_table._parameter_value == "first_table" %}
        "PUBLIC"."EVENTS"
      {% else %}
        "somethingelse"
      {% endif %}
      ;;
  }

  parameter: choose_table {
    type: unquoted
    allowed_value: {
      value: "first_table"
    }
    allowed_value: {
      value: "second_table"
    }
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
