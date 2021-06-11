view: increment_SQL {
derived_table: {
  sql:
  SELECT
          date,
          subscribed_status,
          country_code,
          views,
          FROM `thesis-project-252601.YoutubeData.p_channel_basic_a2_daily_first`
          WHERE date > '2021-05-01'
          GROUP BY 1,2,3,4
          ;;
}









}
