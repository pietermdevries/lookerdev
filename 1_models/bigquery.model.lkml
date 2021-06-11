connection: "dont_use_costs_me_money"
include: "/2_bq/*"              # include all views in the views/ folder in this project

explore: transactions {
  always_filter: {
    filters: [transactions.date_filter: "Today"]
  }
  join: blocks {
    relationship: one_to_many
    sql_on: ${transactions.block_hash} = ${blocks.hash} ;;
  }

  join: inputs {
    view_label: "Transcation Inputs"
    sql: LEFT JOIN UNNEST(transactions.inputs) as inputs ;;
    relationship: one_to_many
  }
}

explore: mat_test_fail {
  view_name: daily_views
}
explore: mat_test_success {
  view_name: daily_views2
}

explore: base_view {
  hidden: yes
}

explore: increment_NDT {}

explore: increment_SQL {}
