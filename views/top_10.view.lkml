view: top_10 {
  derived_table: {
    sql:
    select
    video_id
    , sum(views) as duration
    , rank() over (order by sum(views) desc) as rank
    from channel_basic_a2_daily_first
    where
      {% condition rank_date_filter %} CAST(channel_basic_a2_daily_first._DATA_DATE AS TIMESTAMP) {% endcondition %}
    group by 1
    ;;
  }

  filter: rank_date_filter {
    type: date
  }

  dimension: video_id {
    primary_key: yes
    sql: ${TABLE}.video_id ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }
}
