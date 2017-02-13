# appt Bokov
foo <- c(2,4,6,8,0,1,3,23);
# if you don't "save" a value to an object, it still exists
# but is destroyed as soon as your command is over
c(2,4,6,8,0,1,3,23);
# you can run a command on it, and then it is lost
length(c(2,4,6,8,0,1,3,23));
# calculate average (mean);
mean(foo);
?mean
abs(foo);
sqrt(foo);
juan <- c(4)
# This expression returns its result to the console...
c(2,4,6,8,0,1,3,23,23,5566,36);
# While this one doesn't return anything to the console, instead it
# gets "intercepted" and saved to an object we named "bob"
bob <- c(2,4,6,8,0,1,3,23,23,5566,36);
# Now we can call back these values anytime we want
bob;
# bob to the 4th power, since juan is 4
bob^juan;
# and you can get rid of an object with the rm() command
rm(bob);
# now bob^juan does not work
bob^juan;
# is the modulo operator-- how much is left over after division
foo%%juan;
#homework problem;
riddle <- function (object = nm, nm) 
{
  names(object) <- nm
  object
}
# try running riddle
riddle(foo,letters[1:8]);
# riddle now exists as a function. If you call debug on it, it 
# will let you go through one step at a time through riddle,
# as if you were doing the commands by hand one after the other
# instead of all at once
debug(riddle);
riddle(foo,letters[1:8]);
# now let's turn off debug for this function
undebug(riddle);
riddle(foo,letters[1:8]);
#2nd homework problem
conundrum <- function (len)
{
  out <- c(1,1)
  for (ii in 3:len){
    out <- c(out,out[ii-1] + out[ii-2])
  }
  out
}

#list of patients evaluated
club<- function (xx)
{
  #return number of patients
  
}