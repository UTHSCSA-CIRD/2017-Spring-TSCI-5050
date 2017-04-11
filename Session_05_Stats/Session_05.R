#' ---
#' title: "Crash Course in Statistics"
#' author: "Alex F. Bokov"
#' date: "03/28/2017"
#' output: html_document
#' ---
#+ echo=FALSE
options(width=300);
#' ## Cool trick
#' 
#' I don't know what kind of packages you have, and whether or not they
#' are up to date. I don't want to waste your time installing them 
#' needlessly, though. So I'm going to declare a function that (re) installs
#' packages only if they are out of date or missing.
# smartinstall <- function(pkg,repo='https://cran.rstudio.com',op=old.packages(repos=repo)[,'Package']){
#   if(pkg %in% op || !require(pkg,character.only = T)) {
#     install.packages(pkg,repos=repo);
#     library(pkg,character.only = T);
#   }
# }
#' `old.packages` gives information about R packages that are out of date.
#' But it takes a while to run so let's run it once, save it, and then keep
#' re-using it.
# .op <- old.packages(repos = 'https://cran.rstudio.com')[,'Package'];
#' ## Load libraries, installing/update if necessary
#+ warning=FALSE, results='hide'
# rgl has a bug in its current version number, dealing with it differently
# if(!require(rgl)) install.packages('rgl',repo='https://cran.rstudio.com');
# for(ii in c('tibble','ggplot2','GGally','magrittr','plot3D')) smartinstall(ii,op=.op);
#' 
#' ## Another cool trick.
#' 
#' The following is unrelated to the rest of this class, but is a neat 
#' trick, hope you like it. This script needs to load a separate data 
#' file in order to work. To do that it needs to know what directory that
#' file is in. On your computer the `2017-Spring-TSCI-5050` is in a
#' completely different folder than on mine, so if my file location won't
#' work for you. So we need to get this script to figure out its own location
#' and then look for the data file in the same folder. This is what's known
#' as a hack.
thisDir <- normalizePath(getSrcDirectory(function(xx) xx));
#' Now we know the location of this file. It is... `r thisDir` 
#' 
#' `function(xx) xx` is just a useless little function that gives you something 
#' to pass to the `getSrcDirectory()` function. `getSrcDirectory()` takes another
#' function as its argument and returns the location of the script in which this
#' function is defined... in other words, this script. That gets passed to
#' `normalizePath()` which expands things like `.` or `Documents` into a full 
#' path.
#' 
#' So now, no matter where you run this script from, you have a variable that 
#' stores this script's location, where it can look for the other files it needs. 
#' Unless you moved this script out of its directory in which case, that's your 
#' own fault. ;-)
#' 
#' I learned this trick here-- http://stackoverflow.com/questions/1815606/rscript-determine-path-of-the-executing-script
#' 
#' Now, on with the lesson.
#' 
#' ## Load data.
load(paste(thisDir,'example_data.rdata',sep='/'));
#' You are probably starting to get used to this function-in-a-function pattern 
#' by now. If not, this might be a more readable way of writing the same thing.
#' Do whatever is easier for you. In this class, I'll write relatively short 
#' statements in the style above and the more complicated ones in the style
#' below.
thisDir %>%                                # take the location of this script
  paste('example_data.rdata',sep='/') %>%  # tack on the name of the data file
  load(verbose=T);                         # and load it
#' 
#' We now have our data.
#' 
#' ## Create development and test sets.
#' 
#' It feels pretty reasonable to explore your data, decide what needs to be 
#' fixed up, what variables to include, etc. and then actually fit a statistical 
#' model. If you do this, you are biasing your data. If you used data to make
#' any decision about your analysis... even if that decision ended up being to
#' do exactly what you planned originally... you should not test hypotheses or 
#' validate predictions on the same data. That's called double-dipping.
#' 
#' There are cross-validation and bootstrap methods to remedy this. But if you 
#' have a reasonably large sample size like we do today, a simpler thing to do
#' is just randomly sample two subsets from it: training data...
example_data$PATIENT_NUM %>%
  unique %>%
  sample(450) -> trainset;

example_train <- subset(example_data,PATIENT_NUM %in% trainset);
#' ...and test data
example_data$PATIENT_NUM %>%
  setdiff(trainset) %>%
  sample(450) -> testset;
example_test <- subset(example_data,PATIENT_NUM %in% testset);
#' ## The training data is for you to explore all you want and try various things with it...
#+ warning=FALSE, message=FALSE
ggpairs(example_train[sample(1:nrow(example_train),100),],aes(colour=SEX,alpha=0.1),size=0.02);
heatmap(cor(na.omit(data.matrix(example_train[sample(1:nrow(example_train),100),]))),symm = T);
#' ## But keep the test data pristine. Don't even look at it until the very end.
#'
#' ## Now for some actual statistics.
#' 
#' Plot Y vs BMI_BIN
stripchart(Y~BMI_BIN,subset(example_train),
           method = 'jitter',jitter = 0.2,col=c('#FF000020','#0000FF20'),
           vertical = T,pch='.',cex=8,main='Response Y vs BMI');
