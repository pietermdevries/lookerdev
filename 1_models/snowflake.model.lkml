connection: "snowlooker"
include: "/testboard.dashboard.lookml"
include: "/japanesename.dashboard.lookml"
include: "/3_snowflake/*.view.lkml"                # include all views in the views/ folder in this project


explore: events {
  query: pivots {
    dimensions: [browser, created_month_name]
    measures: [count]
    filters: [events.created_date: "1 quarters"]
    pivots: [created_month_name]
  }

  group_label: "pieter"
}

explore: lookml_novice_dt {}

explore: snow_pdt_users {}

explore: parameter_sql_always_where {
  sql_always_where: ${parameter_sql_always_where.city} = {% parameter parameter_sql_always_where.city_name %}
  or ${parameter_sql_always_where.country} = {% parameter parameter_sql_always_where.country_name %}   ;;
}


explore: test_events {
  from: events
  join: products {
    sql_on: ${test_events.browser} = ${test_events.language} ;;
  }
}
