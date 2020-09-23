view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      year,
      fiscal_month_num
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: is_null_dimension {
    type: string
    sql: CASE WHEN ${sale_price} > 10 THEN "is_null"
         ELSE "not_null"
         END;;
  }

  dimension: is_last_day {
    type: yesno
    sql: last_day(${returned_date});;
  }

  measure: max_date {
    type: max
    sql: EXTRACT( DAY FROM ${returned_date});;  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
