view: base_view {
  sql_table_name: `thesis-project-252601.YoutubeData.p_channel_basic_a2_daily_first` ;;
  dimension: date {
    datatype: date
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension: subscribed_status {
    type: string
    sql: ${TABLE}.subscribed_status ;;
  }
  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }
  dimension: views {
    type: number
    sql: ${TABLE}.views ;;
  }
  measure: total_views {
    type: sum
    sql: ${views} ;;
  }

}


view: increment_NDT {
  derived_table: {
    increment_key: "date"
    increment_offset: 3
    sql_trigger_value: CURRENT_DATE() ;;
    distribution_style: all
    explore_source: base_view {
      column: date {}
      column: country_code {}
      column: total_views {}
    }
  }

  dimension: date {
    type: date
  }
  dimension: country_code {
    type: string
  }
  dimension: total_views {
    type: number
  }
}
