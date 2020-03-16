view: smedt {
  derived_table: {
    sql: SELECT
        orders.created_at,
        status,
        country
      FROM orders
      JOIN users on orders.user_id = users.id
      WHERE {% condition date_filter %} orders.created_at {% endcondition %}
      AND {% condition region_filter %} users.country {% endcondition %}

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
    {% if _filters[smedt.region._value] == 'EU' %}
    {{ rendered_value | date: "%m/%d/%y" }}
    {% elsif _filters[smedt.region._value] == 'USA' %}
    {{ rendered_value | date: "%d/%m/%y" }}
    {% else %}
    {{value}}
    {% endif %};;
    }

  filter: date_filter {
    type: date
  }

  dimension: region {
    type: string
    sql: ${TABLE}.country ;;
  }

  filter: region_filter {
    type: string
    suggestions: ["USA","EU"]
    sql: ${region} ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

}
