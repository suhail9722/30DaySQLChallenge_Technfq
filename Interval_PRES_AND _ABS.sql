
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY employee ORDER BY employee, dates) AS rn
    FROM emp_attendance
),
cte_present AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY employee ORDER BY employee, dates) AS rn_present,
           rn - ROW_NUMBER() OVER (PARTITION BY employee ORDER BY employee, dates) AS flag
    FROM cte
    WHERE status = 'PRESENT'
),
cte_absent AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY employee ORDER BY employee, dates) AS rn_absent,
           ROW_NUMBER() OVER (PARTITION BY employee ORDER BY employee, dates) - ROW_NUMBER() OVER (PARTITION BY employee ORDER BY employee, dates) AS flag
    FROM cte
    WHERE status = 'ABSENT'
)
SELECT employee,
       FIRST_VALUE(dates) OVER (PARTITION BY employee, flag ORDER BY employee, dates) AS from_date,
       LAST_VALUE(dates) OVER (PARTITION BY employee, flag ORDER BY employee, dates RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS to_date,
       status
FROM cte_present
UNION
SELECT employee,
       FIRST_VALUE(dates) OVER (PARTITION BY employee, flag ORDER BY employee, dates) AS from_date,
       LAST_VALUE(dates) OVER (PARTITION BY employee, flag ORDER BY employee, dates RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS to_date,
       status
FROM cte_absent
ORDER BY employee, from_date;
