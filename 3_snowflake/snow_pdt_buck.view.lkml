view: snow_pdt_buck {
derived_table: {
  sql:
WITH
this_period_type_count AS (
SELECT
case when 1=1 then '1' ELSE null END as "period",
COUNT(*) AS "Actions Triggered",
COUNT(DISTINCT CASE WHEN (al.type = 'email') THEN al."id" ELSE NULL END) AS "Emails Sent",
COUNT(DISTINCT CASE WHEN (al.type = 'salesforcecasemanagement') THEN al."id" ELSE NULL END) AS "Cases Created"
FROM tenant10.action_log as al
where al.result = 0
and al.sent_at
BETWEEN now()::date - INTERVAL '7 DAY'
AND now()::date
),

prev_period_type_count AS (
SELECT
case when 1=1 then '1' ELSE null END as "period",
COUNT(*) AS "Actions Triggered",
COUNT(DISTINCT CASE WHEN (al.type = 'email') THEN al."id" ELSE NULL END) AS "Emails Sent",
COUNT(DISTINCT CASE WHEN (al.type = 'salesforcecasemanagement') THEN al."id" ELSE NULL END) AS "Cases Created"
FROM tenant10.action_log as al
where al.result = 0
and al.sent_at
BETWEEN now()::date - INTERVAL '14 DAY'
AND now()::date - INTERVAL '7 DAY'
)

select
case when this.period = '1' then 'This Period' ELSE null END as " ",
this."Actions Triggered",
this."Emails Sent",
this."Cases Created"
from this_period_type_count this
UNION ALL
select
case when prev.period = '1' then 'Previous Period' ELSE null END as " ",
prev."Actions Triggered",
prev."Emails Sent",
prev."Cases Created"
from prev_period_type_count prev
UNION ALL
(
SELECT
case when this.period = '1' then 'Diff' ELSE null END as " ",
((this."Actions Triggered" - prev."Actions Triggered") * 100 / prev."Actions Triggered"),
((this."Emails Sent" - prev."Emails Sent") * 100 / prev."Emails Sent"),
((this."Cases Created" - prev."Cases Created") * 100 / prev."Cases Created")
from this_period_type_count this
inner join prev_period_type_count prev on this.period = prev.period
)
;;
}


  }