#' Now let's do a T-test comparing the response of low-BMI and high-BMI patients.
t.test(Y~BMI_BIN,example_train,var.equal = T);
#' Plot Y vs SEX
stripchart(Y~SEX,example_train,method = 'jitter',jitter = 0.2, col=c('#FF000020','#0000FF20'),vertical = T,pch='.',cex=8)
#' Now let's do the same thing but comparing the response of females and males.
t.test(Y~SEX,example_train,var.equal = T);
#' By the way, a T-test is just a special case of regression. Look:
summary(lm(Y~SEX,example_train));
#' Plot Y vs SEX _and_ BMI_BIN
stripchart(Y~SEX+BMI_BIN,example_train,method = 'jitter',jitter = 0.2,col=c('#FF000020','#0000FF20'),vertical = T,pch='.',cex=8)
#' Woow. Looks like males and females have a different response after all. Why 
#' did our t-test come back non-significant?
#' 
#' We could have a bunch of T-tests comparing various combinations of sex and 
#' BMI. But there is a proper way to do this.
anova(aov(Y~SEX+BMI_BIN,example_train));
#' But guess what? ANOVA is _also_ just a (usually inconvenient) way of 
#' presenting results from regression analysis:
anova(lm(Y~SEX+BMI_BIN,example_train));
#' Notice, `anova()` is just a wrapper function around a fitted model. So if 
#' ANOVA is an inconvenient way of looking at the data, what's better? How about 
#' the coefficients of the regression model itself?
summary(lm(Y~SEX+BMI_BIN,example_train));
#' The problem, though is that we are still not capturing the fact that the BMI
#' effect is _conditional_ on whether or not the patient is male! To probe this
#' "criss-cross" behavior, we need an interaction term:
summary(lm(Y~SEX+BMI_BIN+SEX:BMI_BIN,example_train));
#' A shorthand for `SEX+BMI_BIN+SEX:BMI_BIN` is `SEX*BMI_BIN`:
summary(lm(Y~SEX*BMI_BIN,example_train));
#' But, a linear regression model like the ones fitted by `lm()` doesn't require
#' that the variables be discrete. BMI is naturally a numeric variable, so why
#' not let it stay that way?
#' 
#' Plot Y vs SEX and _unbinned_ BMI
plot(Y~BMI,subset(example_train,SEX=='m'),ylim=c(-10,30),pch='.',cex=8,col="#0000FF20");
points(Y~BMI,subset(example_train,SEX=='f'),pch='.',cex=8,col="#FF000020");
#' Here is the regression model.
sexbmi <- lm(Y~SEX*BMI,example_train);
summary(sexbmi);
#' Is this a good fit? Let's plot it and find out.
plot(sexbmi,pch='.',cex=10,col="#00000030", which = 1);
plot(sexbmi,pch='.',cex=10,col="#00000030", which = 2);
#' No. Not at all. There is an additional source of variability that is not
#' accounted for by this model.
#' 
#' Plot Y vs SEX and AGE
plot(Y~AGE,subset(example_train,SEX=='m'),ylim=c(-10,30),pch='.',cex=8,col="#0000FF20");
points(Y~AGE,subset(example_train,SEX=='f'),pch='.',cex=8,col="#FF000020");
#' But really, `Y~AGE` and `Y~BMI` are both two-dimensional projections of a
#' three-dimensional cloud of data. You could plot `Y` against one while 
#' ignoring the other one, or anything in between.
#+ eval=FALSE
for(ii in 10*(0:9)) with(example_train,
                         scatter3D(AGE,BMI,Y,colvar=as.numeric(SEX),
                                   col=c('#FF0000','#0000FF'),
                                   xlab='Age',ylab='BMI',zlab='Y'
                                   ,FOV=0,phi = 0,theta=ii,d=1000,colkey=F));
#' Nor is there anything special about Y. It is your prior knowledge that makes
#' it a response variable. You could choose to plot `AGE` versus `BMI` and 
#' ignore `Y`, and you could rearrange the regression model in the equivalent 
#' manner. The math and the software work in any direction.
#+ eval=FALSE
for(ii in 10*(0:9)) with(example_train,
                         scatter3D(AGE,BMI,Y,colvar=as.numeric(SEX),
                                   col=c('#FF0000','#0000FF'),
                                   xlab='Age',ylab='BMI',zlab='Y'
                                   ,FOV=0,phi = ii,theta=90,d=1000,colkey=F));

