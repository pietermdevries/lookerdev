connection: "private_yt"

# include all the views
include: "*.view"

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


explore: channel_device_os_a2_daily_first {}

explore: channel_playback_location_a2_daily_first {}

explore: channel_province_a2_daily_first {}

explore: channel_sharing_service_a1_daily_first {}

explore: channel_subtitles_a2_daily_first {}

explore: channel_traffic_source_a2_daily_first {}

explore: p_channel_basic_a2_daily_first {}

explore: p_channel_cards_a1_daily_first {}

explore: p_channel_combined_a2_daily_first {}

explore: p_channel_demographics_a1_daily_first {}

explore: p_channel_device_os_a2_daily_first {}

explore: p_channel_playback_location_a2_daily_first {}

explore: p_channel_province_a2_daily_first {}

explore: p_channel_sharing_service_a1_daily_first {}

explore: p_channel_subtitles_a2_daily_first {}

explore: p_channel_traffic_source_a2_daily_first {}
