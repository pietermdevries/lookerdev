connection: "flightstats"

include: "/4_redshift/*.view.lkml"                # include all views in the views/ folder in this project


datagroup: test {
  sql_trigger: 1 ;;
}

explore: aircraft {
  view_label: "pieter"
  aggregate_table: region_rollup {
    query: {
      dimensions: [region, aircraft.air_worth_date]
      measures: [count]
      filters: {
        field: aircraft.air_worth_date
        value: "10 years"
      }
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }

  aggregate_table: region_status_distinct {
    query: {
      dimensions: [region]
      measures: [status_count]
      timezone: "America/Los_Angeles"
    }

    materialization: {
      persist_for: "24 hours"
    }
  }
}

explore: accidents {
}
