# I have deleted annotation related data, because annotations are annoying and I don't use them!
# I have deleted avg/perc type data that is aggregated in the YT database, because they come as dimensions, I recreate the needed ones as measures


view: channel_basic_a2_daily_first {
  view_label: "Basic"
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

  dimension_group: _latest {
    hidden: yes
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
    sql: ${TABLE}._LATEST_DATE ;;
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
    description: "double digits"
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: live_or_on_demand {
    type: string
    sql: ${TABLE}.live_or_on_demand ;;
  }

  dimension: subscribed_status {
    type: string
    sql: ${TABLE}.subscribed_status ;;
  }

  measure: latest_date {
    sql: MAX(${_data_raw});;
  }

  measure: card_clicks {
    group_label: "Card"
    type: sum
    sql: ${TABLE}.card_clicks ;;
  }

  measure: card_impressions {
    group_label: "Card"
    type: sum
    sql: ${TABLE}.card_impressions ;;
  }

  measure: card_teaser_clicks {
    group_label: "Card"
    type: sum
    sql: ${TABLE}.card_teaser_clicks ;;
  }

  measure: card_teaser_impressions {
    group_label: "Card"
    type: sum
    sql: ${TABLE}.card_teaser_impressions ;;
  }

  measure: comments {
    group_label: "Comments"
    type: sum
    sql: ${TABLE}.comments ;;
  }

  measure: view_per_comments {
    group_label: "Views"
    type: number
    sql: ${views}/nullif(${comments},0) ;;
    value_format: "#.00"
  }

  measure: dislikes {
    group_label: "Likes"
    type: sum
    sql: ${TABLE}.dislikes ;;
  }

  measure: likes {
    group_label: "Likes"
    type: sum
    sql: ${TABLE}.likes ;;
  }

  measure: like_change {
    group_label: "Likes"
    type: number
    sql: ${likes}-${dislikes};;
  }

  measure: like_change_per_video {
    group_label: "Video"
    type: number
    sql: ${like_change}/${count_videos};;
    value_format: "#.00"
  }

  measure: sub_change_per_video {
    group_label: "Video"
    sql: ${subscriber_change}/${count_videos} ;;
    value_format: "#.00"
  }

  measure: comment_per_video {
    group_label: "Video"
    sql: ${comments}/${count_videos} ;;
    value_format: "#.00"
  }

  measure: view_per_like {
    group_label: "Views"
    type: number
    sql: ${views}/nullif(${likes},0) ;;
    value_format: "#.00"
  }

  measure: red_views {
    group_label: "Red"
    type: sum
    sql: ${TABLE}.red_views ;;
  }

  measure: red_watch_time_minutes {
    group_label: "Red"
    type: sum
    sql: ${TABLE}.red_watch_time_minutes,2 ;;
    value_format: "#.00"
  }

  measure: shares {
    group_label: "Shares"
    type: sum
    sql: ${TABLE}.shares ;;
  }

  measure: subscribers_gained {
    group_label: "Subscription"
    type: sum
    sql: ${TABLE}.subscribers_gained ;;
    drill_fields: [video_info.video_name,vid_stats*]
  }


  measure: subscribers_lost {
    group_label: "Subscription"
    type: sum
    sql: ${TABLE}.subscribers_lost ;;
    drill_fields: [video_info.video_name,vid_stats*]
  }

  measure: subscriber_change {
    group_label: "Subscription"
    type: number
    sql: ${subscribers_gained}-${subscribers_lost} ;;
    drill_fields: [video_info.video_name,vid_stats*]
  }

#I chose to calculate based on subscribers gained, to know speed of new subscriber acquisition
  measure: view_per_sub {
    group_label: "Views"
    type: number
    sql: ${views}/nullif(${subscribers_gained},0) ;;
    value_format: "#.00"
  }

  measure: videos_added_to_playlists {
    group_label: "Playlist"
    type: sum
    sql: ${TABLE}.videos_added_to_playlists ;;
  }

  measure: videos_removed_from_playlists {
    group_label: "Playlist"
    type: sum
    sql: ${TABLE}.videos_removed_from_playlists ;;
  }

  dimension: view_num {
    hidden: yes
    type: number
    sql: ${TABLE}.views ;;
    }

  measure: views {
    group_label: "Views"
    type: sum
    sql: ${view_num} ;;
    # link: {
    #    label: "View Indepth"
    #    url: "/dashboards/7?VideoID={{[video_id | url_encode}}&Title={{title | url_encode}}"
    # }
  }

  dimension: watch_time_min {
    hidden: yes
    type: number
    sql: ${TABLE}.watch_time_minutes ;;
  }
  measure: watch_time_minutes {
    group_label: "Watch Time"
    type: sum
    sql: ${watch_time_min} ;;
    value_format: "#.00"
  }

  measure: avg_watch_time {
    group_label: "Watch Time"
    type: number
    sql: (${watch_time_minutes}/NULLIF(${views},0)) ;;
    value_format: "#.00"
  }

  dimension: watch_tiers {
    group_label: "Watch Time"
    case: {
      when: {
        sql: ${watch_time_min} < 5  ;;
        label: "Short"
      }
      when: {
        sql: ${watch_time_min} < 10 ;;
        label: "Medium"
      }
      when: {
        sql: ${watch_time_min} < 15 ;;
        label: "Long"
      }
      else: "Jumbo-Long"
      }
    }


  measure: count_videos {
    group_label: "Video"
    type: count_distinct
    sql: ${video_id} ;;
  }

  measure: view_per_video{
    group_label: "Video"
    type: number
    sql: ${views}/${count_videos} ;;
    value_format: "#.00"
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: key_points {
    description: "Combined Views/Subs/Likes/Shares/Comments to give a score"
    type: number
    sql: ((${views}*1)+(${likes}*10)+(${subscribers_gained}*100)+(${shares}*100))-((${dislikes}*20)+(${subscribers_lost}*200)) ;;
    drill_fields: [vid_stats*]
 }

  set: vid_stats {
    fields: [views,subscriber_change,like_change,watch_time_minutes,comments,shares]
  }




# ----------
# Random
# ----------

  parameter: dynamic_measure {
    description: "Choose Type with Chooser"
    type: string
    allowed_value: {
      label: "Total Views"
      value: "views"
    }
    allowed_value: {
      label: "Average Watch Time"
      value: "avg_watch_time"
    }
    allowed_value: {
      label: "Subscriber Change"
      value: "subscriber_change"
    }
    allowed_value: {
      label: "Shares"
      value: "shares"
    }
    allowed_value: {
      label: "Like Change"
      value: "like_change"
    }
    allowed_value: {
      label: "Key_Points"
      value: "key_points"
    }
  }

  measure: metric_chooser {
    description: "Use with Metric_Picker Filter Only"
    type: number
    label_from_parameter: dynamic_measure
    sql:    CASE
      WHEN {% parameter dynamic_measure %} = 'views'
        THEN ${views}
      WHEN {% parameter dynamic_measure %} = 'avg_watch_time'
        THEN ${avg_watch_time}
      WHEN {% parameter dynamic_measure %} = 'subscriber_change'
        THEN ${subscriber_change}
        WHEN {% parameter dynamic_measure %} = 'shares'
        THEN ${shares}
        WHEN {% parameter dynamic_measure %} = 'like_change'
        THEN ${like_change}
        WHEN {% parameter dynamic_measure %} = 'key_points'
        THEN ${key_points}
      ELSE NULL
    END ;;
  }

  measure: test_views {
    type: average
    sql: ${TABLE}.views ;;
    value_format_name: decimal_0
    link: {
      label: "dashboard"
      url:"/dashboards/5?"
  }}

  set: test {
    fields: [channel_basic_a2_daily_first.*]
  }

    parameter: date_granularity {
      type: unquoted
      allowed_value: { label: "Break down by Day" value: "day" }
      allowed_value: { label: "Break down by Month" value: "month" }
    }

#    dimension: date {
#      sql:
#      {% if date_granularity._parameter_value == 'day' %}
#      ${_data_raw}
##      {% elsif date_granularity._parameter_value == 'month' %}
#      ${data_raw}
#      {% else %}
#      ${_data_raw}
#      {% endif %};;
#    }



}
