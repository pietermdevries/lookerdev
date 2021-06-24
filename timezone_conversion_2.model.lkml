connection: "dont_use_costs_me_money"

view: test {
  derived_table: {
    sql: SELECT * FROM
          UNNEST( GENERATE_TIMESTAMP_ARRAY('2016-10-05 00:00:00', '2016-10-07 00:00:00',
                                      INTERVAL 1 HOUR)) AS timestamp
      ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.timestamp ;;
  }
}

explore: test {}
