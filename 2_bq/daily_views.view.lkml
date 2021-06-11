## 2 Issues here:
# 1. No aggregator in the sql. Bigquery Materialized_views require an aggregator
# 2. Traffic_source is a "View schema", Materialized views must be built on a "Table schema"!

view: daily_views {
  derived_table: {
    # materialized_view: yes
    sql:
    SELECT
    date,
    subscribed_status,
    country_code,
    views,
    primary_key
    FROM `thesis-project-252601.YoutubeData.Traffic_Source`
    WHERE date > '2021-01-01'
    ;;
    partition_keys: ["date"]
  }

  dimension: date {
    datatype: date
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension: subscribed_status {
    type: string
    sql: ${TABLE}.subscribed_status ;;
}
  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
}
  dimension: views {
    type: number
    sql: ${TABLE}.views ;;
}
  dimension: primary_key {
    primary_key: yes
    sql: ${TABLE}.primary_key ;;

}
measure: total_views {
  type: sum
  sql: ${views} ;;
}

  }
