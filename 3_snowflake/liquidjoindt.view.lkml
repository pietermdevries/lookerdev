explore: liquidjoindt {}
view: liquidjoindt {

    derived_table: {
      sql:
        SELECT
        age,
        city,
        country
        FROM "PUBLIC"."USERS"
        {% if choose_dimension._parameter_value == "age"  %}
        WHERE age > 10
        {% elsif choose_dimension._parameter_value == "city"  %}
        where age = 10
        {% else %}
        where age < 10
        {% endif %}
      ;;
      # sql_trigger_value: select CURRENT_DATE ;;

    }

    filter: age_filter {
      type: number
      default_value: "10"
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

    parameter: choose_dimension {
      type: unquoted
      allowed_value: {
        label: "年齢"
        value: "age"
      }
      allowed_value: {
        label: "街"
        value: "city"
      }
      allowed_value: {
        label: "国"
        value: "country"
      }
    }

    dimension: test_parameter {
      sql: {% if choose_dimension._parameter_value == 'city' %}
        'city'
        {% else %}
        'not-city'
        {% endif%};;
    }



    dimension: dynamic_dimension {
      type: string
      sql: ${TABLE}.{% parameter choose_dimension %} ;;
    }







  }
