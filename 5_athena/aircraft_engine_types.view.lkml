view: aircraft_engine_types {
  sql_table_name: flightstatsparquet.aircraft_engine_types ;;
  drill_fields: [aircraft_engine_type_id]
  suggestions: no

  dimension: aircraft_engine_type_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.aircraft_engine_type_id ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  measure: count {
    type: count
    drill_fields: [aircraft_engine_type_id, aircraft.count, aircraft_engines.count, aircraft_models.count]
  }
}
