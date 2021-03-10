view: inputs {
#Repeated
  sql_table_name: `bigquery-public-data.crypto_bitcoin.transactions.inputs` ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.index ;;
  }

  dimension: index {type:number description: "0-indexed number of an input within a transaction"}
  dimension: spent_transaction_hash {description: "The hash of the transaction which contains the output that this input spends"}
  dimension: spent_output_index {type:number description:"The index of the output this input spends"}
  dimension: script_asm {description:"Symbolic representation of the bitcoin's script language op-codes"}
  dimension: script_hex {description:"Hexadecimal representation of the bitcoin's script language op-codes"}
  dimension: sequence {description:"A number intended to allow unconfirmed time-locked transactions to be updated before being finalized; not currently used except to disable locktime in a transaction"}
  dimension: required_signatures {description:"The number of signatures required to authorize the spent output"}
  dimension: type {description:"The address type of the spent output"}
  dimension: first_address {
    sql: (
    SELECT JSON_QUERY(json_text, '$.addresses')
    FROM
  UNNEST(`bigquery-public-data.crypto_bitcoin.transactions.inputs.addresses`) as json_text
    ) ;;

    description:"Addresses which own the spent output"}
  dimension: address {
    sql:
      ARRAY_TO_STRING(${TABLE}.addresses,',')
    ;;

      description:"Addresses which own the spent output"}


  dimension: value {description:"The value in base currency attached to the spent output"}

dimension: json {
  sql: (SELECT JSON_QUERY(json_text, '$.labels[0].value') FROM
  UNNEST([
'{"billing_account_id":"1234","service":{"id":"asdf","description":"ComputeEngine"},"sku":{"id":"6C71-E844-38BC","description":"N1PredefinedInstanceRamrunninginAmericas"},"usage_start_time":"2021-01-3116:00:00UTC","usage_end_time":"2021-01-3117:00:00UTC","project":{"id":"PROJECT-ID","number":"PROJECT-NUMBER","name":"PROJECT-NAME","labels":[{"key":"key1","value":"value1"},{"key":"key2","value":"value2"},{"key":"key3","value":"value3"},],},"labels":[{"key":"goog-dataproc-cluster-name","value":"cluster-name"},{"key":"goog-dataproc-cluster-uuid","value":"cluster-uuid"},{"key":"goog-dataproc-location","value":"us-central1"}],"export_time":"2021-02-0103:59:07.158UTC","cost":"10","currency":"USD","currency_conversion_rate":"1.0","usage":{"amount":"10.0","unit":"byte-seconds","amount_in_pricing_units":"10.0","pricing_unit":"gibibytehour"},"credits":[{"name":"credit-1","amount":"-5","full_name":null,"id":"credit-1","type":"COMMITTED_USAGE_DISCOUNT"},{"name":"credit-2","amount":"-3","full_name":null,"id":"credit-2","type":"PROMOTION"}],"invoice":{"month":"202101"},}'
  ]) AS json_text) ;;
}

  ##Measure
  measure: total_value {
    type: sum
    sql: ${value} ;;
  }

  measure: count {
    type: count
  }












}
