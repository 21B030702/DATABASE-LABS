select * from warehouses;
select * from boxes
where value > 150;
select distinct contents from boxes;
select warehouses as code, count(code) as "number of boxes" from boxes group by warehouses;
select warehouses  as code, count(code) as "number of boxes" from boxes
group by warehouses having count(code)  > 2;
insert into warehouses(code, location, capacity) values(6, 'New York', 3);
insert into boxes(code, contents, value, warehouses) values('H5RT', 'Papers', 200, 2);
update boxes set value = value * 0.85 where code in (select code from boxes order by value desc limit 1 offset 2);
delete from boxes where value < 150;
delete from boxes where warehouses in (select code from warehouses where location = 'New York') returning *;

