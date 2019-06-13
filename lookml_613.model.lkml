connection: "events_ecommerce"

# include all the views
include: "*.view"

datagroup: lookml_613_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

datagroup: etl_order_items {
  sql_trigger: select count(*) from public.order_items ;;
  max_cache_age: "4 hour"
}

persist_with: lookml_613_default_datagroup



explore: users {
  join: order_items {
    type: left_outer
    sql_on:  ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id};;
    relationship: one_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id};;
    relationship: many_to_one
  }

  join: user_order_fact {
    type: left_outer
    sql_on: ${users.id} = ${user_order_fact.user_id} ;;
    relationship: one_to_one
  }
}


explore: order_items {
  join: users {
    view_label: "Purchasing Users"
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
