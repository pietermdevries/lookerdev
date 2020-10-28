view: events {
  sql_table_name: "PUBLIC"."EVENTS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}."BROWSER" ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
    html: {{value}} and {{ count._value}} ;;
  }

  parameter: test {
    allowed_value: {
      label: "bob"
      value: "bob"
    }
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
    html: {{value}} and {{ count._value}} ;;
  }

  filter: US {
    type: yesno
    sql: ${country} = 'USA' ;;
    default_value: "No"
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
      year,
      day_of_month,
      month_name
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: date{
    label_from_parameter: date_granularity
    type: date
    sql:
    CASE
    WHEN {% parameter date_granularity %} = 'Week' THEN ${created_week}
    WHEN {% parameter date_granularity %} = 'Month' THEN ${created_month}
    ELSE ${created_week}
    END ;;
  }


  parameter: date_granularity {
    type: string
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}."EVENT_TYPE" ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}."IP_ADDRESS" ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}."OS" ;;
  }

  dimension: sequence_number {
    type: number
    sql: ${TABLE}."SEQUENCE_NUMBER" ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}."SESSION_ID" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
    html: {{value}} and {{ count._value}} ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}."TRAFFIC_SOURCE" ;;
  }

  dimension: uri {
    type: string
    sql: ${TABLE}."URI" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id]
  }

  measure: pic_count {
    type: count
    html: <img src="https://logo-core.clearbit.com/looker.com"{{value}} /> ;;
  }

  parameter: number_list {
    suggest_dimension: zip
    type: string
  }

  dimension: secondary_dimension {
    type: string
    sql: array_construct(
    TO_NUMBER(SPLIT_PART({% parameter number_list %}, ',', 1)),
    TO_NUMBER(
    IFF(SPLIT_PART({% parameter number_list %}, ',', 2) = '', 0, SPLIT_PART({% parameter number_list %}, ',', 2)))
    )
    ;;
  }

  dimension: foo {
    type: string
    sql: case
      when ${user_id} in
        (
        TO_NUMBER(SPLIT_PART({% parameter number_list %}, ',', 0),
        TO_NUMBER(IF(SPLIT_PART({% parameter number_list %}, ',', 1) = '', 0))
        ) then 'bob'
      else 'jack'
      end ;;
  }

  dimension: foo2 {
    type: string
    sql: case
      when ARRAY_CONTAINS(${user_id},${secondary_dimension}) then 'bob'
      else 'jack'
      end ;;
  }


  dimension: test_number {
    type: number
    sql: 0.00000080001 ;;
    value_format_name: "decimal_2"

  }

　measure: html_count {
　  type: count
    html: {{events.zip._value}} {{value}} ;;
　}

  dimension: rule_info {
    type: string
    sql: '1' ;;
    # html:
    # <ul>
    # <li> Hi, my name is bob </li>
    # <li> His name is Jack </li>
    # </ul> ;;
  }

}
