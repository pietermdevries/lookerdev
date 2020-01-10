view: smedt {
  derived_table: {
    sql: SELECT
        created_at,
        status
      FROM orders
      WHERE {% condition date_filter %} created_at {% endcondition %}
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension_group: created {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_at ;;

  }

  dimension: date_formatted {
    label: "Date_formatted"
    sql: ${created_date} ;;
    html:
    {% if _filters[region._value] == 'EU' %}
    {{ rendered_value | date: "%m/%d/%y" }}
    {% elsif _filters[region._value] == 'US' %}
    {{ rendered_value | date: "%d/%m/%y" }}
    {% else %}
    Who are you?
    {% endif %};;
    }

  filter: date_filter {
    type: date
  }

  filter: region {
    type: string
    suggestions: ["US","EU"]
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

}
