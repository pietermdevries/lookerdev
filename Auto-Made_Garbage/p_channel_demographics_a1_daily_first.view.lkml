view: p_channel_demographics_a1_daily_first {
  sql_table_name: YoutubeData.p_channel_demographics_a1_daily_first ;;

  dimension: age_group {
    type: string
    sql: ${TABLE}.age_group ;;
  }

  dimension: channel_id {
    type: string
    sql: ${TABLE}.channel_id ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: live_or_on_demand {
    type: string
    sql: ${TABLE}.live_or_on_demand ;;
  }

  dimension: subscribed_status {
    type: string
    sql: ${TABLE}.subscribed_status ;;
  }

  dimension: video_id {
    type: string
    sql: ${TABLE}.video_id ;;
  }

  dimension: views_percentage {
    type: number
    sql: ${TABLE}.views_percentage ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
