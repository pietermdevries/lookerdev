- dashboard: 日本語
  title: 日本語
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - name: New Tile
  - title: alert-test
    name: alert-test
    model: testpieter
    explore: user_data
    type: single_value
    fields: [user_data.count]
    limit: 500
    total: true
    query_timezone: America/Los_Angeles
    series_types: {}
    listen: {}
    row: 6
    col: 0
    width: 8
    height: 6
  filters:
  - name: Stringfilter
    title: Stringfilter
    type: string_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_toggles
      display: popover
      options:
      - string1
      - string2
  - name: fieldfilter
    title: fieldfilter
    type: field_filter
    default_value: 3 months
    allow_multiple_values: true
    required: false
    model: base
    explore: inventory_items
    listens_to_filters: []
    field: inventory_items.created_month
  - name: Numberfilter
    title: Numberfilter
    type: number_filter
    default_value: ''
    allow_multiple_values: true
    required: false
  - name: Datefilter
    title: Datefilter
    type: date_filter
    default_value: 7 days
    allow_multiple_values: true
    required: false
