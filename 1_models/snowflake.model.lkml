connection: "snowlooker"
include: "/hidetitel.dashboard.lookml"
include: "/testboard.dashboard.lookml"
include: "/japanesename.dashboard.lookml"
include: "/radial_gauge.dashboard.lookml"
include: "/3_snowflake/*.view.lkml"                # include all views in the views/ folder in this project


explore: pieter_events {
  view_name: events
  group_label: "pieter"
  query: pivots {
    dimensions: [browser, created_month_name]
    measures: [count]
    filters: [events.created_date: "1 quarters"]
    pivots: [created_month_name]
  }

}

explore: extended_events {
  extends: [pieter_events]
  view_name: events
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

# Place in `snowflake` model
explore: +languages {
  aggregate_table: rollup__language {
    query: {
      dimensions: [language]
      timezone: "Japan"
      filters: [languages.japanese: "日本語"]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }
}

explore: users {
  always_filter: {
    filters: [users.created_date: "2 months"]
}
}

explore: sets {
  view_name: events
  fields: [set_experiment.test_set*]
  join: set_experiment {}
}
