view: events_ndt2 {
  derived_table: {
    explore_source: events_ndt1 {
      column: created_date {}
      column: count {}
      bind_all_filters: yes
    }

  }
  dimension: created_date {
    type: date
  }
  dimension: count {
    type: number
  }
}
