view: user_order_fact {
  derived_table: {
    sql:
      SELECT
        user_id,
        sum(sale_price) as lifetime_value,
        count(distinct order_id) as lifetime_orders,
        min(created_at) as first_order,
        max(created_at) as last_order
      FROM public.order_items
      group by 1
       ;;
    datagroup_trigger: etl_order_items
    sortkeys: ["user_id"]
    distribution: "user_id"
  }

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_value {
    type: number
    sql: ${TABLE}.lifetime_value ;;
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.last_order ;;
  }

  measure: average_lifetime_value {
    type: average
    sql: ${lifetime_value} ;;
  }

  measure: total_lifetime_value {
    type: sum
    sql: ${lifetime_value} ;;
  }

}
