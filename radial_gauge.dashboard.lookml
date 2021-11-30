- dashboard: vis_check
  title: vis_check
  layout: newspaper
  # preferred_viewer: dashboards-next
  elements:
  - title: New Tile
    name: New Tile
    model: snowflake
    explore: events
    type: marketplace_viz_radial_gauge::radial_gauge-marketplace
    fields: [events.count, events.browser]
    sorts: [events.count desc]
    limit: 500
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    series_types: {}
    defaults_version: 0
    row:
    col:
    width:
    height:
