
# R lesson 3. FOR loops and IF/ELSE statements ----------------------------

rm(list = ls())

setwd("~/Work/Python.club/Lesson.3/")


# FOR ---------------------------------------------------------------------

DNase <- read.table("DNAse.txt", sep = "\t", header = TRUE)
# sep = "\t" indicates that values are separated by a tab
# header = TRUE indicates that the first row in the table is column headers

# This is a pre-existing dataset in R. 
# This dataset comprises data from eleven experiments, in 
# which the activity of an enzyme was measured by the amount of 
# colored product it produces. 
# The colored product of the enzymatic reaction is detected by 
# the optical density of the solution.The deeper the color, the more 
# enzymatic activity there was. 

View(DNase)

# let's create a vector of unique experiment IDs: 
class(DNase$Run)  

exp <- unique(DNase$Run)
exp

# Now let's create a loop that would calculate the correlation coefficients 
# for each experiment. Remember, the color (optical density) should be 
# proportionate to the concentration of the enzyme, so we should get pretty reasonable 
# correlation coefficients. 

# To begin: (Do not run)
for (i in 1:length(exp)) { 
  # Do this
}


# The "FOR" statement is followed by round brackets, which include the iteration
# variable and the range. In this case, we say that we want to start with i=1 
# and iterate until i reaches the number of experiments (11).

# The FOR statement is followed by curly brackets that include the entire loop. 
# There is no indentation of for / if loops as in python. Each loop is enclosed
# in its own set of curly brackets. 

# Now let's isolate the data for each experiment into a separate dataframe

for (i in 1:length(exp)) {
  my.data <- subset(DNase, Run == exp[i])
}

# Using i = 1 as an example: 
i <- 1
my.data <- subset(DNase, Run == exp[i])

# And now let's calculate Pearson regression coefficient:

for (i in 1:length(exp)) {
  my.data <- subset(DNase, Run == exp[i])
  regr <- cor(my.data$conc, my.data$density, method = "pearson")
}

# But how do we summarize the data across all eleven experiments? 

# Let's create a dataframe to hold our results: 
out <- data.frame("Experiment" = integer(11), 
                  "Pearson.R" = numeric(11))

# And fill it with values within the FOR loop

for (i in 1:length(exp)) {
  my.data <- subset(DNase, Run == exp[i])
  regr <- cor(my.data$conc, my.data$density, method = "pearson")
  out[i, 1] <- i  # We can also say exp[i], which should be the same number
  out[i, 2] <- regr
}

View(out)

# Now we can write the result to a file: 
write.table(out, file = "DNAse.experiment.Pearson.coefficients.txt", 
            sep = "\t", 
            row.names = FALSE)
# Here we specify the separator and tell R not to output the row numbers

# Hands on practice 1: -----------------

# Read file "Indometh.txt". It contains the concentrations of a drug at different 
# time points after administration in six subjects

# Write a for loop that would plot concentration vs. time for six subjects. 
# Use this code for plotting: 
# plot(x = my.data$time, y = my.data$conc, main = paste("Subject ", i, sep = ""))


# Cheat sheet -------------------------------------------------------------

indo <- read.table("Indometh.txt", sep = "\t", header = TRUE)

subject <- unique(indo$Subject)

for (i in 1:length(subject)) {
  my.data <- subset(indo, Subject == subject[i])
  plot(x = my.data$time, y = my.data$conc, main = paste("Subject ", i, sep = ""))
}

# Which subject has the fastest clearance of the drug? Which one has the slowest? 





# IF / ELSE ---------------------------------------------------------------

# Let's look at the violent crime rates in the US. 

USArrests <- read.table("USArrests.txt", sep = "\t", header = TRUE)
colnames(USArrests)[1] <- "State"

plot(y = USArrests$Murder, x = USArrests$Assault, main = "Murder by Assault", 
     xlab = "Assault, per 100,000 population", ylab = "Murder, per 100,000 population")
# As you can see, there is a clear correlation between assault and murder rates per state. 
# (Although there is practically no correlation between crime rates and percent urban 
# population. You can check yourself).

# Let's write a code that would output the top most dangerous states.
# We will consider a state "dangerous" if it falls in the top 20% of _both_ assault and 
# murder rates


dangerous <- data.frame("State" = character(10), 
                        "Assault.rate" = numeric(10), 
                        "Murder.rate" = numeric(10))
# Here we create an empty data frame with 10 rows. If we don't use all rows, we will delete
# unused rows later

