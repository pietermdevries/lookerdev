view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    html: <a href= "/explore/testpieter/orders?fields=orders.user_id,orders.status,orders.count&f[orders.status]={{value}}&f[orders.created_date]={{_filters['orders.created_date']}}"
    </a> {{value}};;
    }

    dimension: status2 {
      sql: case when ${status} = "pending" then "bob"
      else ${status} end;;
    }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
    link: {
      label: "Jump to User ID number {{ value }}"
      url: "/dashboards-next/248?User+ID={{value}}&Status={{orders.status._value}}&Created+Date={{_filters['orders.created_date']}}"
      icon_url: "http://www.looker.com/favicon.ico"
      }
  }

  dimension: testno {
    description: "Flags whether Placement has already been extended"
    type: yesno
    sql: ${user_id} < 10 ;;
    link: {
      label:
      "{% if orders.testno._value %}
      Here we go baby {{ orders.testno._value }}
      {% else %}
      NULL
      {% endif %}"
      url:
      "{% if orders.testno._value %}
      https://nationalpostcom.files.wordpress.com/2020/01/tim-hortons-1.jpg
      {% else %}
      NULL
      {% endif %}
      "
      icon_url: "https://jobadder.com/wp-content/uploads/cropped-JA-FAVICON-32x32.png"
    }
  }

  dimension: testnohtml {
    description: "Flags whether Placement has already been extended"
    type: yesno
    sql: ${user_id} < 10 ;;
    html:
    {% if orders.user_id< 10  %}
    <a href="https://nationalpostcom.files.wordpress.com/2020/01/tim-hortons-1.jpg">{{ value }}</a>
    {% else %}
    {{value}}
    {% endif %}
    ;;

  }

  measure: sum_of_id_with_drill {
    type: sum
    sql: ${id} ;;
    link: {
      url: "{{dummy._link}}&sorts=orders.id+desc"
      label: "Click Me"
    }
  }

  measure: dummy {
    label: "{% if _model._name == 'thelook' %} I am a liquid Label I don't Know How to WORDWRAP {% else %} I am a liquid Label I don't Know How to WORDWRAP {% endif %}"
    type: sum
    hidden: yes
    sql: 0 ;;
    drill_fields: [id,created_date,status,count]
  }

  dimension: user_sort {
    type: number
    sql: ${user_id} ;;
    drill_fields: [detail*]
    link: {label: "Explore Top 20 Results by Sale Price" url: "{{ link }}&sorts=order_items.sale_price+desc&limit=20" }
  }

  measure: bucks_sort {
    type: number
    sql: ${count}*${order_items.sale_price} ;;
    drill_fields: [detail*]
    link: {label: "Explore Top 20 Results by count" url: "{{ link }}&sorts=count+desc&limit=20" }
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.id, users.first_name, order_items.count]
  }

  set: detail {
    fields: [order_items.sale_price,count]
    }
}
