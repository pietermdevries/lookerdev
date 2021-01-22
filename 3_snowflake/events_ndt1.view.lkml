explore: events_ndt1 {}
view: events_ndt1 {
  derived_table: {
    explore_source: events {
      column: created_date {}
      column: count {}
    }

  }
  dimension: created_date {
    type: date
  }
  dimension: count {
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
