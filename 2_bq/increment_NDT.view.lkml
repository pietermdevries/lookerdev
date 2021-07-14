view: base_view {
  sql_table_name: `bigquery-public-data.austin_311.311_service_requests` ;;
  dimension: created_date {
    datatype: timestamp
    type: date_time
    sql: ${TABLE}.created_date ;;
  }

  dimension: complaint_type {
    type: string
    sql: ${TABLE}.complaint_type ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  measure: count {
    type: count
  }

}


view: increment_NDT {
  derived_table: {
    increment_key: "created_date"
    increment_offset: 3
    sql_trigger_value: CURRENT_DATE() ;;
    distribution_style: all
    explore_source: base_view {
      column: created_date {}
      column: complaint_type {}
      column: status {}
      column: count {}
    # bind_filters: {
    #   to_field: base_view.created_date
    #   from_field: increment_NDT.created_date
    # }
    }

  }

  dimension: created_date {
    type: date
  }
  dimension: complaint_type {
    type: string
  }
  dimension: status {
    type: string
  }
  dimension: count {
    type: number
  }
}

view: increment_SQL {
  derived_table: {
    sql:
    SELECT *
    FROM `bigquery-public-data.austin_311.311_service_requests`
    WHERE {% incrementcondition %} created_date {%  endincrementcondition %}
;;
    increment_key: "created_date"
    increment_offset: 3
    sql_trigger_value: CURRENT_DATE() ;;
    distribution_style: all
    }

  dimension: created_date {
    type: date
  }
  dimension: complaint_type {
    type: string
  }
  dimension: status {
    type: string
  }
  dimension: count {
    type: number
  }
}
