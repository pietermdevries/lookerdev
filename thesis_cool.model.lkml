connection: "private_yt"

# include all the views
include: "*.view"

datagroup: thesis_cool_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: thesis_cool_default_datagroup

explore: channel_annotations_a1_daily_first {}

explore: channel_basic_a2_daily_first {}

explore: channel_cards_a1_daily_first {}

explore: channel_combined_a2_daily_first {}

explore: channel_demographics_a1_daily_first {}

explore: channel_device_os_a2_daily_first {}

explore: channel_playback_location_a2_daily_first {}

explore: channel_province_a2_daily_first {}

explore: channel_sharing_service_a1_daily_first {}

explore: channel_subtitles_a2_daily_first {}

explore: channel_traffic_source_a2_daily_first {}

explore: p_channel_annotations_a1_daily_first {}

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

explore: p_playlist_basic_a1_daily_first {}

explore: p_playlist_combined_a1_daily_first {}

explore: p_playlist_device_os_a1_daily_first {}

explore: p_playlist_playback_location_a1_daily_first {}

explore: p_playlist_province_a1_daily_first {}

explore: p_playlist_traffic_source_a1_daily_first {}

explore: playlist_basic_a1_daily_first {}

explore: playlist_combined_a1_daily_first {}

explore: playlist_device_os_a1_daily_first {}

explore: playlist_playback_location_a1_daily_first {}

explore: playlist_province_a1_daily_first {}

explore: playlist_traffic_source_a1_daily_first {}
