view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: TO_TIMESTAMP_TZ(CONCAT(RTRIM(${TABLE}."CREATED_AT", 'Z'), ' -100')) ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  parameter: months_back {
    type: number
    default_value: "1"
  }

  dimension: date_range_test {
    type: yesno
    sql:
    (date_part(day,${delivered_date}::date) >= 25 AND
    {% if months_back._parameter_value == 1 %}
    date_part(month,${delivered_date}::date) = date_part(month,add_months(current_timestamp,-1))
    {% else %}
    date_part(month,${delivered_date}::date) BETWEEN date_part(month,add_months(current_timestamp,-1)) AND date_part(month,add_months(current_timestamp,-{{ months_back._parameter_value }}))
    {% endif %}
    )
    OR
    (date_part(day,${delivered_date}::date)<25 AND date_part(month,${delivered_date}::date) = date_part(month,current_timestamp))
    ;;
  # (extract_days(${products.service_datetime_date}) >= 25
  #   AND extract_months(${products.service_datetime_date}) = extract_months(add_months(-1, now())))
  # OR
  # (extract_days(${products.service_datetime_date}) < 25
  #   AND extract_months(${products.service_datetime_date}) = extract_months(now()))
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RETURNED_AT" ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.first_name,
      users.last_name,
      users.id,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
explore: order_items {}
explore: order_sales {
  # join: order_status {
  #   sql_on: ${order_sales.date_date} = ${order_status.date_date} ;;
  #   relationship: many_to_many
  # }
}
view: order_sales {
  derived_table: {
    sql:
    SELECT
    "SHIPPED_AT",
    "SALE_PRICE",
    "STATUS"
    FROM "PUBLIC"."ORDER_ITEMS"
    WHERE {% condition status_filter %} "STATUS" {% endcondition%} ;;
  }

  filter: status_filter {
    type: string
    # suggest_explore: order_sales
    suggest_dimension: status
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
    link: {
      label: "clickme"
      url: "/dashboards/268?test={{ order_sales.date_date._value | url_encode }} to {{ order_sales.date_month._value | url_encode }}"
    }
  }


  measure: sales {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sales {
    type: average
    sql: ${sale_price} ;;
  }
}

# view: order_status {
#   derived_table: {
#     sql:
#     SELECT
#     "SHIPPED_AT",
#     "STATUS"
#     FROM "PUBLIC"."ORDER_ITEMS" ;;
#   }

#   dimension: status {
#     type: string
#     sql: ${TABLE}."STATUS" ;;
#   }

#   dimension_group: date {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}."SHIPPED_AT" ;;
#   }
#}
