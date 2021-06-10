explore: value_format {}
view: value_format {
    derived_table: {
      sql: SELECT
          '-1' AS value
        UNION ALL
        SELECT
          '-10000' AS value
        UNION ALL
        SELECT
          '-1000000' AS value
        UNION ALL
        SELECT
          '1' AS value
        UNION ALL
        SELECT
          '10000' AS value
        UNION ALL
        SELECT
          '1000000' AS value
        UNION ALL
        SELECT
          '100000000' AS value
        UNION ALL
        SELECT
          '-10000000' AS value
         ;;
    }

    dimension: value {
      sql: CAST(${TABLE}.value as integer) ;;
      type: number
      html:
          {% if value > 1000000000 %}
            ${{value | divided_by: 1000000000 | round:2 }}B
          {% elsif value >= 1000000 and value < 1000000000 %}
            ${{value | divided_by: 1000000 | round:2 }}M
          {% elsif value >= 1000 and value < 1000000 %}
            ${{value | divided_by: 1000 | round:2 }}K
          {% elsif value >= 0 and value < 1000 %}
            ${{value | round:2 }}
          {% elsif value > -1000 and value < 0 %}
              ${{value | round:2 }}
          {% elsif value > -1000000 and value <= -1000 %}
              ${{value | divided_by: 1000 | round:2 }}k
          {% elsif value > -1000000000 and value <= -1000000 %}
              ${{value | divided_by: 1000000 | round:2 }}M
          {% elsif value <= -1000000000 %}
              ${{value | divided_by: 1000000000 | round:2 }}B
          {% else %}
            'fail'
          {% endif %} ;;
    }

    dimension: raw_value {
      sql: CAST(${TABLE}.value as integer) ;;
      type: number
    }



  }
