explore: test_total {}

view: test_total {
  derived_table: {
    sql:
    select
    'd1' as d, 1 as m
    UNION ALL
    select
    'd' as d, 2 as m
    UNION ALL
    select
    'd3' as d, 3 as m
    UNION ALL
    select
    'd4' as d, 4 as m
    ;;
  }
  dimension: primary_key {
    primary_key: yes
    sql: ${TABLE}.d ;;
  }

  dimension: d {
    type: string
    sql: ${TABLE}.d ;;
  }
  measure: m {
    type: sum
    sql: ${TABLE}.m ;;
  }
}
