view: orders {
sql_table_name: `looker-test-db.looker_test.orders` ;;
  # derived_table: {
  # sql:
  # SELECT order_amount
  # FROM `looker-test-db.looker_test.orders`
  # UNION ALL
  # SELECT 0 as order_amount


  #   ;;
  #   }
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
      year,
      day_of_month,
      month_num
    ]
    sql: ${TABLE}.created_at ;;
  }

  parameter: compare_period_filter {
    label: "比較期間選択用"
    type: string
    allowed_value: {
      label: "週比較"
      value: "week"
    }
    allowed_value: {
      label: "月比較"
      value: "month"
    }
    allowed_value: {
      label: "年比較"
      value: "year"
    }
  }

  dimension: compare_period_date {
    type: number
    sql:
    CASE
    WHEN {% parameter compare_period_filter %} = 'week' THEN CAST(${created_day_of_month} as NUMERIC)
    WHEN {% parameter compare_period_filter %} = 'month' THEN CAST(${created_day_of_month} as NUMERIC)
    WHEN {% parameter compare_period_filter %} = 'year' THEN CAST(${created_month_num} as NUMERIC)
    ELSE null
    END ;;
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
