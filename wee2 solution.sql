-- 
-- Now that you're familiar with the structure of the tables, let's dive deeper. We need to understand the types of water sources we're
-- dealing with. Can you figure out which table contains this information?

select distinct(type_of_water_source)
from water_source;

select distinct(type_of_water_source), count(*)
from water_source
where type_of_water_source= "river";


-- Write an SQL query that retrieves all records from this table where the time_in_queue is more than some crazy time, say 500 min. How
-- would it feel to queue 8 hours for water?
select *
from visits 
where time_in_queue>500;

-- another query

select*
from visits
 where source_id  in('AkKi00881224' ,"HaZa21742224",'SoRu3609visits6224');

-- cleaning step by step

select*
from well_pollution
where biological > 0.01
and results='Clean'
and description like 'Clean_%';


-- update describtion coulumn 
SET SQL_SAFE_UPDATES = 0;

update well_pollution
set description ='Bacteria: E. coli'
where description='Clean Bacteria: E. coli';

update well_pollution
set description ='Bacteria: Giardia Lamblia'
where description= 'Clean Bacteria: Giardia Lamblia';


-- update result coulumn

update well_pollution
set results='Contaminated: Biological'
where results= 'Clean'
 and biological > 0.01 ;
 
 
 select*
from well_pollution
 where biological > 0.01
 and results='Clean'
and description like 'Clean_%';


select *
from visits;


select distinct(source_id) ,visit_count
from visits
where visit_count=8
order by visit_count ;


-- What is the source_id of the water source shared by the most number of people? Hint: Use a comparison operator.


select *
from water_source;

-- max number_of_people_served
select max(number_of_people_served)
from water_source;
-- 3998
select source_id,number_of_people_served
from water_source
where number_of_people_served=3998;

-- another same result 


select source_id,number_of_people_served
from water_source
where number_of_people_served>= (select max(number_of_people_served)
from water_source);


select * 
from data_dictionary
where description like '%population%';

select pop_n ,pop_u 
from water_source global_water_access;
-- where description like '%population%';
 
 SELECT * FROM md_water_services.water_source;
-- What is the population of Maji Ndogo? 

select sum(number_of_people_served)
from water_source;

SELECT *
FROM employee
WHERE position = 'Civil Engineer'
AND (province_name = 'Dahabu' OR address LIKE '%Avenue%');
 
 
SELECT * FROM md_water_services.employee;

select employee_name
from employee
where (phone_number like ('%86%') or phone_number like('%11%') )
and(employee_name like('% A%') or employee_name like ('% M%') and position ='Field Surveyor');



SELECT *
FROM well_pollution
WHERE description LIKE 'Clean_%' OR results = 'Clean' AND biological < 0.01;


SELECT * 
FROM well_pollution
WHERE description
IN ('Parasite: Cryptosporidium', 'biologically contaminated')
OR (results = 'Clean' AND biological > 0.01);


