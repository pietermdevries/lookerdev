view: last_ditch_effort {
    derived_table: {
      materialized_view: yes
      sql:
          SELECT
          created_date,
          complaint_type,
          status,
          sum(*) as total
          FROM `bigquery-public-data.austin_311.311_service_requests`
          WHERE date > '2021-05-01'
          GROUP BY 1,2,3,4
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

    }
    measure: count {
      type: count

    }




  }

}
