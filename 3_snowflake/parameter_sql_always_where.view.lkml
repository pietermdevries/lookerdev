view: parameter_sql_always_where {
  derived_table: {
  sql:
    SELECT *
    FROM "PUBLIC"."EVENTS" ;;
  }

  dimension: country {
    sql: ${TABLE}.country ;;
    suggest_persist_for: "0 seconds"
  }

  dimension: city {
    sql: ${TABLE}.city ;;
    suggest_persist_for: "0 seconds"
  }

  parameter: country_name {
    default_value: "US"
    suggest_dimension: country
    suggest_persist_for: "0 seconds"
  }

  parameter: city_name {
    default_value: "New York"
    suggest_dimension: city
    suggest_persist_for: "0 seconds"
  }

 }


# sql_always_where: ${year_lookup.display_year} between '2006' and '2025'
# and ${geography.grouptype} = {% parameter geography.geo_custom_group %}
# and ${channelformatgrouping.grouptype} = {% parameter channelformatgrouping.channel_custom_group %}
# and ${geography.market} not in
# (
# 'Greenland',
# 'Canary Islands',
# 'Kiribati',
# 'Seychelles',
# 'Solomon Islands',
# 'Vanuatu',
# 'Tahiti',
# 'Vatican City'
# );;
