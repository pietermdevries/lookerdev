# ------------
# COHORT ANALYSIS
# ------------
include: "*channel_basic_a2_daily_first.view"

view: video_based_cohort_analysis {
  derived_table: {
    sql: SELECT
        video_id,
        date,
        MIN(DATE) as posted_date,
        MIN(DATE)+7 as posted_date_week_after,
        COUNT(*) as cohort_size
      FROM
        channel_basic_a2_daily_first b
      GROUP BY
        1,2
       ;;
    datagroup_trigger: thesis_cool_default_datagroup
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: video_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.video_id ;;
  }

  dimension: video_posted_date {
    type: string
    sql: ${TABLE}.posted_date ;;
  }

  measure: videos_per_day {
    type: count_distinct
    sql: ${video_id} ;;
  }

  set: detail {
    fields: [video_id, video_posted_date]
  }

  parameter: view_measure_picker {
    description: "Analyze Views"
    type: unquoted
    allowed_value: {
      label: "Total Views"
      value: "SUM"}
    allowed_value: {
      label: "Average Views"
      value: "AVG"}
    allowed_value: {
      label: "Maximum Views"
      value: "MAX"}
    allowed_value: {
      label: "Minimum Views"
      value: "MIN"}
  }
  parameter: watch_time_measure_picker {
    description: "Analyze Watch_time"
    type: unquoted
    allowed_value: {
      label: "Total Watch_time"
      value: "SUM"}
    allowed_value: {
      label: "Average Watch_time"
      value: "AVG"}
    allowed_value: {
      label: "Maximum Watch_time"
      value: "MAX"}
    allowed_value: {
      label: "Minimum Watch_time"
      value: "MIN"}
  }
}
