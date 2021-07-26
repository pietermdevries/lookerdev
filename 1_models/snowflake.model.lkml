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
  aggregate_table: browser_count {
    query: {
      dimensions: [events.browser]
      measures: [events.count]
    }
    materialization: {
      sql_trigger_value: 1 ;;
    }
  }
  join: event_dt {
    sql_on: ${event_dt.browser} = ${events.browser} ;;
  }

}
explore: inventory_items {

}

explore: event_ndt {
  view_name: events
  join: events_ndt1 {
    sql: ${events.created_date} = ${events_ndt1.created_date} ;;
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


explore: testevents {
  from: events
  join: products {
    sql_on: ${testevents.browser} = ${testevents.language} ;;
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
