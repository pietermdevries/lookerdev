connection: "snowlooker"
include: "/testboard.dashboard.lookml"
include: "/snowviews/*.view.lkml"                # include all views in the views/ folder in this project


explore: events {
  group_label: "pieter"
}

explore: lookml_novice_dt {}

explore: snow_pdt_users {}

explore: parameter_sql_always_where {
  sql_always_where: ${parameter_sql_always_where.city} = {% parameter parameter_sql_always_where.city_name %}
  or ${parameter_sql_always_where.country} = {% parameter parameter_sql_always_where.country_name %}   ;;
}
