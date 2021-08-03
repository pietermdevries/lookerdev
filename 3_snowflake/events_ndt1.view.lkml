view: events_ndt1 {
  derived_table: {
    explore_source: event_ndt {
      bind_all_filters: yes
      column: created_date {}
      # column: parameterized_field {}
      column: count {}
      # derived_column: distinct_date {
      #   sql: DISTINCT created_date ;;
      # }
      derived_column: pk {
       sql: row_number()
      OVER(ORDER BY created_date);;
      }

      }
    }

  dimension: created_date {
    type: date
    sql: (
    SELECT MAX( "PUBLIC"."EVENTS"."CREATED_AT")
    FROM "PUBLIC"."EVENTS" );;
  }
  dimension: count {
    type: number
  }
  dimension: pk {
    primary_key: yes
  }

  dimension: distinct_date {
    type: date
  }
  # dimension: parameterized_field {}

  # parameter: parameter_filter {
  #   type: number
  # }


  parameter: test {
    type: number
  }

measure: count_test {
  type: sum
  sql: ${count}*${test}  ;;
}
}
