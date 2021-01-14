# include: "thelook.model.lkml"

##need to parameterize in where of dt sql param
view: lookml_novice_dt {
  derived_table: {
    sql: SELECT
          "CITY" AS "街",
          "CREATED_AT" AS created_date,
          COUNT(*) AS number_of_rows
          FROM "PUBLIC"."USERS"
          WHERE {% condition date_filter %} "CREATED_AT" {% endcondition %}
          ;;
  }

filter: date_filter {
  type: date
}

  dimension: city {
    sql: ${TABLE}."街" ;;
  }


  dimension: created_date {
    type: string
#     sql: ${TABLE}."CREATED_DATE" ;;
    sql:
      to_char(${TABLE}.created_date ,'DD/MM/YYYY')
 ;;
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