# Lets define the top and bottom thresholds for assault, murder and rape
assault.high <- sort(USArrests$Assault)[41]   # This includes the top 10 states (20%) with the highest assault rates 
murder.high <- sort(USArrests$Murder)[41]


n <- 1
for (i in 1:nrow(USArrests)) {
  if (USArrests$Murder[i] >= murder.high & USArrests$Assault[i] >= assault.high) {
    dangerous[n, 1] <- USArrests$State[i]
    dangerous[n, 2] <- USArrests$Assault[i]
    dangerous[n, 3] <- USArrests$Murder[i]
    cat(USArrests$State[i], " is a dangerous state to live in", "\n")
    n <- n+1
  } else {
    cat(USArrests$State[i], " is not a dangerous state", "\n")
  }
}

dangerous <- dangerous[c(1:n-1), ]

View(dangerous)

write.table(dangerous, file = "Dangerous.txt", sep = "\t", row.names = FALSE)

# Importantly, you can just as well use subsetting instead of a loop: 

USArrests$Assault >= assault.high
USArrests$Murder >= murder.high
USArrests$Assault >= assault.high & USArrests$Murder >= murder.high
danger <- subset(USArrests, Assault >= assault.high & Murder >= murder.high)

# Hands on practice 2 -----------------------------------------------------

# Now, let's select the safest states, following the same template. 
# Output the table with the safest states to a tab-delimited file.


# Cheat sheet 2 -----------------------------------------------------------
safe <- data.frame("State" = character(10), 
                   "Assault.rate" = numeric(10), 
                   "Murder.rate" = numeric(10))

assault.low <- sort(USArrests$Assault)[10]
murder.low <- sort(USArrests$Murder)[10]

m <- 1
for (i in 1:nrow(USArrests)) {
  if (USArrests$Murder[i] <= murder.low & USArrests$Assault [i] <= assault.low) {
    safe[m, 1] <- USArrests$State[i]
    safe[m, 2] <- USArrests$Assault[i]
    safe[m, 3] <- USArrests$Murder[i]
    cat(USArrests$State[i], " is a safe state", "\n")
    m <- m+1
  } else {
    cat(USArrests$State[i], " is not one of the safest states to live in", "\n")
  }
}

safe <- safe[c(1:m-1), ]

View(safe)

write.table(safe, file = "Safe.txt", sep = "\t", row.names = FALSE)


# ELSEIF ------------------------------------------------------------------

# Let's look at the roadway fatalities and serious injuries in Great Britain in 1969-84

sb<- read.table("Seatbelts.txt", sep = "\t", header = TRUE)

View(sb)

# Let's find out whether seatbelt law had any effect on the death rate of driver
# and passengers

t.driver <- t.test(sb$drivers[sb$law==0], sb$drivers[sb$law==1])
p.driver <- t.driver$p.value
t.front <- t.test(sb$front[sb$law==0], sb$front[sb$law==1])
p.front <- t.front$p.value
t.rear <- t.test(sb$rear[sb$law==0], sb$rear[sb$law==1])
p.rear <- t.rear$p.value

if (p.driver < 1e-5) {
  print("Seatbelt law had a very strong effect on diver death rate")
} else if (p.driver > 1e-5 & p.driver < 0.05) {
  print("Seatbelt law had a moderate effect on driver death rate")
} else {
  print("Seatbelt law had no effet on driver death rate")
}

if (p.rear < 1e-5) {
  print("Seatbelt law had a very strong effect on rear passenger death rate")
} else if (p.rear > 1e-5 & p.rear < 0.05) {
  print("Seatbelt law had a moderate effect on rear passenger death rate")
} else {
  print("Seatbelt law had no effect on rear passenger death rate")
}

# Homework ----------------------------------------------------------------
#
# PART ONE
#
# Consider the seatbelt dataframe. Do you think there is a correlation between 
# a) Gas price and the average distance driven?
# b) Average distance driven and the number of drivers killed? 
# 
# Test your hypothesis using the cor() function. 
#
# Write an if / if else / else loop to output a verbal conclusion of your findings. 
#
# Consider a correlation coefficient > 0.5 or < -0.5 as significant correlation, 
# and between -0.5 and 0.5 as insignificant. 
#
# PART TWO
#
# Calculate a total number of 
# a) drivers
# b) front seat passengers
# c) rear seat passengers 
# killed in each year. Output your findings to a dataframe, and add a logical 
# (TRUE / FALSE) column indicating whether a seatbelt law was in effect that year 
# (consider 1983 as a year when seatbelt law was in effect). 
# Save the resulting dataframe as a text file. 
#
# 

