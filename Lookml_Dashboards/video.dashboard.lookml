- dashboard: video
  title: Video
  layout: newspaper
  elements:
  - title: Views over time
    name: Views over time
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: looker_area
    fields: [channel_basic_a2_daily_first.views, channel_basic_a2_daily_first._data_date,
      channel_basic_a2_daily_first.avg_watch_time]
    sorts: [channel_basic_a2_daily_first._data_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: channel_basic_a2_daily_first.views,
            id: channel_basic_a2_daily_first.views, name: Views}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: channel_basic_a2_daily_first.avg_watch_time,
            id: channel_basic_a2_daily_first.avg_watch_time, name: Avg Watch Time}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    swap_axes: false
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Video_Name: video_info.video_name
      Date Filter: channel_basic_a2_daily_first._data_date
    row: 7
    col: 16
    width: 8
    height: 5
  - title: Likes vs Dislikes
    name: Likes vs Dislikes
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: looker_column
    fields: [channel_basic_a2_daily_first._data_date, channel_basic_a2_daily_first.likes,
      channel_basic_a2_daily_first.dislikes]
    sorts: [channel_basic_a2_daily_first._data_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: true
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: channel_basic_a2_daily_first.likes,
            id: channel_basic_a2_daily_first.likes, name: Likes}, {axisId: channel_basic_a2_daily_first.dislikes,
            id: channel_basic_a2_daily_first.dislikes, name: Dislikes}], showLabels: true,
        showValues: false, minValue: !!null '', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      channel_basic_a2_daily_first.likes: "#C2DD67"
      channel_basic_a2_daily_first.dislikes: "#B32F37"
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    swap_axes: false
    show_null_points: true
    interpolation: linear
    title_hidden: true
    listen:
      Video_Name: video_info.video_name
      Date Filter: channel_basic_a2_daily_first._data_date
    row: 4
    col: 8
    width: 8
    height: 5
  - title: Comments over time
    name: Comments over time
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: looker_line
    fields: [channel_basic_a2_daily_first._data_date, channel_basic_a2_daily_first.comments]
    sorts: [channel_basic_a2_daily_first._data_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    swap_axes: false
    show_null_points: true
    interpolation: linear
    listen:
      Video_Name: video_info.video_name
      Date Filter: channel_basic_a2_daily_first._data_date
    row: 9
    col: 8
    width: 4
    height: 5
  - title: Shares over time
    name: Shares over time
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: looker_line
    fields: [channel_basic_a2_daily_first._data_date, channel_basic_a2_daily_first.shares]
    sorts: [channel_basic_a2_daily_first._data_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: channel_basic_a2_daily_first.shares,
            id: channel_basic_a2_daily_first.shares, name: Shares}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    swap_axes: false
    show_null_points: true
    interpolation: linear
    listen:
      Video_Name: video_info.video_name
      Date Filter: channel_basic_a2_daily_first._data_date
    row: 9
    col: 12
    width: 4
    height: 5
  - title: Name
    name: Name
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: single_value
    fields: [video_info.title]
    filters:
      channel_basic_a2_daily_first.video_id: "-NULL"
    limit: 1
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen:
      Video_Name: video_info.video_name
    row: 0
    col: 0
    width: 4
    height: 2
  - name: Vs Average Views
    title: Vs Average Views
    merged_queries:
    - model: thesis_cool
      explore: channel_basic_a2_daily_first
      type: looker_line
      fields: [channel_basic_a2_daily_first.views, video_days.days_after_post]
      filters:
        video_days.days_after_post: NOT NULL
      sorts: [channel_basic_a2_daily_first.views desc]
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields: []
    - model: thesis_cool
      explore: channel_basic_a2_daily_first
      type: looker_line
      fields: [channel_basic_a2_daily_first.view_per_video, video_days.days_after_post]
      filters:
        video_days.days_after_post: NOT NULL
      sorts: [channel_basic_a2_daily_first.view_per_video desc]
      limit: 500
      column_limit: 50
      query_timezone: America/Los_Angeles
      x_axis_gridlines: false
      y_axis_gridlines: false
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: false
      show_x_axis_ticks: true
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      plot_size_by_field: false
      trellis: ''
      stacking: ''
      limit_displayed_rows: false
      legend_position: center
      series_types: {}
      point_style: none
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      swap_axes: false
      show_null_points: true
      interpolation: linear
      join_fields:
      - field_name: video_days.days_after_post
        source_field_name: video_days.days_after_post
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
        reverse: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: channel_basic_a2_daily_first.views,
            id: channel_basic_a2_daily_first.views, name: Views}, {axisId: channel_basic_a2_daily_first.view_per_video,
            id: channel_basic_a2_daily_first.view_per_video, name: View per Video}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: '', orientation: right, series: [
          {axisId: vs_average, id: vs_average, name: "% vs Average"}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
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
    series_types:
      channel_basic_a2_daily_first.views: column
      channel_basic_a2_daily_first.view_per_video: column
    point_style: none
    series_colors:
      calculation_1: "#9174F0"
    series_labels:
      channel_basic_a2_daily_first.view_per_video: Average Views
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    type: looker_line
    dynamic_fields: [{table_calculation: vs_average, label: "% vs Average", expression: "${channel_basic_a2_daily_first.views}/${channel_basic_a2_daily_first.view_per_video}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    listen:
    - Video_Name: video_info.video_name
    -
    row: 14
    col: 8
    width: 8
    height: 6
  - title: Posted Date
    name: Posted Date
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: single_value
    fields: [video_days.post_date_date]
    fill_fields: [video_days.post_date_date]
    limit: 500
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen:
      Video_Name: video_info.video_name
    row: 0
    col: 4
    width: 4
    height: 2
  - name: Video Base Analysis
    type: text
    title_text: Video Base Analysis
    subtitle_text: Section 1
    body_text: 1.  This information's purpose is to show a video's recent KPIs
    row: 5
    col: 0
    width: 8
    height: 7
  - name: Cohort Base Analysis
    type: text
    title_text: Cohort Base Analysis
    subtitle_text: Section 2
    body_text: 1.  This information's purpose is to show a video's KPIs in relation
      to other videos in order to give context.
    row: 12
    col: 0
    width: 8
    height: 6
  - title: Subscription movement
    name: Subscription movement
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: looker_column
    fields: [channel_basic_a2_daily_first.subscribers_gained, channel_basic_a2_daily_first.subscribers_lost,
      channel_basic_a2_daily_first._data_date]
    fill_fields: [channel_basic_a2_daily_first._data_date]
    sorts: [channel_basic_a2_daily_first._data_date desc]
    limit: 500
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: channel_basic_a2_daily_first.subscribers_gained,
            id: channel_basic_a2_daily_first.subscribers_gained, name: Subscribers
              Gained}, {axisId: channel_basic_a2_daily_first.subscribers_lost, id: channel_basic_a2_daily_first.subscribers_lost,
            name: Subscribers Lost}], showLabels: true, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      channel_basic_a2_daily_first.subscribers_gained: "#C2DD67"
      channel_basic_a2_daily_first.subscribers_lost: "#B32F37"
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Video_Name: video_info.video_name
      Date Filter: channel_basic_a2_daily_first._data_date
    row: 2
    col: 16
    width: 8
    height: 5
  - title: Sum Subscriber Change
    name: Sum Subscriber Change
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: single_value
    fields: [channel_basic_a2_daily_first.subscribers_gained, channel_basic_a2_daily_first.subscriber_change,
      channel_basic_a2_daily_first.subscribers_lost]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen:
      Video_Name: video_info.video_name
      Date Filter: channel_basic_a2_daily_first._data_date
    row: 0
    col: 16
    width: 8
    height: 2
  - title: Sum Subscriber Change (copy)
    name: Sum Subscriber Change (copy)
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: single_value
    fields: [channel_basic_a2_daily_first.likes, channel_basic_a2_daily_first.like_change]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Video_Name: video_info.video_name
      Date Filter: channel_basic_a2_daily_first._data_date
    row: 0
    col: 8
    width: 8
    height: 2
  - title: Demographic Sankey
    name: Demographic Sankey
    model: thesis_cool
    explore: demographics_dt
    type: Sankey
    fields: [demographics_dt.gender, demographics_dt.age_group, demographics_dt.subscribed_status,
      demographics_dt.count]
    sorts: [demographics_dt.age_group]
    limit: 500
    color_range: ["#dd3333", "#80ce5d", "#f78131", "#369dc1", "#c572d3", "#36c1b3",
      "#b57052", "#ed69af"]
    label_type: name_value
    show_null_points: true
    series_types: {}
    listen:
      Video_Name: video_info.video_name
      Date Filter: demographics_dt._data_date
    row: 20
    col: 8
    width: 8
    height: 6
  - title: Traffic Source
    name: Traffic Source
    model: thesis_cool
    explore: traffic_source
    type: looker_pie
    fields: [traffic_source.traffic_source, traffic_source.views]
    filters:
      traffic_source.traffic_source: "-NULL"
    sorts: [traffic_source.views desc]
    limit: 500
    series_types: {}
    listen:
      Video_Name: video_info.video_name
      Date Filter: channel_basic_a2_daily_first._data_date
    row: 26
    col: 8
    width: 8
    height: 6
  - title: Search Terms
    name: Search Terms
    model: thesis_cool
    explore: traffic_source
    type: looker_grid
    fields: [traffic_source.views, traffic_source.traffic_source_detail, traffic_source.watch_time_minutes]
    filters:
      traffic_source.traffic_source: Youtube Search
      traffic_source.traffic_source_detail: "-NULL"
    sorts: [traffic_source.views desc]
    limit: 500
    dynamic_fields: [{table_calculation: average_watch_time, label: Average Watch
          TIme, expression: "${traffic_source.watch_time_minutes}/${traffic_source.views}",
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    series_cell_visualizations:
      traffic_source.views:
        is_active: true
      traffic_source.watch_time_minutes:
        is_active: true
      calculation_1:
        is_active: true
      average_watch_time:
        is_active: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Video_Name: video_info.video_name
      Date Filter: channel_basic_a2_daily_first._data_date
    row: 18
    col: 16
    width: 8
    height: 6
  - name: Vs Average Likes
    title: Vs Average Likes
    merged_queries:
    - model: thesis_cool
      explore: channel_basic_a2_daily_first
      type: looker_line
      fields: [video_days.days_after_post, channel_basic_a2_daily_first.like_change]
      filters:
        video_days.days_after_post: NOT NULL
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields: []
    - model: thesis_cool
      explore: channel_basic_a2_daily_first
      type: looker_line
      fields: [video_days.days_after_post, channel_basic_a2_daily_first.like_change_per_day]
      filters:
        channel_basic_a2_daily_first.video_id: ''
        video_days.days_after_post: NOT NULL
      sorts: [channel_basic_a2_daily_first.like_change_per_day desc]
      limit: 500
      column_limit: 50
      query_timezone: America/Los_Angeles
      x_axis_gridlines: false
      y_axis_gridlines: false
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: false
      show_x_axis_ticks: true
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      plot_size_by_field: false
      trellis: ''
      stacking: ''
      limit_displayed_rows: false
      legend_position: center
      series_types: {}
      point_style: none
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      swap_axes: false
      show_null_points: true
      interpolation: linear
      join_fields:
      - field_name: video_days.days_after_post
        source_field_name: video_days.days_after_post
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
        reverse: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: channel_basic_a2_daily_first.like_change,
            id: channel_basic_a2_daily_first.like_change, name: Like Change}, {axisId: channel_basic_a2_daily_first.like_change_per_day,
            id: channel_basic_a2_daily_first.like_change_per_day, name: Like Change
              per Day}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}, {label: '', orientation: right, series: [{axisId: vs_average,
            id: vs_average, name: "% vs Average"}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
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
    series_types:
      channel_basic_a2_daily_first.views: column
      channel_basic_a2_daily_first.view_per_video: column
      channel_basic_a2_daily_first.like_change: column
      channel_basic_a2_daily_first.like_change_per_day: column
    point_style: none
    series_colors:
      calculation_1: "#9174F0"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    type: looker_line
    dynamic_fields: [{table_calculation: vs_average, label: "% vs Average", expression: "${channel_basic_a2_daily_first.like_change}/${channel_basic_a2_daily_first.like_change_per_day}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    listen:
    - Video_Name: video_info.video_name
    -
    row: 12
    col: 16
    width: 8
    height: 6
  - title: Thumbnail (copy)
    name: Thumbnail (copy)
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: single_value
    fields: [video_info.title_pic]
    limit: 1
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Video_Name: video_info.video_name
    row: 2
    col: 4
    width: 4
    height: 3
  - title: Thumbnail (copy 2)
    name: Thumbnail (copy 2)
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: single_value
    fields: [video_info.episode_pic]
    limit: 1
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Video_Name: video_info.video_name
    row: 2
    col: 0
    width: 4
    height: 3
  - title: Metric Fun
    name: Metric Fun
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    type: looker_line
    fields: [channel_basic_a2_daily_first.metric_chooser, channel_basic_a2_daily_first._data_date,
      video_info.video_name]
    pivots: [video_info.video_name]
    filters:
      channel_basic_a2_daily_first.dynamic_measure: views
      channel_basic_a2_daily_first.metric_chooser: NOT NULL
    sorts: [channel_basic_a2_daily_first._data_date desc, video_info.video_name]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    listen:
      Video_Name: video_info.video_name
      Date Filter: channel_basic_a2_daily_first._data_date
    row: 18
    col: 0
    width: 8
    height: 6
  - name: Link to home Dashboard
    type: text
    title_text: Link to home Dashboard
    body_text: <a href="/dashboards/4" class="btn btn-primary">Go somewhere</a>
    row: 24
    col: 0
    width: 8
    height: 6
  filters:
  - name: Video_Name
    title: Video_Name
    type: field_filter
    default_value: '"1,2"'
    allow_multiple_values: true
    required: true
    model: thesis_cool
    explore: channel_basic_a2_daily_first
    listens_to_filters: []
    field: video_info.video_name
  - name: Date Filter
    title: Date Filter
    type: date_filter
    default_value: after 2 weeks ago
    allow_multiple_values: true
    required: false
