view: states {
  sql_table_name: flightstatsparquet.states ;;
  suggestions: no

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: state_code {
    type: string
    sql: ${TABLE}.state_code ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
