view: daily_views2 {
## 2 Issues here:
#1. I created a generate_uuid(), and got an error -
#derived_table daily_views2 creation failed: SQL Error in CREATE MATERIALIZED VIEW as SELECT: Query execution failed: - Non-deterministic functions are not supported in materialized view.
#-> https://cloud.google.com/bigquery/docs/materialized-views-faq
    derived_table: {
      materialized_view: yes
      sql:
          SELECT
          date,
          subscribed_status,
          country_code,
          views,
          --generate_uuid() as primary_key,
          sum(views) as total_views
          FROM `thesis-project-252601.YoutubeData.p_channel_basic_a2_daily_first`
          WHERE date > '2021-05-01'
          GROUP BY 1,2,3,4
          ;;
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
