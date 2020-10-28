view: orders {
  derived_table: {
  sql:
  SELECT order_amount
  FROM `looker-test-db.looker_test.orders`
  UNION ALL
  SELECT 0 as order_amount


    ;;
    }
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: day {
    type: number
    sql: PARSE_DATE("%d", ${created_date}) ;;
  }

  dimension: order_amount {
    type: number
    sql:
    CASE WHEN ${TABLE}.order_amount > 0 THEN ${TABLE}.order_amount
    ELSE 0 END ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, order_items.count]
  }
}
