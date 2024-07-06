CREATE TABLE qr_data (
    id INT PRIMARY KEY,
     name varchar(10),
	 location varchar(20),
);

INSERT INTO qr_data(id) VALUES (1);
INSERT INTO qr_data(id, name) VALUES (2,'david');
INSERT INTO qr_data(id, location) VALUES (3,'London');
INSERT INTO qr_data(id) VALUES (4);
INSERT INTO qr_data(id, name) VALUES (5,'david');

select * from qr_data;


select MIN(id),MIN(name),Min(location) from qr_data
union all
select MAX(id),MAX(name),Min(location) from qr_data;
