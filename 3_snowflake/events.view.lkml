view: events {
  sql_table_name: "PUBLIC"."EVENTS"
    ;;


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

  dimension: city_dim {
    type: string
    sql: CONCAT( '"' || ${TABLE}."CITY" || '"') ;;
  }

  parameter: city_param {
    type: unquoted
    suggest_dimension: city_dim
  }

  measure: city_list {
    type: list
    list_field: city
  }

  parameter: test {
    allowed_value: {
      label: "bob"
      value: "bob"
    }
  }

  set: detail {
    fields: [city, country]
}
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
#    html: {{value}} and {{ count._value}} ;;
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
    drill_fields: [detail*, count]
    link: {
      label: "Explore Top 20 Results by count"
      url: "{{ link }}&sorts=order_items.sale_price+desc&limit=20"
    }
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

  dimension: userattr_name {
    type: string
    sql: {% if _user_attributes['name'] == 'Pieter deVries' %}
          ${city}
         {% else %}
          ${browser}
         {% endif %};;
  }

  dimension: me {
    sql: 'Pieter DeVries' ;;
    hidden: yes
  }

  dimension: is_pieter {
    type: yesno
    sql: ${me} = '{{ _user_attributes['name'] }}'  ;;
  }

  filter: this_period_filter {
    type: date
    description: "Use this filter to define the current and previous period for analysis"
    sql: ${period} IS NOT NULL ;;

  }

# ${created_raw} is the timestamp dimension we are building our reporting period off of

  dimension: period {
    type: string
    description: "The reporting period as selected by the This Period Filter"
    sql:
    CASE
      WHEN {% date_start this_period_filter %} is not null AND {% date_end this_period_filter %} is not null /* date ranges or in the past x days */
        THEN
          CASE
            WHEN ${created_raw} >= {% date_start this_period_filter %}
              AND ${created_raw} <= {% date_end this_period_filter %}
              THEN 'This Period'
            WHEN ${created_raw} >= DATEADD(day,-1*DATEDIFF(day,{% date_start this_period_filter %}, {% date_end this_period_filter %} ) + 1, DATEADD(day,-1,{% date_start this_period_filter %} ) )
              AND ${created_raw} < DATEADD(day,-1,{% date_start this_period_filter %} ) + 1
              THEN 'Previous Period'
          END
        WHEN {% date_start this_period_filter %} is null AND {% date_end this_period_filter %} is null /* has any value or is not null */
          THEN CASE WHEN ${created_raw} is not null THEN 'Has Value' ELSE 'Is Null' END
        WHEN {% date_start this_period_filter %} is null AND {% date_end this_period_filter %} is not null /* on or before */
          THEN
            CASE
              WHEN ${created_raw} <= {% date_end this_period_filter %} THEN 'In Period'
              WHEN ${created_raw} > {% date_end this_period_filter %} THEN 'Not In Period'
            END
          WHEN {% date_start this_period_filter %} is not null AND {% date_end this_period_filter %} is null /* on or after */
            THEN
              CASE
                WHEN ${created_raw} >= {% date_start this_period_filter %} THEN 'In Period'
                WHEN ${created_raw} < {% date_start this_period_filter %} THEN 'Not In Period'
              END
            END ;;
    }
}
