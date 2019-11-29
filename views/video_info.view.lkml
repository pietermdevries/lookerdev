view: video_info {
  sql_table_name: video_info ;;

  dimension_group: published_date {
    type: time
    timeframes: [
      raw,
      date,
      year,
      month,
      day_of_month,
      day_of_week,
      hour_of_day
    ]
    sql: ${TABLE}.published_date ;;
  }

  dimension_group: published_time {
    type: duration
    sql_start: TIMESTAMP(${published_date_date}) ;;  # often this is a single database column
    sql_end: TIMESTAMP(channel_basic_a2_daily_first._latest_date) ;;  # often this is a single database column
    intervals: [year, week, day] # valid intervals described below
  }


  dimension: video_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.video_id ;;
  }

  dimension: video_url {
    hidden: yes
    type: string
    sql: ${TABLE}.video_url ;;
  }

  dimension: cleanedleft5 {
    hidden: yes
    type: number
    sql: CASE WHEN ${video_id} ~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$' THEN LEFT(${video_id},5);;
  }

  dimension: video_name {
    type: string
#      sql: ${TABLE}.video_name ;;
       sql: TRIM(SUBSTR(replace(${TABLE}.video_name,"【海外の反応 アニメ】",""),0,STRPOS(replace(${TABLE}.video_name,"【海外の反応 アニメ】",""),"話"))) ;;
    link: {
      label: "Video URL"
      url: "https://www.youtube.com/watch?v={{ _filters['video_info.video_id'] | url_encode}}"
    }
    link: {
      label: "Video Dashboard"
      url: "/dashboards/6?Video_Name={{[filterable_value | url_encode}}"
      icon_url: "https://image.flaticon.com/icons/png/512/87/87578.png"
    }
  }
  dimension: thumbnail {
    type: string
    sql: ${TABLE}.thumbnail ;;
    link: {
      label: "Video Dashboard"
      url: "/dashboards/6?Video_Name={{[video_info.video_name._filterable_value | encode_url}}"
      icon_url: "https://image.flaticon.com/icons/png/512/87/87578.png"
      }
    html: <img src="{{value}}" width=75 height=50 border=0 />  ;;
    drill_fields: [channel_basic_a2_daily_first.data_date,video_name,channel_basic_a2_daily_first.video_stats*]
}
#html: <a href="{{ website.url._value }}" target="_new">{{ value }}</a> ;;
    dimension: full_thumbnail {
      type: string
      sql: ${TABLE}.thumbnail ;;
      html: <img src="{{value}}" width=200 />  ;;
      drill_fields: [channel_basic_a2_daily_first.data_date,video_name,channel_basic_a2_daily_first.video_stats*]
  }

  dimension: title {
    type: string
    sql: ${TABLE}.anime_title ;;
    link: {
      label: "Video Series Dashboard"
      url: "/dashboards/8?Title={{filterable_value | url_encode}}"
      icon_url: "https://image.flaticon.com/icons/png/512/87/87578.png"
    }
    drill_fields: [video_name,Basic.video_stats*]
  }

  dimension: name {
    hidden: yes
    sql: ${title} ;;
    html:
    <a href="/dashboards/8?Title={{ filterable_value }}&">{{ filterable_value }}</a> ;;
  }


  dimension: title_pic {
    hidden: yes
    sql: ${title};;
    html: <img src="https://agile-peak-87852.herokuapp.com/image_search.php?q={{[value　| url_param_escape }}" width=200  border=0 /> ;;
  }

  dimension: episode_pic {
    hidden: yes
    sql: ${video_name};;
    html: <img src="https://agile-peak-87852.herokuapp.com/image_search.php?q={{[value　| url_param_escape }}" width=200  border=0 /> ;;
  }

  dimension: genre1 {
    hidden: yes
    type: string
    sql: ${TABLE}.genre_1 ;;
  }

  dimension: genre2 {
    hidden: yes
    type: string
    sql: ${TABLE}.genre_2 ;;
  }
  dimension: genre3 {
    hidden: yes
    type: string
    sql: ${TABLE}.genre_3 ;;
  }

  dimension: genre4 {
    hidden: yes
    type: string
    sql: ${TABLE}.genre_4 ;;
}

  dimension: play_button {
    hidden: yes
    label: "Play Button"
    sql: ${video_id} ;;
    html: <img src="https://variable.media/wp-content/uploads/2015/12/YouTube-Play-Button.png" width=100% border=0 /> ;;
  }

  dimension: face {
    hidden: yes
    label: "Face"
    sql: ${video_id} ;;
    html: <img src="https://yt3.ggpht.com/a-/AAuE7mBt0IhShlMtdkxricRAEgoJ9o-UphIfqutjLdeq=s88-c-k-c0xffffffff-no-rj-mo" height=100% border=0 /> ;;
  }


  measure: count {
    type: count
  }
 dimension: duration {
  type: string
  sql: ${TABLE}.duration ;;
}
  measure: view_num {
    type: sum
    sql: ${TABLE}.view_num ;;
  }
  measure: like_num {
    type: sum
    sql: ${TABLE}.like_num ;;
  }
  measure: dislike_num  {
    type: sum
    sql: ${TABLE}.dislike_num ;;
  }

  measure: like_change_num {
    type: number
    sql: ${like_num}-${dislike_num} ;;
  }

  measure: comment_num{
    type: sum
    sql: ${TABLE}.comment_num ;;
  }
}
#Below is my failed attempt to embed youtube videos in looker

#   dimension: video_play {
#     type: string
#     sql: ${video_name} ;;
#     html:<iframe width=“320” height=“240"
#     <src=“https://www.youtube.com/{{video_id | url_encode}}”></iframe> ;;
#   }
#
# #
# #   html:<video width=“320” height=“240" controls>
# #   <source src=“https://www.w3schools.com/tags/movie.mp4” type=“video/mp4">
# #   <source src=“movie.ogg” type=“video/ogg”>
# #   </video>
# #   <p><strong>Note:</strong> The video tag is not supported in Internet Explorer 8 and earlier versions.</p> ;;
# # }
#   # # You can specify the table name if it's different from the view name:
#   # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
#}

# view: video_info {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
