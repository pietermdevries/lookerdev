connection: "private_yt"

# include all the views
include: "*.view"
include: "views/*"

datagroup: thesis_cool_default_datagroup {
  sql_trigger: SELECT COUNT(*) FROM channel_basic_a2_daily_first;;
  max_cache_age: "24 hour"
}

persist_with: thesis_cool_default_datagroup

named_value_format: usd_conditional {
  value_format: "[>=1000000]$0.0,,\"M\";[>=1000]$0.0,\"K\";$0"
  strict_value_format: yes
}

named_value_format: number_conditional {
  value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
}


explore: channel_basic_a2_daily_first {
  join: video_info {
    type: left_outer
    sql_on: ${video_info.video_id} = ${channel_basic_a2_daily_first.video_id} ;;
    relationship: many_to_one
  }
#   join: video_based_cohort_analysis {
#     type: left_outer
#     sql_on: ${channel_basic_a2_daily_first.video_id} =  ${video_based_cohort_analysis.video_id};;
#     relationship: many_to_one
#   }
  join: video_days {
    type: left_outer
    sql_on: ${channel_basic_a2_daily_first.video_id} = ${video_days.video_id} ;;
    relationship: many_to_one
  }
  join: demographics_dt {
    type: left_outer
    sql_on: ${video_info.video_id} = ${demographics_dt.video_id}  ;;
    relationship: one_to_many
  }
  join: genre_total {
    type: left_outer
    sql_on: ${genre_total.video_id} = ${channel_basic_a2_daily_first.video_id} ;;
    relationship: many_to_many
}
  join: playback {
    type: left_outer
    sql_on: ${channel_basic_a2_daily_first.video_id} = ${playback.video_id}
    AND ${channel_basic_a2_daily_first._data_date} = ${playback._data_date} ;;
    relationship: many_to_many
  }
  join: traffic_source {
    type:  left_outer
    sql_on: ${channel_basic_a2_daily_first.video_id} = ${traffic_source.video_id}
    AND ${channel_basic_a2_daily_first._data_date} = ${traffic_source._data_date};;
    relationship: many_to_one
  }
}



explore: demographics_dt {
  join:  video_info {
    type: left_outer
    sql_on: ${demographics_dt.video_id} = ${video_info.video_id} ;;
    relationship: many_to_one
  }
  join: genre_total {
    type: left_outer
    sql_on: ${genre_total.video_id} = ${demographics_dt.video_id} ;;
    relationship: many_to_many
  }
  }


explore: genre_total {}

explore: traffic_source {
  join: channel_basic_a2_daily_first {
    type: left_outer
    sql_on: ${traffic_source.video_id} = ${channel_basic_a2_daily_first.video_id}
    and ${traffic_source._data_date} = ${channel_basic_a2_daily_first._data_date};;
    relationship: many_to_many
  }
  join: video_info {
    type: left_outer
    sql_on: ${channel_basic_a2_daily_first.video_id} = ${video_info.video_id} ;;
    relationship: many_to_one
  }
}

explore: sharing {
  join: channel_basic_a2_daily_first {
    type: left_outer
    sql_on: ${sharing.video_id} = ${channel_basic_a2_daily_first.video_id}
    and ${channel_basic_a2_daily_first._data_date} = ${sharing._data_date};;
    relationship: many_to_many
  }
  join: video_info {
    type: left_outer
    sql_on: ${sharing.video_id} = ${video_info.video_id} ;;
    relationship: many_to_one
  }
}

explore: playback {

}

explore: LAG_TEST {

}
