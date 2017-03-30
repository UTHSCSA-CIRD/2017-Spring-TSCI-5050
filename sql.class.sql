
select sex_cd from patient_dimension;
select sex_cd, patient_num
 from patient_dimension;
 select patient_num, sex_cd from patient_dimension;
 select patient_num, sex_cd, birth_date from patient_dimension;
select birth_date DOB from patient_dimension;
select birth_date from patient_dimension;
select death_date from patient_dimension;
select death_date RIP from patient_dimension;
select patient_num, death_date-birth_date from patient_dimension; 
where death_date !="NULL";
select language_cd, sex_cd, income_cd from patient_dimension where sex_cd !="M" and language_cd="german";
select language_cd, sex_cd, income_cd from patient_dimension where sex_cd="M" and language_cd="german";
select language_cd, sex_cd, income_cd from patient_dimension where sex_cd="M" and language_cd="german" and income_cd=="High";
select patient_num, religion_cd, race_cd from patient_dimension where religion_cd="agnostic" and race_cd ="black";
select sex_cd||";"|| income_cd from patient_dimension;
select patient_num from patient_dimension and_observation_fact
select patient_num, sex_cd, race_cd from patient_dimension
--these are from patient_dimension
select patient_num ,concept_cd, nval_num from observation_fact
--these are form observation_fact
select patient_dimension joint observation_fact on patient_dimension.patient_num,observation_fact.patient_num;

select * from patient_dimension where race_cd="black" and sex_cd!="F" and age_in_years_num >40;
select* from patient_dimension order by sex_cd;
select * exampleinput
select * concept_dimension

select * from Angina
