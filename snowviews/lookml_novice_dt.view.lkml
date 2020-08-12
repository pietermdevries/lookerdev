# include: "thelook.model.lkml"

##need to parameterize in where of dt sql param
view: lookml_novice_dt {
  derived_table: {
    sql: SELECT
          "CITY" AS city,
          "CREATED_AT" AS created_date
          FROM "PUBLIC"."USERS"

           WHERE {% condition date_format %} date_format {% endcondition %};;
  }

#   filter: date_filter {
#     type: date
#   }
#
#   filter: date_filter_suggestions {
#     suggestions: ["13/01/2015","01/13/2015"]
#   }

  parameter: date_format {
    type: unquoted
    allowed_value: {
      label: "USA Style Dates"
      value: "USA"
    }
    allowed_value: {
      label: "EU Style Dates"
      value: "EU"
    }
  }

  dimension: city {
    sql: ${TABLE}."CITY" ;;
  }


  dimension: created_date {
    type: string
#     sql: ${TABLE}."CREATED_DATE" ;;
    sql:
    {% if date_format._parameter_value == "EU" %}
      to_char(${TABLE}.created_date ,'DD/MM/YYYY')
    {% else %}
      to_char(${TABLE}.created_date ,'MM/DD/YYYY')
    {% endif %}  ;;
  }

  dimension: html_date {
    type: date
    sql: ${TABLE}.created_date ;;
    html:{% if date_format._parameter_value == "EU" %}
          {{ rendered_value | date: "%m/%d/%Y"}}
        {% else %}
          {{ rendered_value | date: "%d/%m/%Y"}}
        {% endif %};;
  }

}
