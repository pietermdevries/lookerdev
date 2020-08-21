view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    link: {
      label: "Jump to User ID number {{ value }}"
    }
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: genderhmtl {
    type: string
    sql: CASE WHEN ${age} > 20 THEN 21
          ELSE 1
          END;;
    html: <a href="#drillmenu" target="_self">
{% if value > 20 %}
男性
{% else %}
女性
{% endif %}
</a> ;;

  }
# CONNECTION METHODS
  dimension: connection_database {
    type: string
    group_label: "Connection Methods"
    sql: '{{ _connection._database }}' ;;
  }
  dimension: connection_schema {
    type: string
    group_label: "Connection Methods"
    sql: '{{ _connection._schema }}' ;;
  }
  dimension: connection_temp {
    type: string
    group_label: "Connection Methods"
    sql: '{{ _connection._temp }}' ;;
  }
#   dimension: connection_pdt_connection_registration {
#     type: string
#     group_label: "Connection Methods"
#     sql: '{{ _connection._pdt_connection_registration }}' ;;
#   }

  dimension: city {
    view_label: "Events"
    group_label: "test"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: date_value {
    sql: 1  ;;
    html: {{ users.created_month._value}} ;;
  }

  dimension: sql_date_value {
    sql: {{ users.created_month._value}} ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      pending_orders.count,
      user_data.count
    ]
  }
}
