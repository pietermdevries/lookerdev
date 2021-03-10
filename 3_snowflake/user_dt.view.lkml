explore: user_dt {}
view: user_dt {
 derived_table: {
   sql:
  SELECT
  age,
  city,
  country
  FROM "PUBLIC"."USERS"
  WHERE id IN (
                SELECT ID
                FROM "PUBLIC"."USERS"
                WHERE {% condition age_filter%} age {% endcondition %}
              );;
 }

filter: age_filter {
  type: number
  default_value: "10"
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
