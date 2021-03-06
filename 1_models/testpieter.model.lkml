connection: "the_look"
include: "Athena.model"

# include all the views
include: "/views/**/*.view"

datagroup: testpieter_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

fiscal_month_offset: 2

persist_with: testpieter_default_datagroup

explore: company {
  join: trade_intent {
    type: left_outer
    sql_on: ${company.user_id} = ${trade_intent.id} ;;
    relationship: many_to_one
  }
}

explore: calendar_table {}

explore: connection_reg_r3 {}

explore: epoch_test {}

explore: mysql_events {
  view_name: events
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: ints {}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: order_items {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: one_to_many
  }
}

explore: pending_orders {
  join: users {
    type: left_outer
    sql_on: ${pending_orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: persons {}

explore: products {}

explore: schema_migrations {}

explore: test_img {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: users_nn {}

explore: xin_test_for_bug {}

explore: xin_test_for_bug2 {}
