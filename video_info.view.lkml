view: video_info {
  sql_table_name: video_info ;;


  dimension: video_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.video_id ;;
  }

  dimension: video_url {
    type: string
    sql: ${TABLE}.video_url ;;
  }

  dimension: video_name {
    type: string
    sql: ${TABLE}.video_name ;;
    link: {
      label: "Video URL"
      url: "https://www.youtube.com/watch?v={{video_id | url_encode}}"
    }
    link: {
      label: "Video Dashboard"
      url: "/dashboards/6?Video_ID={{[video_id | url_encode}}"
      icon_url: "https://image.flaticon.com/icons/png/512/87/87578.png"
    }
  }
  dimension: thumbnail {
    type: string
    sql: ${TABLE}.thumbnail ;;
    link: {
      label: "Video Dashboard"
      url: "/dashboards/6?Video_ID={{[video_id' | url_encode}}"
      }
    html: <img src="{{value}}" width=75 height=50 border=0 />  ;;
    drill_fields: [channel_basic_a2_daily_first.data_date,video_name,channel_basic_a2_daily_first.video_stats*]
}
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
      url: "/dashboards/8?Title={{title | url_encode}}"
    }
    drill_fields: [video_name,Basic.video_stats*]
  }

  dimension: name {
    sql: ${title} ;;
    html:
    <a href="/dashboards/8?Title={{ value }}&">{{ value }}</a> ;;
  }


  dimension: title_pic {
    sql: ${title};;
    html: <img src="http://localhost:8080/image_search.php?q={{[value　| url_param_escape }}" width=200  border=0 /> ;;
  }

  dimension: episode_pic {
    sql: ${video_name};;
    html: <img src="http://localhost:8080/image_search.php?q={{[value　| url_param_escape }}" width=200  border=0 /> ;;
  }

  dimension: genre1 {
    type: string
    sql: ${TABLE}.genre_1 ;;
  }

  dimension: genre2 {
    type: string
    sql: ${TABLE}.genre_2 ;;
  }
  dimension: genre3 {
    type: string
    sql: ${TABLE}.genre_3 ;;
  }

  dimension: genre4 {
    type: string
    sql: ${TABLE}.genre_4 ;;
}

  dimension: play_button {
    label: "Play Button"
    sql: ${video_id} ;;
    html: <img src="https://variable.media/wp-content/uploads/2015/12/YouTube-Play-Button.png" width=100% border=0 /> ;;
  }

  dimension: face {
    label: "Face"
    sql: ${video_id} ;;
    html: <img src="https://yt3.ggpht.com/a-/AAuE7mBt0IhShlMtdkxricRAEgoJ9o-UphIfqutjLdeq=s88-c-k-c0xffffffff-no-rj-mo" height=100% border=0 /> ;;
  }


  measure: count {
    type: count
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
