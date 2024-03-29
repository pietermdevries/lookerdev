explore: test_events {
  view_name: events
  sql_always_where:
  ${events.created_raw} > CONCAT({% parameter events.start_month %},'-01') AND ${events.created_raw}  < CONCAT({% parameter events.end_month %},'-01') ;;
}

explore: filter_events {
  view_name: events
  always_filter: {
    filters: [events.created_date: "2 months"]
  }
}
include: "/field_extend.view"
view: events {
extends: [field_extend]
  sql_table_name: "PUBLIC"."EVENTS"
    ;;

dimension: return_sql_param {
  sql: {% parameter test_param %} ;;
}

dimension: return_user_att {
  sql:
  '{{_user_attributes['google_user_id']}}' ;;
}

  parameter: today {
    type: date
    convert_tz: no
    default_value: "today"
  }

dimension: is_last_day_of_month {
  type: yesno
  sql:
  EXTRACT( day from DATEADD(day,1,${created_raw}) ) = 1
  OR ${created_date} = DATE_TRUNC('DAY',DATEADD(day,-1,CURRENT_DATE()));;
}
measure: sum_stuff {
  type: sum
  filters: [is_last_day_of_month: "yes"]
  sql: ${id} ;;
}

dimension: yesterday {
  type: date
  sql: DATE_TRUNC('DAY',DATEADD(day,-1,CURRENT_DATE()))
  ;;
}

dimension: month_formatted {
  group_label: "Created" label: "Month"
  sql: ${created_month} ;;
  html: {{ rendered_value | append: "-01" | date: "%B %Y" }};;
}

parameter: start_month {
  default_value: "2020-01"
  type: string
  suggest_dimension: month_formatted
}

parameter: end_month {
  default_value: "2021-12"
  type: string
  suggest_dimension: month_formatted
  }

  dimension_group: filtered {
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
      month_num,
      day_of_week_index,
      day_of_week,
      hour_of_day,
      hour
    ]
    sql:
    CASE WHEN ${TABLE}."CREATED_AT" > CONCAT({% parameter start_month %},'-01') AND ${TABLE}."CREATED_AT" < CONCAT({% parameter end_month %},'-01') THEN ${TABLE}."CREATED_AT"
    ELSE null
    END
    ;;
    drill_fields: [country]
  }

parameter: test_param2 {
  label: "sql param"
  type: string
  default_value: "{% parameter choose_filter %}"
}

dimension: link_test {
  label: "1_house"
  type: string
  sql: ${id} ;;
  link: {
    label: "Testing"
    url: "{{ link }}&fields=events.browser"
  }

  # drill_fields: [browser]
}

parameter: choose_filter {
  type: unquoted
  default_value: "Chrome"
  allowed_value: {
    value: "Chrome"
  }
  allowed_value: {
    value: "etc."
  }
}

dimension: dynamic_filter {
  label: "2_house"
  type: string
  suggest_persist_for: "10 seconds"
  sql: ${TABLE}."BROWSER" IN (
  SELECT "BROWSER"
  FROM "PUBLIC"."EVENTS"
  WHERE "BROWSER" = {% parameter choose_filter %}) ;;
}



measure: date_list {
  type: list
  list_field: created_date
}

measure: browser_list {
  type: list
  list_field: browser
}

measure: max_date {
  type: date
  sql: max(${created_raw}) ;;
}
measure: max_browser {
  type: string
  sql: max(${browser}) ;;
}

measure: is_max_date {
  type: yesno
  required_fields: [created_date]
  sql: ${created_date} = ${max_date} ;;
}

parameter: param_test {
  label: "test1_param"
  type: number
}

  filter: filter_test {
    label: "test1_filter"
    type: number
    sql: {% condition filter_test %} ${dim_test} {% endcondition %} ;;
}

dimension: dim_test {
  label: "test1_dim"
  type: number
  sql: {% parameter param_test %} ;;
}

