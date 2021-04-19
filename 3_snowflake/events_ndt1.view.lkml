explore: events_ndt1 {}
view: events_ndt1 {
  derived_table: {
    explore_source: pieter_events {
      column: created_date {}
      column: parameterized_field {}
      column: count {}
      bind_filters: {
        to_field: events.created_date
        from_field: events_ndt1.created_date
      }
    }

  }
  dimension: created_date {
    type: date
  }
  dimension: count {
    type: number
  }

  dimension: parameterized_field {}

  parameter: parameter_filter {
    type: number
  }


  parameter: test {
    type: number
  }

measure: count_test {
  type: sum
  sql: ${count}*${test}  ;;
}
}
