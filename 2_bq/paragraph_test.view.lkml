explore: paragraph_test {}
view: paragraph_test {
  sql_table_name: `thesis-project-252601.workstuff.paragraph` ;;

  dimension: number {
    sql: ${TABLE}.string_field_0 ;;

  }
  dimension: paragraph {
    sql: ${TABLE}.string_field_1 ;;
  }
}
