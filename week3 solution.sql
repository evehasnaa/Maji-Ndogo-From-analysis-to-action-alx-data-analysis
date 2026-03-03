-- week2 queries with alx course 
SET SQL_SAFE_UPDATES=0;

use md_water_services;

SELECT*from employee;
#We have to update the database again with these email addresses, so before we do, let's use a SELECT query to get the format right, then use
#

UPDATE employee
set email=concat(LOWER(REPLACE(employee_name,' ','.')),'@ndogowater.gov');


SELECT length(phone_number)
from employee;

update employee
set phone_number=trim(phone_number);

select phone_number,length(phone_number)
from employee;

#Use TRIM() to write a SELECT query again, make sure we get the string without the space, and then UPDATE the record like you just did for the
#emails. If you need more information about TRIM(), Google "TRIM documentation MySQL"
select * from employee;
select town_name,count(*) as num_for_eash_count
from employee
group by town_name;


-- table visit queries 
select  e.employee_name,  e.assigned_employee_id, 
count(*) as  number_of_visits
from visits as v
join employee as e
on e.assigned_employee_id=v.assigned_employee_id
group by e.assigned_employee_id , e.employee_name
order by number_of_visits asc 
limit 3
;
-- number of employee vivits 
select town_name,count(*) as num_employees
from employee
group by town_name;

-- number of records from visits table 



 -- quiz mcq on alx 
SELECT CONCAT(day(time_of_record), " ", monthname(time_of_record), " ", year(time_of_record)) FROM visits;

SELECT CONCAT(monthname(time_of_record), " ", day(time_of_record), ", ", year(time_of_record)) FROM visits;

SELECT day(time_of_record), monthname(time_of_record), year(time_of_record) FROM visits;
SELECT CONCAT(day(time_of_record), " ", month(time_of_record), " ", year(time_of_record)) FROM visits;

SELECT name,
wat_bas_r - LAG(wat_bas_r) OVER (PARTITION BY (name) ORDER BY (year)) 
FROM global_water_access
ORDER BY name;


SELECT 
    location_id,
    time_in_queue,
    AVG(time_in_queue) OVER (PARTITION BY location_id ORDER BY visit_count) AS total_avg_queue_time
FROM 
    visits
WHERE 
visit_count > 1 -- Only shared taps were visited > 1
ORDER BY 
    location_id, time_of_record;


SELECT
SUM(number_of_people_served) AS population_served
FROM
water_source
WHERE type_of_water_source LIKE "%tap%"
ORDER BY
population_served;

SELECT
    TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
    ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue ELSE NULL END), 0) AS Sunday,
    ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue ELSE NULL END), 0) AS Monday,
    ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Tuesday' THEN time_in_queue ELSE NULL END), 0) AS Tuesday,
    -- ... كملي باقي الأيام بنفس الطريقة ...
    ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Saturday' THEN time_in_queue ELSE NULL END), 0) AS Saturday
FROM
    visits
WHERE
    visit_count > 1 -- بنركز على الـ shared taps ب
GROUP BY
    hour_of_day
ORDER BY
    hour_of_day;
    

select min(time_of_record) as start_date ,
avg(time_of_record) as avg_date,
max(time_of_record) as end_date
from visits;

with ranked_sources as (
    select 
        source_id, 
        type_of_water_source, 
        number_of_people_served, -- أضفنا هذا السطر هنا لكي يعمل الكود
        row_number() over(
            partition by type_of_water_source 
            order by number_of_people_served
        ) as priority_rank
    from water_source 
    where type_of_water_source in ('shared_tap', 'well', 'river')
)

select 
    source_id, 
    type_of_water_source, 
    number_of_people_served,
    priority_rank
from ranked_sources
order by type_of_water_source, priority_rank;

SELECT * FROM md_water_services.water_source;

-- 1. How many people did we survey in total?
select sum(number_of_people_served) as total_surveys
from water_source;

-- 2. How many wells, taps and rivers are there?

select  type_of_water_source,count(*) as count_sources 
from water_source
group by type_of_water_source;

-- 3. How many people share particular types of water sources on average?
select  type_of_water_source,
round( avg(number_of_people_served), 0 ) as avg_sources 
from water_source
group by type_of_water_source;

-- 4. How many people are getting water from each type of source?

select  type_of_water_source,
sum(number_of_people_served) as population_served
from water_source
group by type_of_water_source
order by population_served desc ; 


select  type_of_water_source,
round(sum(number_of_people_served)/27000000 * 100 ,0) as population_served
from water_source
group by type_of_water_source
order by population_served desc ; 


SELECT * FROM md_water_services.global_water_access;

SELECT 
    type_of_water_source, 
    ROUND(AVG(number_of_people_served)) AS avg_people_per_source
FROM 
    water_source
WHERE 
    type_of_water_source = 'well'
GROUP BY 
    type_of_water_source;
    
    
    
    SELECT * FROM md_water_services.location;
-- Create a query that counts the number of records per town


select town_name, count(*) as recorde_per_town
from location
group by town_name 
order by recorde_per_town desc;

select province_name, count(*) as recorde_per_town
from location
group by province_name 
order by recorde_per_town desc;

select province_name, town_name
,count(*) as recorde_per_town
from location
group by province_name,
town_name
order by  province_name desc, recorde_per_town asc;




select   location_type,count(*) as recorde_per_town
from location
group by location_type;

SELECT * FROM md_water_services.employee;

select  province_name, 
        town_name,count(*) as num_of_employe
from employee  

 -- group by town_name 
 where town_name='Harare' and province_name = 'Kilimani'
order by num_of_employe;

SELECT province_name, 
    town_name, 
    COUNT(*) 
FROM employee 
WHERE town_name = 'Harare'
GROUP BY 
    province_name, 
    town_name;
    
    SELECT * FROM md_water_services.visits;

select  e.employee_name , e.email , e. phone_number, e.assigned_employee_id ,
 count(e.employee_name) as number_of_visits
from employee e 
join visits v
on e.assigned_employee_id= v.assigned_employee_id
group by v.assigned_employee_id 
order by assigned_employee_id
limit 3;
-- So find the correct table, figure out what function to use and how to group, order
-- and limit the results to only see the top 3 employee_ids with the highest number of locations visited.

select   assigned_employee_id ,
 count(location_id) as number_of_visits
from visits
group by assigned_employee_id
order by assigned_employee_id 
limit 3 ;
 
-- Create a query that counts the number of records per town

select count(v.record_id) ,e.town_name 
from employee e
join visits v
on e.assigned_employee_id=v.assigned_employee_id
group by town_name ;


