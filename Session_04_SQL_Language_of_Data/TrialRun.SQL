
create table mydata as
select sex_cd||"_"||income_cd arbitrary_data ,
birth_date DOB, zip_cd ZIP
from patient_dimension
where sex_cd != "M" and language_cd = "german"
order by DOB desc
;

select
patient_dimension.patient_num
--these are from patient_dimension
sex_cd,race_cd,concept_cd,nval_num
--these are from observation_fact
from
patient_dimension
left join
observation_fact
on patient_dimension.patient_num = observation_fact.patient_num
where nval_num is not null
;