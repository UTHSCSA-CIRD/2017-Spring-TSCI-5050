#' ---
#' title: "R: Anatomy of a Programming Language"
#' author: "Alex F. Bokov"
#' date: "02/14/2017"
#' ---
#+ echo=TRUE,cache=TRUE
foo <- 2345237; baz <- 42; bar <- foo;

#' ### If statements
if(foo > baz) foo + bar;
if(foo < baz) foo + bar;

#' If you want to keep reusing the result of foo > bar, 
#' you can assign it to a variable.
bat <- foo > baz;
foo > baz;
bat;
#' Same result as last time.
if(bat) foo + bar;
#; Use of the else statement
if(FALSE) foo + bar else foo / 0;
#' ### Vectors
bax <- c(42, 43, 15 -5, 8 );
ban <- c(3.1, 1/7, 18, sqrt(5),0);
bam <- c('a','b','zz','wweaasdfa');
bam;
#' ### Common data types in R
#' Numbers:
3.436577
#' Characters
"sdaafdsas";
#' TRUE and FALSE
TRUE; FALSE;
#' And now... NOT AVAILABLE, `NA`
NA;
#' Which is different from `NULL`
NULL;
#' Curly brackets `{` and `}` cause the commands between them
#' to be executed in a "little world of their own" and return
#' only the result of the last command

#' A function with two arguments: `plot()`
bap <- runif(5);

#' Minimum starting point for your function:
MYFUNC <- function(xx,...){
 # I want to take input 'xx' and do  ??? with it
 # and return the result as an object called 'out'
}
