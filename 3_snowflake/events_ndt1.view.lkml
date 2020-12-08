
view: events_ndt1 {
  derived_table: {
    explore_source: events {
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
