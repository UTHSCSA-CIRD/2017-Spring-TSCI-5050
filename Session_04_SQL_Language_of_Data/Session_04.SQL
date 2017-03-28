-- update
/* finish
minimize
*/
with 
jose as (select 3399 game,42 lost)
select(game+lost) from jose;

select (5+3) flower;

create table patient_data as
select 
sex_cd||";"||income_cd arbitrary_data ,
birth_date DOB, zip_cd ZIP
from patient_dimension 
where sex_cd != "M" and language_cd = "german"
order by DOB desc
;

select 
patient_dimension.patient_num,
-- these are from patient_dimension
sex_cd,race_cd,
-- these are from observation_fact
concept_cd,nval_num
from 
patient_dimension 
left join 
observation_fact
on patient_dimension.patient_num = observation_fact.patient_num
where nval_num is not null
;
