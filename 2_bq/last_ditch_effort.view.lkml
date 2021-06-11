view: last_ditch_effort {
    derived_table: {
      materialized_view: yes
      sql:
          SELECT
          created_date,
          complaint_type,
          status,
          count(*) as total
          FROM `bigquery-public-data.austin_311.311_service_requests`
          GROUP BY 1,2,3
          ;;
    }

    dimension: created_date {
      datatype: timestamp
      type: date_time
      sql: ${TABLE}.created_date ;;
    }

    dimension: complaint_type {
      type: string
      sql: ${TABLE}.complaint_type ;;
    }
    dimension: status {
      type: string
      sql: ${TABLE}.status ;;
    }

    measure: count {
      type: count

    }



}
