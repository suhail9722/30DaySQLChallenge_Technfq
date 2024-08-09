

create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

--Find the number of employee which are inside the hospital

select * from hospital;

-- !1ST APPROCH USING CASE AND GROUP BY
with cte as (
select emp_id,
max(case when action='in' then time end) as in_Time,
max(case when action = 'out' then time end) as out_time
from hospital
group by emp_id)
select * from cte 
where in_Time>out_time or out_time is null;

--2ND APPROCH USING LEFT JOIN
With intime as(
select emp_id,max(time) as in_time_Entery
from hospital where action ='in'
group by emp_id),
out_time as (
select emp_id,max(time) as out_time_exit
from hospital where action ='out'
group by emp_id)
select i.emp_id,i.in_time_Entery as intime,o.emp_id,o.out_time_exit as outtime
from intime i left join out_time o on i.emp_id=o.emp_id
WHERE in_time_Entery > out_time_exit OR out_time_exit IS NULL;

-- 3RD APPROCH USING DENSE RANK
with cte_ranked as
(select *,
	dense_rank() over(partition by emp_id order by time desc) as d_rank
	from hospital
)select * from cte_ranked where d_rank=1 and action='in'





