explore: pdt_to_pdt {}
view: pdt1 {
    derived_table: {
      sql:
        SELECT
        age,
        city,
        country
        FROM "PUBLIC"."USERS"
      ;;
      sql_trigger_value: select CURRENT_DATE ;;
    }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: country {
    type: number
    sql: ${TABLE}.country ;;
  }

}
view: pdt_to_pdt {
  derived_table: {
    sql:
        SELECT
        age,
        city,
        country
        FROM
          ${pdt1.SQL_TABLE_NAME} as pdt1
      ;;
    sql_trigger_value: select CURRENT_DATE ;;
  }
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: country {
    type: number
    sql: ${TABLE}.country ;;
  }

}
