view: users {
derived_table: {
  sql:
  select *,
  MAX(CASE WHEN "AGE" = 21 THEN 'Success' ELSE 'Fail' END) OVER (PARTITION BY "FIRST_NAME") as condition,
  LAG("AGE", 1) OVER(PARTITION BY "FIRST_NAME" ORDER BY "FIRST_NAME","AGE" DESC) AS lag,
  "AGE"/LAG("AGE", 1) OVER(PARTITION BY "FIRST_NAME" ORDER BY "FIRST_NAME","AGE" DESC) as row_over_row

  FROM "PUBLIC"."USERS";;
}
  drill_fields: [id]
######


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
    default_value: "age"
  }

  dimension: test_parameter {
    description: "
    {% if choose_dimension._parameter_value == 'age' %}
        age
        {% elsif choose_dimension._parameter_value == 'country' %}
        country
        {% else %}
        city
        {% endif%}
        "
    sql:
        {% if choose_dimension._parameter_value == 'age' %}
        'age'
        {% elsif choose_dimension._parameter_value == 'country' %}
        'country'
        {% else %}
        'city'
        {% endif%};;
  }

dimension: split_liquid {
  sql: 'This, is, the, way' ;;
  html:
  {% assign words = value | split: ',' %}
  {{ words[1] }} ;;
}

dimension: condition {
  type: string
  sql: ${TABLE}."CONDITION";;
}
dimension: lag {
  type: string
  sql: ${TABLE}."LAG";;
}


#######
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}."AGE" ;;
  }

  measure: count_date_test {
    type: count_distinct
    sql:
    (SELECT ${age}
    WHERE ${created_date} BETWEEN '2017-04-01' AND ${created_date}
    )
    ;;
  }

  dimension: number {
    type: number
    sql: ${age} ;;
    value_format: "$#.00;($#.00)"
  }

  dimension: number_row_over_row {
    type: number
    sql: ${TABLE}."ROW_OVER_ROW";;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."FIRST_NAME" ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}."GENDER" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."LAST_NAME" ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  measure: generic_measure {
    type: sum
    sql: ${latitude} ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}."TRAFFIC_SOURCE" ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, count, generic_measure]
  }

  measure: rendered_count {
    type: count
    drill_fields: [gender,last_name]
    link: {
      label: "Explore Top 20 Results"
      url: "{{ link }}&limit=20"
      }
    html:
{% if value <= users.count._value %}
      <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ linked_value | number_with_delimiter }}</p>
{% elsif value > users.count._value %}
      <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
{% endif%}
;;
  }

}
