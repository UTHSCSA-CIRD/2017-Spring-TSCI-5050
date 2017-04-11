select* from fghm;
select sex,count(distinct id) from fghm;
select sex,count(*) from fghm;
select sex,count(distinct id) from fghm group by sex;
select obese, count(distinct id) from fghm group by obese;
select min (age) from fghm;
select max(age) from fghm;
select * from fghm order by age;
select sex, count(*) from fghm where sex is null;
select hypertension, count(distinct id) from fghm group by hypertension;
select hypertension, count(*) from fghm group by hypertension;
select sex||";"|| obese from fghm;

select sex, obese from fghm;
select sex, obese from fghm where obese !="Normal";
select sex, obese from fghm where obese !="Normal" and sex!="Female";
select sex, obese from fghm where obese ="Normal" and sex="Male";
select obese, age from fghm where obese="Normal" and age > "50";
select obese, hypertension, dbp from fghm where obese="Normal" and hypertension="Normal" and dbp > 90;--bad result--
select obese, hypertension, dbp from fghm where obese="Normal" and hypertension="Normal" and dbp > "90";--good result--
select obese, hypertension, dbp from fghm where obese="Normal" and hypertension="Normal";
select obese, hypertension, sbp from fghm where obese="Normal" and hypertension!= "Normal" and sbp > 160;--bad result--
select obese, hypertension, sbp from fghm where obese="Normal" and hypertension!= "Normal" and sbp > 160;--bad result--
select obese, hypertension, sbp from fghm where obese="Normal" and hypertension!= "Normal" and sbp > "160";--bad result--

---HWO2--How many diferent groups--
select sex, count(*) from fghm group by sex;
select obese, count(*) from fghm group by obese;
select hypertension, count(*) from fghm group by hypertension;
select chd, count(*) from fghm group by chd;
--average, min and max of some variables-
select min(sbp) from fghm;
select max(sbp) from fghm;--bad result--
update fghm set bmi = null where bmi = 'NA';
select max(bmi) from fghm;
select min(bmi) from fghm;
select max (age) from fghm;
select min(age) from fghm;
select avg(age) from fghm;
select avg (bmi) from fghm;
select avg(sbp) from fghm;
select avg(sbp) from fghm where sex="Male";
select avg(sbp) from fghm where sex="Female";
select avg(dbp) from fghm;
select avg(scl) from fghm;--scl= serum cholesterol--
select avg(scl) from fghm where sex="Male";
select avg(scl) from fghm where sex="Female";
--Is each subject measured one?--- yes
select sex, count (distinct id) from fghm group by sex;
select sex, count (*) from fghm group by sex;
--Are some variables only allowed to have a few discrete , predefined value--
select * from fghm;
select age, count(*) from fghm;
select age, count(*) from fghm where age is NULL;
select age,count(*) from fghm where age is not NULL;
