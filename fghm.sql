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
select min(sbp) from fghm;
select max(sbp) from fghm;--bad result--