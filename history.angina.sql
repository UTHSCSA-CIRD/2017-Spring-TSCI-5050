-- wht does our data look like
select * from angina;
-- how many visits?
select count(*) from angina;
-- how many patients
select count(distinct patid) from angina;
-- how many values for the sex column, and how many patients each?
select sex,count(distinct patid) from angina group by sex;
-- originally we had a null row, and we investigated it like this (note the IS NULL rather than = NULL)
select * from angina where sex is null;
-- then we deleted it
delete from angina where sex is null;
select patid, count (*) foo from (select distinct patid,sex from angina where sex != "") group by patid;
select * from (select patid, count (*) foo from (select distinct patid,sex from angina where sex != "") group by patid) where foo !=1;
create table sex as select distinct patid,sex from angina where sex != "";
-- join sex and angina
select sex.sex,angina.* from angina left join sex on angina.patid=sex.patid;
update angina set sex =(select sex from sex where sex.patid =angina.patid ) where angina.sex="";
select * from angina;
select * from angina where sex is null;
select count (* ) from angina where sex is null; -- 124
select count (distinct patid) from angina where sex is null; --115
select count (distinct patid) from angina where patid not in (select patid from sex) ;
--from myself, hw02--
--how many whit severe pain, chestpain,angina,sex--
select * from angina

select sevpain,count (distinct patid) from angina group by sevpain;
select chestpain,count (distinct patid) from angina group by chestpain;
select angina,count (distinct patid) from angina group by angina;
select * from angina where angina is null;
select sex,count(distinct patid) from angina group by sex;
select count(distinct patid) from angina;
select dead, count (distinct patid) from angina group by dead;
select * from angina where dead is null;
select * from angina where sex="Male";
select * from angina where sex="Female";
select count( *) from angina where sex="Male";
select count( *) from angina where sex="Female";
select count(distinct patid) from angina where sex="Male";
select count( distinct patid ) from angina where sex="Female";
select max(age) from angina where sex="Male";
select max(age) from angina where sex="Female";
select max(age) from angina;
select min(age) from angina where sex="Female";
