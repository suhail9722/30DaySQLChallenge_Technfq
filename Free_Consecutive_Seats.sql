CREATE TABLE cinema (
    seat_id INT PRIMARY KEY,
    free int
);


delete from cinema;

INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 0);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (11, 0);
INSERT INTO cinema (seat_id, free) VALUES (12, 1);
INSERT INTO cinema (seat_id, free) VALUES (13, 0);
INSERT INTO cinema (seat_id, free) VALUES (14, 1);
INSERT INTO cinema (seat_id, free) VALUES (15, 1);
INSERT INTO cinema (seat_id, free) VALUES (16, 0);
INSERT INTO cinema (seat_id, free) VALUES (17, 1);
INSERT INTO cinema (seat_id, free) VALUES (18, 1);
INSERT INTO cinema (seat_id, free) VALUES (19, 1);
INSERT INTO cinema (seat_id, free) VALUES (20, 1);

--Question:- Find the consecutive seat which are available 
-- where 1 means vacant and 0 means filled.

1st way 

With ctx as(
select * 
,ROW_NUMBER() over ( order by seat_id) as rnk,
 seat_id- ROW_NUMBER() over ( order by seat_id) as flag
from cinema where free=1)
Select seat_id from (
select * , count(*) over (partition by flag) as cnt from ctx)A
where cnt >1;

--- 2nd Way
with cte as(
select c1.seat_id as s1 ,c2.seat_id as s2
from cinema c1  inner join cinema c2 
on c1.seat_id+1=c2.seat_id
where c1.free =1 and c2.free=1)
select s1 from cte
union 
select s2 from cte;

--- 3 rd way 

select seat_id from
(select * ,
LAG(free,1) over(order by seat_id) as prev_free
,LEAD(free,1) over (order by seat_id) as next_free
from cinema)A
where free=1 and (prev_free=1 or next_free=1)

