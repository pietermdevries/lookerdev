- dashboard: bugtest
  title: bug-test
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - name: New Tile
    title: New Tile
    merged_queries:
    - model: testpieter
      explore: user_data
      type: table
      fields: [users.age, user_data.count]
      sorts: [user_data.count desc]
      limit: 500
      total: true
      dynamic_fields: [{table_calculation: of_total, label: "% of total", expression: "${user_data.count}/${user_data.count:total}",
          value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
          _type_hint: number}]
      query_timezone: America/Los_Angeles
    - model: thelook_snow
      explore: order_items
      type: table
      fields: [users.age, users.count]
      sorts: [users.count desc]
      limit: 500
      total: true
      dynamic_fields: [{table_calculation: of_total_2, label: "% of total 2", expression: "${users.count}/${users.count:total}",
          value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
          _type_hint: number}]
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: users.age
        source_field_name: users.age
    type: table
    row: 0
    col: 0
    width: 8
    height: 6
  - name: ''
    type: text
    body_text: |-
      <HTML>
      <BODY BGCOLOR="FFFFFF">

      <div class="vis">
      <CENTER><IMG SRC="https://www.go-teem.com/wp-content/uploads/2019/06/looker.png" height="200" width="270" ALIGN="CENTER"></CENTER>
      <font color="#00c4de" size="7"><center><b>Monthly Newsletter.
      </b></center></font>

      <HR>
      <CENTER>
      <a href="http://somegreatsite.com">Link Name</a>

      is a link to another nifty site

      <H1>This is a Header</H1>

      Send me mail at <a href="mailto:looker.support@kambi.com">

      looker.support@kambi.com</a>.

      <P> This is a new paragraph!

      <P> <B>This is a new paragraph!</B>

      <BR> <B><I>This is a new sentence without a paragraph break, in bold italics.</I></B>

      <HR>
      </CENTER>
      </BODY>

      </HTML>
      </div>
    row: 0
    col: 8
    width: 14
    height: 12
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
