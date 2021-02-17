connection: "pieter_bq"
include: "/2_bq/*"              # include all views in the views/ folder in this project


explore: transactions {
  always_filter: {
    filters: [transactions.date_filter: "Today"]
  }
  join: blocks {
    relationship: one_to_many
    sql_on: ${transactions.block_hash} = ${blocks.hash} ;;
  }
}
