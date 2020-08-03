include: "/views/Basic.view"
view: basic_extend {
  extends: [channel_basic_a2_daily_first]

  measure: views {
    type: average
  }

  dimension: video_id {
    drill_fields: [basic_extend.views]
  }

  }