dimension: chosen_field {
  type: string
  sql: 1 ;;
    action: {
      label: "send to google sheets"
      url: "https://docs.google.com/spreadsheets/d/1kGcUnC0EjSwS93GMggDX1h8mhMmB_usmCyXZCuSyCzk/edit?usp=sharing&resourcekey=0-3avgEbQXCEMMulKI42gvbQ"
      icon_url: "https://looker.com/favicon.ico"
      form_url: "https://example.com/ping/{{ value }}/form.json"
      param: {
        name: "name string"
        value: "value string"
      }
}
}


dimension: whitespace {
  type: string
  sql: 'field ' ;;
}

dimension: dashboard_title {
  sql: 'Title' ;;
  html: <h1 style="color: #52C6EF;"> VP-C level Fraud Dashboard:</h1> <h2> Comparing <b>{{ rendered_value }}</b> with Benchmarks </h2>
  ;;
}

dimension: the_number_list {
  type: string
  sql: '[1,2,3]' ;;
}

# dimension: paragraph {
#   sql: "worst SAO game yet. I'm not even talking about the unpausable cutscenes, the terrible camera,
#         the ally AI, the terrible tutorials, the awful Chapter 1 or even the awful pacing.
#         It's just amazing how teams created this and thought, this is good and a quality team played it and thought this is what people want.
#         It boggles the mind. First of all the loading times, if you're playing it on the PS4 have social media,
#         a book or another game playing because you'll be getting further in those than this game with the loading times.
#         They are enough to make prey blush, and they're constant. At one point, you go from 2D scenes, to loading,
#         to walking to a wagon, to more loading, kill 1 enemy, and back to loading. Not just once, you do this multiple times.
#         Don't even expect the AI as in previous SAO games to be of any use, they barely attack even if you try to force them too.
#         Then again some mechanics only work if the game can be bothered, for example you learn fast travel points almost instantly" ;;
# }


dimension: array_test {
  sql: ARRAY_CONSTRUCT(${state},${city},${browser}) ;;
}

parameter: language_select {
  type: unquoted
  allowed_value: {
    label: "Japanese"
    value: "jp"
  }
  allowed_value: {
    label: "English"
    value: "en"
  }
}

dimension: day_rank {
  sql: (SELECT MIN(rank() over (order by "CREATED_AT"))
        FROM "PUBLIC"."EVENTS") ;;
}

  parameter: number_of_days_test {
    type: number
  }

  filter: date_selector_test {
    type: date
    sql: ${created_date} >= dateadd( day,interval -{% parameter number_of_days_test %},{% date_start date_selector_test %} )
        AND
        ${created_date} <= dateadd( day, interval {% parameter number_of_days_test %},{% date_start date_selector_test %}) ;;
  }

dimension: parameter_label {
  # label_from_parameter: language_select
  label: "
  {% if language_select._parameter_value   == 'jp' %}
  Japanese
  {%else%}
  Else
  {%endif%}
"
  sql:  ARRAY_CONSTRUCT(${state},${city},${browser})  ;;
  # html:
  # {% if language_select._parameter_value  == "jp" %}
  # Japanese {{value}}
  # {%else%}
  # {{value}}
  # {%endif%}
  # ;;
}