#' ...and there is no reason at all why it must be limited to two dimensions.
#' There will be as many dimensions are there are numeric variables.
#' 
#' We better update the regression model to include age.
sexbmiage <- update(sexbmi,.~.*AGE);
summary(sexbmiage);
#' How normal are the residuals now?
plot(sexbmiage,pch='.',cex=10,col="#00000010",which=1);
plot(sexbmiage,pch='.',cex=10,col="#00000010",which=2);
#' Some evidence of non-linearity, and awful QQ plot, though perhaps 
#' better than before. But do we _really_ need _all_ these terms? 
#' How do we decide which ones to keep?
sexbmiage.aic <- step(update(sexbmiage,.~SEX+BMI+AGE),
                      scope=list(lower=.~1,upper=.~(.)^3),
                      direction = "both",trace = 3);
summary(sexbmiage.aic);
#' We got rid of the three-way interaction term. Check the residuals.
plot(sexbmiage.aic,pch='.',cex=10,col="#00000030",which=1);
plot(sexbmiage.aic,pch='.',cex=10,col="#00000030",which=2);
#' Not visibly worse. But there is something else to keep in mind-- these
#' data-points are not independent! Some of them come from the same individual
#' sampled at multiple ages! To separately account for within-indvididual and
#' between-individual variation, we need to use the `nlme` library.
library(nlme);
#' We set some options to use with the `lme()` function.
lmec <- lmeControl(opt='optim',maxIter=100,msMaxIter=100,niterEM=50,
                   msMaxEval=400,nlmStepMax=200);
#' The `lme()` function is for fitting a *L*inear *M*ixed *E*ffect model.
#' Mixed-effect means some of the effects are "fixed", like the ones we've been
#' using up to now, and some of them are "random"-- i.e. error terms, but now
#' there are more than one of them. But before we do that, let's see if it's
#' worth doing. Let's fit a `gls()` model, which doesn't use random effects, and
#' it will allow a comparison with the `lme()` model to see if it makes a
#' difference.
sexbmiage.gls <- gls(sexbmiage.aic$call$formula,example_train,
                     na.action=na.omit,method='ML');
summary(sexbmiage.gls)$tTable;
summary(sexbmiage.aic)$coef;
#' Now let's try fitting an `lme()` model.
sexbmiage.lme <- lme(sexbmiage.aic$call$formula,example_train,method='ML',
                     na.action=na.omit,random=~1|PATIENT_NUM);
summary(sexbmiage.lme)$tTable;
#' Is the `lme()` model a significantly better fit than the fixed-effect model?
#' At last, something that `anova()` _is_ useful for.
anova(sexbmiage.gls,sexbmiage.lme);
#' So far we've said: each patient has a unique baseline value, but they all
#' have the same age and BMI effect. Let's see if that's actually true.
sexbmiage.lmeA <- update(sexbmiage.lme,random=~AGE|PATIENT_NUM,control=lmec);
sexbmiage.lmeB <- update(sexbmiage.lme,random=~BMI|PATIENT_NUM,control=lmec);

