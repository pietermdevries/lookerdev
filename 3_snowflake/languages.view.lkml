explore: languages {}
view: languages {

derived_table: {
  sql: SELECT
  'English' AS language, ' English1' AS _filter_test
UNION ALL
SELECT
  'English' AS language, ' English2' AS _filter_test
UNION ALL
SELECT
  'Japanese' AS language, ' 日本語1' AS _filter_test
UNION ALL
SELECT
  'Japanese' AS language, ' 日本語2' AS _filter_test
UNION ALL
SELECT
  'Korean' AS language, ' 한국어1' AS _filter_test
UNION ALL
SELECT
  'Korean' AS language, ' 한국어2' AS _filter_test
UNION ALL
SELECT
  'Chinese' AS language, ' 中文1' AS _filter_test
UNION ALL
SELECT
  'Chinese' AS language, ' 中文2' AS _filter_test
UNION ALL
SELECT
  'Russian' AS language, ' русский1' AS _filter_test
UNION ALL
SELECT
  'Russian' AS language, ' русский2' AS _filter_test
UNION ALL
SELECT
  'Italian' AS language, ' italiana1' AS _filter_test
UNION ALL
SELECT
  'Italian' AS language, ' italiana2' AS _filter_test
UNION ALL
SELECT
  'Thai' AS language, ' ไทย1' AS _filter_test
UNION ALL
SELECT
  'Thai' AS language, ' ไทย2' AS _filter_test
 ;;
}

dimension: language {
  sql: ${TABLE}.language ;;
}

  dimension: filter_test {
    sql: ${TABLE}._filter_test ;;
  }

}