dimension: language {
  sql: {% parameter language_select %} ;;
}

  dimension: filter_value {
    sql: {% date_start created_date %}  ;;
  }

  # dimension: double_filter_value {
  #   sql: Concat(
  #   TO_VARCHAR( {% condition events.created_date %} ${TABLE}."CREATED_AT" {% endcondition %}),
  #   TO_VARCHAR( {% condition events.created_month %} ${TABLE}."CREATED_AT" {% endcondition %})
  #   );;
  # }

  parameter: test_year_date {
    type: number
    allowed_value: {
      value: "2020"
    }
    allowed_value: {
      value: "2021"
    }
    allowed_value: {
      value: "2019"
    }
  }

  filter: date_start {
    description: "start of the filter"
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

  measure: count_distinct_id {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [created_date, id]
  }

  measure: count_id {
    type: number
    sql: count(${id}) ;;
    drill_fields: [created_time, id]
  }

  dimension: browser {
    description: "These are browsers"
    # view_label:"
    # {% if _explore._name == 'jackson5'%}
    # Thriller
    # {% else %}
    # Testevents
    # {% endif %}"
    type: string
    sql: ${TABLE}."BROWSER" ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
    action: {
      label: "Label to Appear in Action Menu"
      url: "https://docs.google.com/spreadsheets/d/1kGcUnC0EjSwS93GMggDX1h8mhMmB_usmCyXZCuSyCzk/edit?resourcekey=0-3avgEbQXCEMMulKI42gvbQ#gid=0"
      icon_url: "https://looker.com/favicon.ico"
      form_url: "https://example.com/ping/{{ value }}/form.json"
      param: {
        name: "name string"
        value: "value string"
      }
    # html: {{value}} and {{ count._value}} ;;
  }
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
    label: "HAPPYDAY"
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
#    html: {{value}} and {{ count._value}} ;;
  }

  filter: date_filter {
    type: date
    default_value: "2 months"
  }

  measure: count_last_day {
    type: number
    sql:
    CASE WHEN ${created_date} = {% date_end date_filter%} THEN COUNT(${id})
    ELSE 0 END    ;;
  }

  filter: US {
    type: yesno
    sql: ${country} = 'USA' ;;
    default_value: "No"
  }

  dimension_group: created {
    description: "Date stuff"
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
      month_num,
      day_of_week_index,
      day_of_week,
      hour_of_day,
      hour,
      fiscal_year,
      fiscal_month_num
    ]
    sql: ${TABLE}."CREATED_AT" ;;
    drill_fields: [country]
    convert_tz: no
  }

  dimension: created_week_example {
    sql: ${created_week} ;;
    type: date
  }

  dimension: year_sentaku {
    group_label: "Created Date"
    type: string
    sql:
    CASE WHEN EXTRACT(year from ${created_time}::timestamp) = 2021 THEN '2021'
         WHEN EXTRACT(year from ${created_time}::timestamp) = 2020 THEN '2020'
         WHEN EXTRACT(year from ${created_time}::timestamp) = 2019 THEN '2019'
    ELSE null END ;;
  }


  dimension: half_year {
    group_label: "Created Date"
    type: string
    sql:
    CASE WHEN
    ${created_quarter} LIKE '%Q1' OR
    ${created_quarter} LIKE '%Q2' THEN '1H'
    ELSE '2H'
    END;;
  }

  dimension: formatted_time {
    type: string
    sql: ${created_time} ;;
    html: {{ rendered_value | date: "%F %T %P" }} PST;;
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

  parameter: date_detail {
    type: unquoted
    default_value: "Week"
    allowed_value: { value: "Hour" }
    allowed_value: { value: "Day" }
    allowed_value: { label:"Week (Mon-Sun)" value: "Week" }
    allowed_value: { label:"Week (Sun-Sat)" value: "WeekSunday" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Year" }
  }
  dimension: calendar {
    type: date_time
    label_from_parameter: date_detail
    sql:
    {% if date_detail._parameter_value == "WeekSunday" %}
    DATE_TRUNC('day',DATEADD('day', (0 - EXTRACT(DOW FROM ${created_raw})), ${created_raw}))
    {% else %}
    DATE_TRUNC({% parameter date_detail %}, ${created_raw})
    {% endif %} ;;
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

  measure: event_list {
    type: list
    list_field: event_type
    html: {{event_type._value}} and {{value}} and {{ip_address._value}} ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}."IP_ADDRESS" ;;
    # link: {
    #   url: "
    #   {% if value > 10 %}
    #   www.google.com
    #   {% else%}
    #   www.yahoo.com
    #   {% endif %}"
    # }
    link: {
      label: "link"
      url: "
      {% if ip_address._value > 10 %}
      https://www.google.com/
      {% else%}
      https://www.yahoo.com/
      {% endif %}"
    }

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

  ########

#   measure: sum_measure {
#     type: sum
#     sql: ${user_id} ;;
#     action: {
# label: "Update Transfer Form"
# url: "https://docs.google.com/spreadsheets/d/1bMnpB59leX9Vx1d9_8VEA23NVEMU8yaH4MVHoiYtDZQ/edit#gid=0"
# # form_url: ""
#     form_param: {
#       name: "Dispatch_ID"
#       type: string
#       label: "Enter Dispatch ID"
#       default: "{{ }}"
#       description: "Enter Dispatch"
#       required: yes
#     }
#   }
# }
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
    description: "This is my count."
    type: count
    drill_fields: [date,browser, count]
    # link: {
    #   label: "Explore Top 20 Results by count"
    #   url: "{{ link }}&sorts=order_items.sale_price+desc&limit=20"
    # }
    link: {
      label: "Link"
      url: "
      {% if _filters['events.browser'] == 'Chrome'%}
      Chrome Link
      {% else %}
      Not Chrome Link
      {% endif%}"
    }
    html:
    {% if value > 1000000000 %}
    ${{value | divided_by: 1000000000 | round:2 }}B
    {% elsif value >= 1000000 and value < 1000000000 %}
    ${{value | divided_by: 1000000 | round:2 }}M
    {% elsif value >= 1000 and value < 1000000 %}
    ${{value | divided_by: 1000 | round:2 }}K
    {% elsif value >= 0 and value < 1000 %}
    ${{value | round:2 }}
    {% elsif value > -1000 and value < 0 %}
    ${{value | round:2 }}
    {% elsif value > -1000000 and value <= -1000 %}
    ${{value | divided_by: 1000 | round:2 }}k
    {% elsif value > -1000000000 and value <= -1000000 %}
    ${{value | divided_by: 1000000 | round:2 }}M
    {% elsif value <= -1000000000 %}
    ${{value | divided_by: 1000000000 | round:2 }}B
    {% else %}
    'fail'
    {% endif %} ;;
  }

  parameter: choose_formatting {
    type: unquoted
    allowed_value: {
      value: "dollars"
    }
    allowed_value: {
      value: "else"
    }
  }


  measure: count_test_total {
    type: count
    value_format_name: decimal_0
    html:
    {% if choose_formatting._parameter_value == 'dollars'  %}
    $ {{rendered_value}}
    {% else %}
     {{rendered_value}}
    {%endif%};;
  }

  dimension: values {
    sql: 1 ;;
    html: {{ count._value }} ;;
  }

  measure: pop {
    type: percent_of_previous
    sql: ${count} ;;
    # html: {{ rendered_value | plus: 100 }}% ;;
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
    suggest_dimension: user_id
    type: string
  }

  dimension: secondary_dimension {
    type: string
    sql: array_construct(
          TO_NUMBER(SPLIT_PART({% parameter number_list %}, ',', 1)),
          TO_NUMBER(
                   IFF(
                    SPLIT_PART({% parameter number_list %}, ',', 2) = '', 0, SPLIT_PART({% parameter number_list %}, ',', 2)))
          )
          ;;
  }
  dimension: change_value {
    type: string
    sql: case
      when ARRAY_CONTAINS(${user_id},${secondary_dimension}) then 'changed value'
      else 'previous value'
      end ;;
  }
  dimension: user_id {
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }




  dimension: assigned {
    sql:
    {% assign array = number_list._parameter_value | split: "," %}
    array;;
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

  measure: count_with_text {
    type: count
    html: I have {{value}} cow's ;;
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

  measure: formatted_seconds {
    sql: ${user_id} ;;
    html: {{ rendered_value | round: 2 | date: "%M:%S" }};;
  }
}
