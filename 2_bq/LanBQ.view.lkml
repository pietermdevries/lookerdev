explore: lanbq {}
view: lanbq {
derived_table: {
  create_process: {
    sql_step:
      CREATE TABLE ${SQL_TABLE_NAME}
      (top_names ARRAY<STRING>) ;;
    sql_step:
      INSERT INTO ${SQL_TABLE_NAME} (top_names)
      SELECT ARRAY_AGG(name ORDER BY number DESC LIMIT 100)
      FROM `bigquery-public-data`.usa_names.usa_1910_current
      WHERE year = 2017;;
  }
}
dimension: word {
  sql: ${TABLE}.word ;;
}

}
