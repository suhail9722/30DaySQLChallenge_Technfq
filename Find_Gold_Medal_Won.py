
CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

delete from events;

INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');


select * from events;

-- First Approch using the NOT IN and Group By Clause Find the number of gold medals won by each player 
select GOLD as Player_Name,COUNT(1) as No_of_Gold_Medals
from events 
where GOLD not in (select SILVER from events union all select BRONZE from events )
group by GOLD;

--USING CTE

WITH CTE AS(
select GOLD as Player_NAME,'GOLD' as Medal_Type FROM events union all 
select SILVER as Player_NAME,'SILVER' as Medal_Type FROM events union all 
select BRONZE as Player_NAME,'BRONZE' as Medal_Type FROM events )
SELECT Player_NAME,COUNT(1)  AS NO_OF_GOLD_MEDALS FROM CTE 
GROUP BY Player_NAME
HAVING COUNT(DISTINCT Medal_Type)=1 and max(Medal_Type)='gold'
