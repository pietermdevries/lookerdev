include: "parameter_view.view"
explore: event_dt {}
view: event_dt {
extends: [parameter_view]
    derived_table: {
    sql:
    SELECT *,
    CASE WHEN "ID" < 1000 THEN 1
    ELSE 2 END AS "SALES"
    FROM "PUBLIC"."EVENTS"
    WHERE
      --TIMESTAMP(timestamp_add("CREATED_DATE", interval 9 hour),'Japan') >= {% date_start date_filter %} and TIMESTAMP("CREATED_DATE",'Japan') <= {% date_end date_filter %}
    {% condition country_filter %} "COUNTRY" {% endcondition %}

      ;;
    }
    drill_fields: [id]

  dimension: condition {
    type: string
    sql:
      IF(
        (TO_VARCHAR({% condition country_filter %} "COUNTRY" {% endcondition %}) = "1=1"),
        null,
        {% condition country_filter %} "COUNTRY" {% endcondition %})
    ;;
  }

  filter: date_filter {
    type: date_time
  }

  dimension: month_formatted {
    group_label: "Created" label: "Month"
    sql: ${created_month} ;;
    html: {{ rendered_value | append: "-01" | date: "%B %Y" }};;
  }

  filter: start_month {
    type: date
    suggest_dimension: month_formatted
  }

  filter: end_month {
    type: date
    suggest_dimension: month_formatted
  }
  dimension: sales {
    type: number
    sql: ${TABLE}."SALES" ;;
  }
  measure: total_sales {
    type: sum
    sql: ${sales} ;;
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
    }

    parameter: test {
      allowed_value: {
        label: "bob"
        value: "bob"
      }
    }

    filter: country_filter {
      suggest_dimension: country

    }

    dimension: country {
      type: string
      map_layer_name: countries
      sql: ${TABLE}."COUNTRY" ;;
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

    measure: html_count {
      type: count
      html: {{events.zip._value}} {{value}} ;;
    }

    measure: pic_count {
      type: count
      html: <img src="https://logo-core.clearbit.com/looker.com"{{value}} /> ;;
    }



}
