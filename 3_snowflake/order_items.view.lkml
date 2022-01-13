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
      year,
      month_num,
      week_of_year
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
    suggest_explore: users
    suggest_dimension: users.gender
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
