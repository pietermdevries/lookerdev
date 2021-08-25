explore: languages {}
view: languages {

derived_table: {
  sql: SELECT
  'English' AS language, ' English1' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'English' AS language, ' English2' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Japanese' AS language, ' 日本語1' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Japanese' AS language, ' 日本語2' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Korean' AS language, ' 한국어1' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Korean' AS language, ' 한국어2' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Chinese' AS language, ' 中文1' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Chinese' AS language, ' 中文2' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Russian' AS language, ' русский1' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Russian' AS language, ' русский2' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Italian' AS language, ' italiana1' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Italian' AS language, ' italiana2' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Thai' AS language, ' ไทย1' AS _filter_test, '日本語' AS pure_japanese
UNION ALL
SELECT
  'Thai' AS language, ' ไทย2' AS _filter_test, '日本語' AS pure_japanese
 ;;
}

dimension: language {
  sql: ${TABLE}.language ;;
}

  dimension: filter_test {
    sql: ${TABLE}._filter_test ;;
  }

  dimension: japanese {
    sql: ${TABLE}.pure_japanese ;;
  }


#### CUSTOMER CODE #####

  # parameter: atributos_cliente {
  #   type: unquoted
  #   default_value: "ClienteCanal"
  #   allowed_value: { label: "Área" value: "ClienteAreaISCAM"}
  #   allowed_value: { label: "Canal" value: "ClienteCanal"}
  #   allowed_value: { label: "Grupo" value: "ClienteGrupo"}
  #   allowed_value: { label: "Cadena" value: "ClienteCadena"}
  #   allowed_value: { label: "Cliente" value: "Cliente"}
  #   allowed_value: { label: "Cedis" value: "Cedis"}
  # }

  # dimension: atr_cli_seleccionado {
  #   hidden: no
  #   label_from_parameter: atributos_cliente
  #   description: "Dimensión dinámica que requiere el parametro 'Atributos Cliente' del aparteado 'Filters Only'"
  #   type: string
  #   sql:
  #   {% if tbl_master.atributos_cliente._parameter_value == 'ClienteAreaISCAM' %} ${cliente_area_iscam}
  #   {% elsif tbl_master.atributos_cliente._parameter_value == 'ClienteCanal' %} ${cliente_canal}
  #   {% elsif tbl_master.atributos_cliente._parameter_value == 'ClienteGrupo' %} ${cliente_grupo}
  #   {% elsif tbl_master.atributos_cliente._parameter_value == 'ClienteCadena' %} ${cliente_cadena}
  #   {% elsif tbl_master.atributos_cliente._parameter_value == 'Cliente' %} ${cliente}
  #   {% else %} ${cedis}
  #   {% endif %};;
  #   drill_fields: [cliente_area_iscam, cliente_canal, cliente_grupo, cliente_cadena, cliente,cedis]
  #   link: {
  #     label: "1) Sell In - Volumen"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/54?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Área={{_filters['cliente_area_iscam']}}&T.+Envase={{_filters['recurso_tipo_envase']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "2) Sell In - Meses Abiertos/Cerrados"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/58?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Área={{_filters['cliente_area_iscam']}}&T.+Envase={{_filters['recurso_tipo_envase']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "3) Sell In - Venta Neta"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/59?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Área={{_filters['cliente_area_iscam']}}&T.+Envase={{_filters['recurso_tipo_envase']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "4) Sell In - Estructura Comercial"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/70?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Área={{_filters['cliente_area_iscam']}}&T.+Envase={{_filters['recurso_tipo_envase']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Venta={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "PPFs"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/87?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Área={{_filters['cliente_area_iscam']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "Fill Rate"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/81?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "Dias de Cobertura"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/61?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Área={{_filters['cliente_area_iscam']}}&T.+Envase={{_filters['recurso_tipo_envase']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "Sell Out"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/26?Date={{_filters['FechaCorta_date']}}&Unidad+Neg={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoria={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Subcategoria={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&SubSegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Recurso={% parameter atributos_recurso %}"
  #   }
  # }

  # parameter: atributos_cedis {
  #   type: unquoted
  #   default_value: "ClienteCanal"
  #   allowed_value: { label: "Cedis Concentrador" value: "ClienteCedisConcentrador"}
  #   allowed_value: { label: "Cedis" value: "ClienteCedis"}
  # }

  # dimension: atr_ced_seleccionado {
  #   hidden: yes
  #   label_from_parameter: atributos_cedis
  #   description: "Dimensión dinámica que requiere el parametro 'Atributos Cedis' del aparteado 'Filters Only'"
  #   type: string
  #   sql:
  #   {% if tbl_master.atributos_cedis._parameter_value == 'ClienteCedisConcentrador' %} ${cliente_cedis_concentrador}
  #   {% else %} ${cliente_cedis}
  #   {% endif %};;
  #   drill_fields: [cliente_cedis_concentrador, cliente_cedis]
  #   link: {
  #     label: "1) Sell In - Volumen"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/54?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Área={{_filters['cliente_area_iscam']}}&T.+Envase={{_filters['recurso_tipo_envase']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "2) Sell In - Meses Abiertos/Cerrados"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/58?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Área={{_filters['cliente_area_iscam']}}&T.+Envase={{_filters['recurso_tipo_envase']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "3) Sell In - Venta Neta"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/59?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Área={{_filters['cliente_area_iscam']}}&T.+Envase={{_filters['recurso_tipo_envase']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "4) Sell In - Estructura Comercial"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/70?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Área={{_filters['cliente_area_iscam']}}&T.+Envase={{_filters['recurso_tipo_envase']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Venta={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "PPFs"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/87?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Área={{_filters['cliente_area_iscam']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "Fill Rate"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/81?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "Dias de Cobertura"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/61?Fecha={{_filters['FechaCorta_date']}}&Unidad+Negocio={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Geografía={{_filters['cliente_tipo_venta']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoría={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Compañia+C.={{_filters['compania_comercial']}}&Subcategoría={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&Subsegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Área={{_filters['cliente_area_iscam']}}&T.+Envase={{_filters['recurso_tipo_envase']}}&Cliente={{_filters['cliente']}}&Cadena={{_filters['cliente_cadena']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Cliente={% parameter atributos_cliente %}&Atributos%20Recurso={% parameter atributos_recurso %}&Niv1={{_filters['niv1']}}&Niv2={{_filters['niv2']}}&Niv3={{_filters['niv3']}}&Niv4={{_filters['niv4']}}&Niv5={{_filters['niv5']}}&Niv6={{_filters['niv6']}}&Niv7={{_filters['niv7']}}&Niv8={{_filters['niv8']}}"
  #   }
  #   link: {
  #     label: "Sell Out"
  #     url: "https://herdez.cloud.looker.com/dashboards-next/26?Date={{_filters['FechaCorta_date']}}&Unidad+Neg={{_filters['recurso_compania']}}&División={{_filters['recurso_clasificacion_logistica']}}&Canal={{_filters['cliente_canal']}}&Grupo={{_filters['cliente_grupo']}}&Marca={{_filters['recurso_marca']}}&Categoria={{_filters['recurso_categoria']}}&Recurso={{_filters['recurso_comercial']}}&Subcategoria={{_filters['recurso_categoria1']}}&Segmento={{_filters['segmento']}}&SubSegmento={{_filters['sub_segmento']}}&Línea={{_filters['recurso_linea']}}&Target={{_filters['target']}}&Unidad+de+Medida+Volumen={% parameter selector_medida %}&Atributos%20Recurso={% parameter atributos_recurso %}"
  #   }
  # }

}
