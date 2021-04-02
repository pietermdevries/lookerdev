- dashboard: merged_results
  title: merged_results
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - name: title
    title: ""
    title_hidden: true
    merged_queries:
    - model: snowflake
      explore: languages
      type: table
      fields: [languages.language, languages.filter_test, count_of, languages.japanese]
      filters:
        languages.filter_test: "^ 日本語1"
      sorts: [languages.language]
      limit: 500
      dynamic_fields: [{measure: count_of, based_on: languages.language, expression: '',
          label: Count of, type: count_distinct, _kind_hint: measure, _type_hint: number}]
      query_timezone: America/Los_Angeles
    - model: snowflake
      explore: languages
      type: table
      fields: [languages.filter_test, languages.language]
      sorts: [languages.filter_test]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: languages.filter_test
        source_field_name: languages.filter_test
      - field_name: languages.language
        source_field_name: languages.language
    type: table
    pivots: [languages.japanese]
    listen:
    - Filter Test: languages.filter_test
    - Filter Test: languages.filter_test
    row: 26
    col: 0
    width: 21
    height: 7
  - name: "\""
    title: "\""
    merged_queries:
    - model: snowflake
      explore: events
      type: table
      fields: [events.browser, events.count, events.sequence_number]
      sorts: [events.count desc]
      limit: 500
      query_timezone: America/Los_Angeles
    - model: snowflake
      explore: events
      type: table
      fields: [events.browser, events.uri, events.traffic_source]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: events.browser
        source_field_name: events.browser
    type: table
    listen:
    - Created Date: events.created_date
    - Created Date: events.created_date
    row: 0
    col: 0
    width: 22
    height: 6
  - name: New Tile (Copiar)
    title: New Tile (Copiar)
    merged_queries:
    - model: snowflake
      explore: languages
      type: table
      fields: [languages.language, languages.filter_test, count_of]
      filters:
        languages.filter_test: "^ 日本語1"
      sorts: [languages.language]
      limit: 500
      dynamic_fields: [{measure: count_of, based_on: languages.language, expression: '',
          label: Count of, type: count_distinct, _kind_hint: measure, _type_hint: number}]
      query_timezone: America/Los_Angeles
    - model: snowflake
      explore: languages
      type: table
      fields: [languages.filter_test, languages.language]
      sorts: [languages.filter_test]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: languages.filter_test
        source_field_name: languages.filter_test
      - field_name: languages.language
        source_field_name: languages.language
    type: table
    pivots: [languages.filter_test]
    listen:
    - Filter Test: languages.filter_test
    - Filter Test: languages.filter_test
    row: 20
    col: 0
    width: 8
    height: 6
  - name: merged1 (Copy)
    title: merged1 (Copy)
    merged_queries:
    - model: snowflake
      explore: events
      type: table
      fields: [events.browser, events.count, events.sequence_number]
      sorts: [events.count desc]
      limit: 500
      query_timezone: America/Los_Angeles
    - model: snowflake
      explore: events
      type: table
      fields: [events.browser, events.uri, events.traffic_source]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: events.browser
        source_field_name: events.browser
    type: table
    pivots: [events.sequence_number, events.traffic_source]
    listen:
    - Created Date: events.created_date
    - Created Date: events.created_date
    row: 6
    col: 0
    width: 22
    height: 9
  - name: New Tile
    title: New Tile
    merged_queries:
    - model: snowflake
      explore: languages
      type: table
      fields: [languages.language, languages.filter_test, count_of]
      sorts: [languages.language]
      limit: 500
      dynamic_fields: [{measure: count_of, based_on: languages.language, expression: '',
          label: Count of, type: count_distinct, _kind_hint: measure, _type_hint: number}]
      query_timezone: America/Los_Angeles
    - model: snowflake
      explore: languages
      type: table
      fields: [languages.filter_test, languages.language]
      sorts: [languages.filter_test]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: languages.filter_test
        source_field_name: languages.filter_test
      - field_name: languages.language
        source_field_name: languages.language
    type: table
    pivots: [languages.filter_test]
    listen:
    - Filter Test: languages.filter_test
    - Filter Test: languages.filter_test
    row: 15
    col: 0
    width: 23
    height: 5
  filters:
  - name: Filter Test
    title: Filter Test
    type: field_filter
    default_value: "-NULL"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: snowflake
    explore: languages
    listens_to_filters: []
    field: languages.filter_test
  - name: Created Date
    title: Created Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: snowflake
    explore: events
    listens_to_filters: []
    field: events.created_date
