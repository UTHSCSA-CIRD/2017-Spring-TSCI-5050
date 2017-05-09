#' ---
#' title: "Parting Thoughts"
#' author: "Alex F. Bokov"
#' date: "05/09/2017"
#' output: html_document
#' ---
#+ echo=FALSE
options(width=300);
repo='https://cran.rstudio.com';
if(!require(mgcv)) install.packages('mgcv',repos = repo);
if(!require(faraway)) install.packages('faraway',repos = repo);
if(!require(visreg)) install.packages('visreg',repos=repo);
