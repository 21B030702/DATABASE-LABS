--a
create function increment(val integer) returns integer as $$
    begin
    return val + 1;
    end; $$
language plpgsql;
select increment(20);
--b
create function addition(val integer, vak integer) returns integer as $$
       begin
       return val + vak;
       end; $$
language plpgsgl;
select addition(20, 30);
--c
create function check_divisible(val integer) returns boolean as $$
       begin
       if val % 2 = 0 then return true;
       else  return false;
       end if;
       end; $$
language plpsql;
select check_divisible(30);
--d
create function check_password(pass varchar) returns boolean as $$
       begin
       if LENGTH(pass) >= 11 then return true;
       else return false;
       end if;
       end; $$
language plpgsql;

select check_password(Arsen_1234);
--e
create function calculator(val integer, out square_root integer, out square integer) as $$
       begin
       square_root :=  pow(val, 2);
       square := val * val;
       end; $$
language plpgsql;
--2.a
create function cur() return trigger as $$
    begin
    raise notice '%', now();
    return new;
end;
$$
language plpgsql;

create trigger cur_t before insert on table_1 for each row  excute procedure current();
-- 2.b
create function age() return trigger as $$
    begin
         raise notice '%', age(now(), new.t);
         return new;
    end; $$
language plpgsql;

create trigger age_t before insert on table_2 for each row execute procedure age();
--2.c
create function adds() return trigger as $$
    begin
         new.cost = new.cost * 1.12;
         return new;
    end; $$
language plpgsql;

create trigger adds_t before  insert on table_3 for each row execute procedure adds();
--2.d
create function stop_deletion() return trigger as $$
    begin
         raise exception "Deletion is not allowed";
    end; $$
language plpgsql;

create trigger stop_d before delete on table_4 execute procedure stop_deletion();
--2.e
create function launches_another() return trigger as $$
    begin
         raise notice '%', check_password(new.s);
         raise notice '%', calculator(new.a);
    end; $$
language plpgsql;

create trigger launches_t before insert on table_5 for each row execute procedure launchess_another();

create table work(id int, name varchar, date_of_birth date, age int, inout salary numeric, workexpirence int, out discount numeric);
-- a
create function
    a(id int, name varchar, date_of_birth date, age int, inout salary numeric, workexperience int, out discount numeric) as
$$
declare
    count int;
begin
    discount = 10;
    count = workexperience/2;
    for step in 1..count loop
        salary = salary * 1.1;
    end loop;
    count = workexperience/5;
    for step in 1..count loop
        discount = discount * 1.01;
    end loop;
    insert into work values(id, name, date_of_birth, age, salary, workexperience, discount);
end;
$$
language plpgsql;

select * from a(1, 'a', '2000-03-02', 22, 1000, 10);
--b
create or replace function
    b(id int, name varchar, date_of_birth date, age int, inout salary numeric, workexperience int, out discount numeric) as
$$
declare
    count int;
begin
    if age >= 40 then salary = salary * 1.15;
    end if;
    discount = 10;
    count = workexperience/2;
    for step in 1..count loop
        salary = salary * 1.1;
    end loop;
    count = workexperience/5;
    for step in 1..count loop
        discount = discount * 1.01;
    end loop;
    if workexperience > 8 then salary = salary * 1.15;
    end if;
    if workexperience > 8 then discount = 20;
    end if;
    insert into work values(id, name, date_of_birth, age, salary, workexperience, discount);
end;
$$
language plpgsql;

select * from b(2, 'b', '2000-03-02', 44, 1000, 10);





