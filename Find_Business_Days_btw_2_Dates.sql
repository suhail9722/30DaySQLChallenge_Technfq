--find business days between 2 given dates using SQL explict of weekend and public holidays.
with CTE as(
select t.ticket_id,t.create_date,t.resolved_date,
COUNT(h.holiday_date) as holidays
--DATEDIFF(day,create_date,resolved_date) as day_diff,
--DATEDIFF(week,create_date,resolved_date) as week_diff,
--DATEDIFF(day,create_date,resolved_date)- 2* DATEDIFF(week,create_date,resolved_date) as Business_day_Except_holidays
from tickets t left join holidays h 
on h.holiday_date between t.create_date and t.resolved_date
AND DATEPART(WEEKDAY, h.holiday_date) NOT IN (1, 7) -- 1 = Sunday, 7 = Saturday
group by t.ticket_id,t.create_date,t.resolved_date
)
select *,
DATEDIFF(day,create_date,resolved_date) as actual_days,
DATEDIFF(week,create_date,resolved_date) as week_diff,
DATEDIFF(day,create_date,resolved_date)- 2* DATEDIFF(week,create_date,resolved_date) -holidays as Business_day
from CTE;
