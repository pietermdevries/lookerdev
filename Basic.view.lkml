# I have deleted annotation related data, because annotations are annoying and I don't use them!
# I have deleted avg/perc type data that is aggregated in the YT database, because they come as dimensions, I recreate the needed ones as measures


view: channel_basic_a2_daily_first {
  derived_table: {
      sql:
          SELECT
          row_number() OVER(ORDER BY _DATA_DATE) AS prim_key,
          *
          FROM channel_basic_a2_daily_first ;;
    }

dimension: prim_key {
  hidden: yes
  type: number
  primary_key: yes
  sql: ${TABLE}.prim_key ;;
}

dimension: vid {
  hidden: yes
  type: string
  sql: ${TABLE}.vid ;;
}


# ------------
#  Dates
# ------------

  filter: previous_period_filter {
    type: date
    description: "Use this filter for period analysis"
    sql: ${previous_period} IS NOT NULL ;;
  }

  dimension: previous_period {
    type: string
    description: "The reporting period as selected by the Previous Period Filter"
    sql:
      CASE
        WHEN {% date_start previous_period_filter %} is not null AND {% date_end previous_period_filter %} is not null /* date ranges or in the past x days */
          THEN
            CASE
              WHEN TIMESTAMP(${_data_raw}) >= {% date_start previous_period_filter %}
                AND TIMESTAMP(${_data_raw}) <= {% date_end previous_period_filter %}
                THEN 'This Period'
              WHEN TIMESTAMP(${_data_raw}) >= date_add(day,-1*date_diff(day,{% date_start previous_period_filter %}, {% date_end previous_period_filter %} ) + 1, date_add(day,-1,{% date_start previous_period_filter %} ) )
                AND TIMESTAMP(${_data_raw}) <= date_add(day,-1,{% date_start previous_period_filter %} )
                THEN 'Previous Period'
            END
        END ;;
  }

dimension_group: _data {
  type: time
  timeframes: [
    raw,
    date,
    day_of_month,
    day_of_week,
    day_of_week_index,
    week,
    month,
    quarter,
    year
  ]
  convert_tz: no
  datatype: date
  sql: ${TABLE}._DATA_DATE ;;
}

dimension_group: latest_date {
  type: time
  timeframes: [
    raw,
    date,
    week,
    month,
    quarter,
    year
  ]
  convert_tz: no
  datatype: date
  sql: max(${_data_raw}) ;;
}

# ------------
#  DIMENSIONS
# ------------

dimension: video_id {
  type: string
  sql: ${TABLE}.video_id ;;
}

dimension: channel_id {
  hidden: yes
  type: string
  sql: ${TABLE}.channel_id ;;
}

dimension: country_code {
  type: string
  sql: ${TABLE}.country_code ;;
}

dimension: live_or_on_demand {
  type: string
  sql: ${TABLE}.live_or_on_demand ;;
}

dimension: subscribed_status {
  view_label: "Subscription"
  type: string
  sql: ${TABLE}.subscribed_status ;;
}

# -------------------
# Measures below!
# -------------------

measure: latest_date {
  sql: MAX(${_data_raw});;
}

# -------------------
# Card Related!
# -------------------


measure: card_clicks {
  view_label: "Card"
  type: sum
  sql: ${TABLE}.card_clicks ;;
}

measure: card_impressions {
  view_label: "Card"
  type: sum
  sql: ${TABLE}.card_impressions ;;
}

measure: card_teaser_clicks {
  view_label: "Card"
  type: sum
  sql: ${TABLE}.card_teaser_clicks ;;
}

measure: card_teaser_impressions {
  view_label: "Card"
  type: sum
  sql: ${TABLE}.card_teaser_impressions ;;
}

measure: comments {
  type: sum
  sql: ${TABLE}.comments ;;
}

# -------------------
# Likes Related!
# -------------------

measure: dislikes {
  view_label: "Likes"
  type: sum
  sql: ${TABLE}.dislikes ;;
}

measure: likes {
  view_label: "Likes"
  type: sum
  sql: ${TABLE}.likes ;;
}

  measure: like_change {
    view_label: "Likes"
    type: number
    sql: ${likes}-${dislikes};;
  }

  measure: like_change_per_day {
    view_label: "Likes"
    type: number
    sql: ${like_change}/${count_videos};;
    value_format: "#.00"
  }

  measure: view_per_like {
    view_label: "Likes"
    type: number
    sql: ${sum_views}/nullif(${likes},0) ;;
    value_format: "#.00"
    }

measure: red_views {
  view_label: "Red"
  type: sum
  sql: ${TABLE}.red_views ;;
}

measure: red_watch_time_minutes {
  view_label: "Red"
  type: sum
  sql: ${TABLE}.red_watch_time_minutes,2 ;;
  value_format: "#.00"
}

measure: shares {
  type: sum
  sql: ${TABLE}.shares ;;
}

measure: subscribers_gained {
  view_label: "Subscription"
  type: sum
  sql: ${TABLE}.subscribers_gained ;;
}

measure: subscribers_lost {
  view_label: "Subscription"
  type: sum
  sql: ${TABLE}.subscribers_lost ;;
}

measure: subscriber_change {
  view_label: "Subscription"
  type: number
  sql: ${subscribers_gained}-${subscribers_lost} ;;
}

#I chose to calculate based on subscribers gained, to know speed of new subscriber acquisition
measure: view_per_sub {
  view_label: "Subscription"
  type: number
  sql: ${sum_views}/nullif(${subscribers_gained},0) ;;
  value_format: "#.00"
}

measure: videos_added_to_playlists {
  view_label: "Playlist"
  type: sum
  sql: ${TABLE}.videos_added_to_playlists ;;
}

measure: videos_removed_from_playlists {
  view_label: "Playlist"
  type: sum
  sql: ${TABLE}.videos_removed_from_playlists ;;
}

measure: views {
  type: sum
  sql: ${TABLE}.views ;;
}

measure: watch_time_minutes {
  type: sum
  sql: ${TABLE}.watch_time_minutes ;;
  value_format: "#.00"
}

measure: avg_watch_time {
  type: number
  sql: (${watch_time_minutes}/NULLIF(${views},0)) ;;
  value_format: "#.00"
}

measure: count_videos {
  type: count_distinct
  sql: ${video_id} ;;
}

measure: view_per_video{
  type: number
  sql: ${views}/${count_videos} ;;
  value_format: "#.00"
}

measure: sum_views {
  type: number
  sql: ${views} ;;
  value_format_name: number_conditional
}

measure: count {
  type: count
  drill_fields: []
}

set: vid_stats {
 fields: [views,subscriber_change,like_change,watch_time_minutes,comments,shares]
}
# ----------
# Random
# ----------

}
