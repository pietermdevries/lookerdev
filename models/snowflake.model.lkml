connection: "snowlooker"
include: "/testboard.dashboard.lookml"
include: "/snowviews/*.view.lkml"                # include all views in the views/ folder in this project


explore: events {
  group_label: "pieter"
}

explore: lookml_novice_dt {}

explore: snow_pdt_users {}
