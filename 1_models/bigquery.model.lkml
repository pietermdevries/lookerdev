connection: "pieter_bq_dont_use_me"

include: "/2_bq/*/*"                # include all views in the views/ folder in this project

explore: orders {
  from:  orders
}
