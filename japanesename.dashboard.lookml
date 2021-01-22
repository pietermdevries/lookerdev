- dashboard: 日本語
  title: 日本語
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: New Tile
    name: New Tile
    model: flex_look
    explore: orders
    type: looker_grid
    fields: [orders.id, users.count]
    sorts: [users.count desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Email: users.email
      Status: orders.status
    row: 0
    col: 0
    width: 8
    height: 6
  - title: Alert Test Working?
    name: Alert Test Working?
    model: snowflake
    explore: events
    type: looker_column
    fields: [events.browser, events.created_month_name, events.count]
    pivots: [events.created_month_name]
    filters:
      events.created_date: 1 quarters
    sorts: [events.count desc 0, events.created_month_name]
    column_limit: 50
    dynamic_fields: [{table_calculation: tablecalc, label: TableCalc, expression: "${events.count}+1",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: tablecalc2, label: Tablecalc2, expression: "${tablecalc}+1",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_labels:
      January - 1 - tablecalc: TableCalc
    defaults_version: 1
    listen: {}
    row: 6
    col: 0
    width: 8
    height: 6
  - title: Alert Test Bugged?
    name: Alert Test Bugged?
    model: snowflake
    explore: events
    type: looker_column
    fields: [events.browser, events.created_month_name, events.count]
    pivots: [events.created_month_name]
    filters:
      events.created_date: 1 quarters
    sorts: [events.count desc 0, events.created_month_name]
    column_limit: 50
    dynamic_fields: [{table_calculation: tablecalc, label: TableCalc, expression: "${events.count}+1",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_labels:
      January - 1 - tablecalc: TableCalc
    defaults_version: 1
    listen: {}
    row: 0
    col: 8
    width: 8
    height: 6
