select * from dealer cross join client;

select dealer.id, dealer.name, client.name, client.city, client.priority, sell.id, sell.date, sell.amount
from dealer inner join  client on dealer.id = client.dealer_id inner join sell on client.id = sell.client_id;

select dealer.id, dealer.name, client.id, client.name
from dealer inner join client on dealer.location = client.city;

select sell.id, sell.amount, client.name, client.city
from sell inner join  client on sell.client_id = client.id where sell.amount between 100 and 500;

select distinct on (dealer.id) dealer.id, dealer.name, client.id, client.name
from dealer left join client on dealer.id = client.dealer_id;

select dealer.id, dealer.name, client.id, client.name, client.city, dealer.charge
from dealer left join client on dealer.id = client.dealer_id;

select client.id, client.name, client.city, dealer.id, dealer.name, dealer.charge
from  client inner join dealer on client.dealer_id = dealer.id
where dealer.charge > 0.12;

select distinct on (client.id) client.id,  client.name, client.city, sell.id, sell.date, sell.amount, dealer.id, dealer.name, dealer.charge
from client left join sell on client.id = sell.client_id left join dealer on sell.dealer_id = dealer.id;

select dealer.id, dealer.name, client.id, client.name, client.priority, sell.id, sell.amount
from dealer inner join client on dealer.id = client.dealer_id left join sell on client.id = sell.client_id;

-- 2
create view arsen as select date, count(distinct client_id), avg(amount), sum(amount)
from sell group by date;

create view dima as select date, sum(amount)
from sell group by date order by sum(amount) desc limit 5;

create view sales as select dealer_id,  count(id), avg(amount), sum(amount)
from sell where dealer_id is not null group by dealer_id;

create view earn as select dealer.location, sum(dealer.charge*sell.amount)
from dealer left join sell on dealer.id = sell.dealer_id group by dealer.location;

create view amirkhan as select dealer.location, count(sell.id), avg(sell.amount), sum(sell.amount)
from dealer left join sell on dealer.id = sell.dealer_id group by dealer.location;

create view  num_sales_city as select client.city,  count(sell.id), avg(sell.amount), sum(sell.amount)
from client left join sell on client.id = sell.client_id group by client.city;

create view last as select arsen.city  from client arsen inner join sell on arsen.id = sell.client_id group by arsen.city
having sum(sell.amount) > (select sum(sell.amount) from dealer dima inner join sell on dima.id = sell.dealer_id where arsen.city = dima.location group by dima.location;