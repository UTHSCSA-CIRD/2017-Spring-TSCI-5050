#' ---
#' title: "R and SQL Databases"
#' author: "Alex F. Bokov"
#' date: "02/28/2017"
#' ---
#+ echo=TRUE,cache=TRUE
#' Load libraries
if(!require(RSQLite)) install.packages(RSQLite,repos="https://cran.rstudio.com/");
if(!require(xtable)) install.packages(xtable,repos="https://cran.rstudio.com/");
#' Go to the directory where the .db file lives on YOUR system. You may need to
#' change the path as appropriate.
#setwd(paste0(Sys.getenv('HOME'),'/Desktop/2017-Spring-TSCI-5050'));
#' Open connection
con <- dbConnect(SQLite(),'./Session_04_SQL_Language_of_Data/exampleinput.db');
#' See what tables are available in this db file
dbListTables(con);
#' Select a table
#+ results="asis"
dbGetQuery(con,'select * from patient_dimension');
print(xtable(dat),type='html');
#' The following need to be annotated by me, still -- Alex
#' 
#' View a table as a `data.frame`
dbGetQuery(con,'select * from concept_dimension');
dbGetQuery(con,'select * from observation_fact');
head(dbGetQuery(con,'select patient_num,concept_cd from observation_fact'));
head(dbGetQuery(con,'select patient_num,concept_cd from observation_fact where concept_cd = "NDC:00005306343"'));
head(dbGetQuery(con,"select patient_num,concept_cd from observation_fact where concept_cd = 'NDC:00005306343'"));
head(dbGetQuery(con,"select patient_num,concept_cd from observation_fact where concept_cd like '%NDC:00005306343'"));
