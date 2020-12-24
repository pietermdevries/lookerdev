connection: "flightstats"

include: "/4_redshift/*.view.lkml"                # include all views in the views/ folder in this project


explore: aircraft {
  view_label: "pieter"
  aggregate_table: region_rollup {
    query: {
      dimensions: [region]
      measures: [count]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }
}

explore: accidents {}