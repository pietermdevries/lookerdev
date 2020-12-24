include: "/field_extend.view"
view: events {
extends: [field_extend]
  sql_table_name: "PUBLIC"."EVENTS"
    ;;


dimension: dashboard_title {
  sql: 'Title' ;;
  html: <h1 style="color: #52C6EF;"> VP-C level Fraud Dashboard:</h1> <h2> Comparing <b>{{ rendered_value }}</b> with Benchmarks </h2>
  ;;
}

dimension: array_test {
  sql: ARRAY_CONSTRUCT(${state},${city},${browser}) ;;
}

parameter: language_select {
  allowed_value: {
    label: "Japanese"
    value: "jp"
  }
  allowed_value: {
    label: "English"
    value: "en"
  }
}

dimension: language {
  sql: {% parameter language_select %} ;;
}

  dimension: filter_value {
    sql: {% date_start created_date %}  ;;
  }

  dimension: double_filter_value {
    sql: Concat(
    TO_VARCHAR( {% condition events.created_date %} ${TABLE}."CREATED_AT" {% endcondition %}),
    TO_VARCHAR( {% condition events.created_month %} ${TABLE}."CREATED_AT" {% endcondition %})
    );;
  }

  filter: date_start {
    type: date
    default_value: "7 days ago"
  }

  filter: date_end {
    type: date
  }

  dimension: test_date {
    type: date
    sql: ${created_date} BETWEEN ${date_start} AND ${date_end};;
  }

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
    # html: {{value}} and {{ count._value}} ;;
  }

  dimension: user_loc {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: rank9 {
    type: string
    sql: '9位' ;;
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
    fields: [city, country,created_date,event_type,city,browser,traffic_source,zip,city_dim,city_list,city_param,count,country,created_date]
  }
  set: detail2 {
    fields: [super_long,city, country,created_date,event_type,city,browser,traffic_source,zip,city_dim,created_day_of_month,created_month,created_day_of_month,created_time,longitude,latitude]
  }

  dimension: super_long {
    sql: ${browser} || ${city} || ${browser}
    ;;  }

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
      month_name,
      day_of_week_index,
      day_of_week,
      hour_of_day
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
    # html: {{value}} and {{ count._value}} ;;
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

  ########

  measure: sum_measure {
    type: sum
    sql: ${user_id} ;;
    html:
    <p><font style="color:grey;font-size:25px;"> {{rendered_value}} </font><br>
    <font style="color:red;font-size:6px;"> (No "A" read) </font></p>;;
  }

  measure: avg_measure {
    type: average
    sql: ${user_id} ;;
  }

  #######

  dimension: zip {
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*, count]
    # link: {
    #   label: "Explore Top 20 Results by count"
    #   url: "{{ link }}&sorts=order_items.sale_price+desc&limit=20"
    # }
  }

  measure: chrome_users {
    type: number
    sql: COUNT(CASE WHEN (events."BROWSER") LIKE (CAST('%' AS VARCHAR) || CAST(REPLACE(REPLACE(REPLACE('Chrome', '^', '^^'), '%', '^%'), '_', '^_') AS VARCHAR) || CAST('%' AS VARCHAR)) ESCAPE '^' THEN 1 ELSE NULL END) ;;
  }

  measure: count2 {
    type: count
    drill_fields: [detail2*]
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

  measure: liquid_label {
    description: "Budget Filterで選択した項目の予定値を表示します。"
    type: sum
    label:"
    {% parameter date_granularity %}
    "
    sql: ${sequence_number} ;;
  }
}