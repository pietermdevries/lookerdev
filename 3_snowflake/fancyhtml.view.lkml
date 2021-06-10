explore: fancyhtml {}
view: fancyhtml {
  sql_table_name: "PUBLIC"."PRODUCTS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }



  measure: html1 {
    sql: ${cost};;
    type: sum
    html:
      <div style="text-align: center; height: 70px;">
        <ul>
          <li>
              <span style="color: #FA5C76;font-weight:bold;font-size:15px;">{{rendered_value}}</span>
          </li>
          <li><span>{{fancyhtml._rendered_value}} → {{fancyhtml._rendered_value}}</span></li>
          <li><span>({% if fancyhtml._value > 0 %}+{% endif %}{{fancyhtml._rendered_value}})</span>
          </li>
        </ul>
      </div> ;;
  }

  }