anova(sexbmiage.lme,sexbmiage.lmeA);
anova(sexbmiage.lme,sexbmiage.lmeB);
#' So, we are better off with a random `BMI` term in addition to a random
#' baseline. Note: we have attributed some but not all of the BMI effect to
#' individual variation. Now there is both a fixed `BMI` effect and a random
#' `BMI` effect. It might also be worth seeing if including both both `BMI`
#' _and_ `AGE` as random terms further improves fit. However, this would be
#' something to run on a fast machine over a lunch-break.
#sexbmiage.lmeAB <- update(sexbmiage.lmeA,random=~AGE+BMI|PATIENT_NUM,control=lmec);
#anova(sexbmiage.lmeA,sexbmiage.lmeAB);
#anova(sexbmiage.lmeB,sexbmiage.lmeAB);
#' Standardized residuals look better now. Compare the ones without the random
#' individual variation in slope and intercept (`sexbmiage.gls`, from above)...
plot(sexbmiage.gls,abline=0);
#'...to the ones for the model we ended up with, where in addition to
#'between-patient variability there is a within-patient variability in the slope
#'of the `Y` vs `BMI` line.
plot(sexbmiage.lmeB,abline=0);
qqnorm(sexbmiage.lmeB,abline=0:1);
#' But becaues this is an `lme` model rather than an `lm` model means there are
#' two types of residuals you can print: how far each data-point diverges from
#' what the model would predict overall, and how far reach datpoint diverges
#' from what the model would predict for that individual. The nice graph you are
#' seeing is for the individual level. But if all the data points for a given
#' individual diverge by a similar amount, that shared component gets factored
#' out into an offset to that individual's slope and intercept estimates. Great
#' if your goal is to predict how the next set of observations from _these_
#' individuals will look. But if you want to predict the results of this
#' experiment being replicated in a completely new set of subjects, then you
#' want the other set of residuals-- relative to the entire set, not to the
#' respective individuals. You do this by setting `level=0` to the plot
#' expression...
plot(sexbmiage.lmeB,resid(.,level=0)~fitted(.,level=0),abline=0);
qqnorm(sexbmiage.lmeB,level=0,abline=0:1);
#' Wow. Looks like several distinct clusters here. This could mean that certain
#' groups of patients are responding differently. If we properly include the
#' grouping variable in the model, the clustering will go away. When plotting
#' `lme` models (as opposed to `lm`), you have the option of separating out the
#' plots by discrete variables. For example, here are the residuals for males
#' and females plotted separately...
plot(sexbmiage.lmeB,resid(.,level=0)~fitted(.,level=0)|SEX,abline=0);
#' The male residuals are an example of the random noise that we're looking for.
#' It's the female residuals that are responsible for all the clustering we saw.
#' The sub-group with the differential response is among the females.
#' 
#' There is an additional variable available that we have not included in the
#' model, and that is  `RACE`.
cbind(table(unique(example_train[,c('PATIENT_NUM','RACE','SEX')])[,c('RACE','SEX')]));
#' Let's see if by segmenting the residual plot on both `SEX` and `RACE` we can
#' futher isolate the differential responders.
plot(sexbmiage.lmeB,resid(.,level=0)~fitted(.,level=0)|SEX+RACE,abline=0);
#' Yes! So, perhaps we need to include `RACE` in this particular model. Let's
#' see if this improves the fit. We can add this variable to the model and
#' determine which interaction terms to include in one command, using the
#' `stepAIC()` function from the `MASS` library.
library(MASS);

sexbmiagerace.lmeB <- stepAIC(sexbmiage.lmeB
                              ,direction='both'
                              ,scope=list(lower=.~1,upper=.~RACE*SEX*BMI*AGE));
#' This improves the model fit significantly.
anova(sexbmiage.lmeB,sexbmiagerace.lmeB);
plot(sexbmiagerace.lmeB,level=0);
qqnorm(sexbmiagerace.lmeB,level=0,abline=0:1);
plot(sexbmiagerace.lmeB,resid(.,level=0)~fitted(.,level=0)|SEX+RACE,abline=0);
#' _This_ is how residuals should look when you're finished. Here are the model
#' estimates and significance tests.
summary(sexbmiagerace.lmeB)$tTable;
#' For final interpretation of these results we should tweak the data just a
#' little, so that `AGE` is centered. That way, the effects are reported for
#' patients at the average age for this sample rather than for age 0. Inside of
#' `summary()` we first use `update()` on the model and within that use
#' `transform()` on the data being modeled to `scale()` the `AGE` variable.
summary(
  update(
    sexbmiagerace.lmeB,data=transform(
      example_train,AGE=scale(AGE,scale=F))))$tTable

#' In Black women only, there is a strong inverse correlation with `BMI` and 
#' `AGE`. So strong that at higher values `Y` becomes negative, and at the 
#' beginning I stipulated that a negative `Y` is an adverse health outcome! So 
#' this hypothetical drug would be hazardous, and strongly counter-indicated to 
#' female Black patients. Yet, if we used too small a sample size, or one that
#' is not representative of the population, _we would not have noticed_. We also
#' would not have noticed if we ignored the warning given to us by the residual
#' plots. In other words, any of the following can result in data being
#' misinterpreted potentially putting patients at risk:
#' 
#' * Excessively small sample sizes. 
#' * Sampling bias. 
#' * Omitting relevant variables. 
#' * Including too many irrelevant variables. 
#' * Not checking the residuals on what you think is an appropriate model.
#' 
#' Ready to publish? Nope. This is the training data we used to build our model.
#' Testing hypotheses on the same data is double-dipping! We need to fit this 
#' model to the data we have not touched yet.
#' 
#' Then we take the model we have, update it with this data, and save the 
#' result. While we're at it, we do the centering of `AGE` up front.
sexbmiagerace.test<-update(sexbmiagerace.lmeB
                           ,data=transform(example_test
                                           ,AGE=scale(AGE,scale=F)));
#' How do the residuals look?
plot(sexbmiagerace.test,resid(.,level=0)~fitted(.,level=0),abline=0);
qqnorm(sexbmiagerace.test,level=0,abline=0:1);
plot(sexbmiagerace.test,resid(.,level=0)~fitted(.,level=0)|SEX+RACE
     ,abline=0);
#' Parameter estimates and hypothesis tests.
summary(sexbmiagerace.test)$tTable
