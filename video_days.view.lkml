view: video_days {
  derived_table: {
    sql: SELECT
        DISTINCT video_id,
        MIN(_DATA_DATE) AS Post_Date,
        SUM(views) AS Views,
        DATE_DIFF(MAX(_DATA_DATE),MIN(_DATA_DATE), day) Days_Posted,
        SUM(views)/NULLIF(DATE_DIFF(MAX(_DATA_DATE),(MIN(_DATA_DATE)), day),
          0) AS views_per_day,
        CASE
          WHEN DATE_DIFF(MAX(_DATA_DATE),MIN(_DATA_DATE), day) <= 7 THEN "First_7"
        ELSE
        "After_7"
      END AS Posted

      FROM
        `thesis-project-252601.YoutubeData.channel_basic_a2_daily_first`
      WHERE
        video_id IS NOT NULL
      GROUP BY
        1
      HAVING Post_Date > "2019-08-25"
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: video_id {
    type: string
    sql: ${TABLE}.video_id ;;
  }

  dimension_group: post_date {
    type: time
    timeframes: [
      raw,
      date,
      day_of_month,
      week,
      month,
      quarter,
      year
    ]
    sql: TIMESTAMP(${TABLE}.Post_Date) ;;
  }

  dimension: days_since_post {
    hidden: yes
    type: number
    sql: DATE_DIFF(${channel_basic_a2_daily_first._data_raw},${post_date_date},day)
 ;;
  }
  dimension: days_after_post {
    type: number
    sql: CASE WHEN ${days_since_post} > 6 THEN null
    ELSE ${days_since_post} END;;
  }

  dimension: views {
    type: number
    sql: ${TABLE}.Views ;;
  }

  dimension: days_posted {
    type: number
    sql: ${TABLE}.Days_Posted ;;
  }

  dimension: views_per_day {
    type: number
    sql: ${TABLE}.views_per_day ;;
  }

  dimension: posted {
    type: string
    sql: ${TABLE}.Posted ;;
  }

  set: detail {
    fields: [
      video_id,
      views,
      days_posted,
      days_after_post,
      views_per_day,
      posted
    ]
  }
}
