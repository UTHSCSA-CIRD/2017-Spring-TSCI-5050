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
if(!require(ggplot2)) install.packages('ggplot2',repos=repo);
if(!require(GGally)) install.package('GGally',repos=repo);
#' Let's load the `ozone` dataset from the `faraway` package
data(ozone);
head(ozone);
#' Visually explore
ggpairs(transform(ozone,O3=log(O3),dO3=cut(O3,4)),
        aes(color=dO3),upper=list(continuous='density'));
#' Remember the linear model...
o_lm <- lm(log(O3))
