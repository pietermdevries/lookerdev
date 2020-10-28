view: meaning_of_life {
  sql_table_name: `looker-test-db.tokyo_star.meaning_of_life`
    ;;

  dimension: meaning {
    type: number
    sql: ${TABLE}.meaning ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
