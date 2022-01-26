#Consider the seatbelt dataframe. Do you think there is a correlation between 
# a) Gas price and the average distance driven?
if (abs(cor(sb$PetrolPrice, sb$kms, method = "pearson")) > 0.5) {
  print("Yes there is a correlation between gas price and distance driven")
} else {
  print("There is no correlation bettween gas price and distance driven")
}
# b) Average distance driven and the number of drivers killed? 
if (abs(cor(sb$DriversKilled, sb$kms, method = "pearson")) > 0.5) {
  print("Yes there is a correlation between number of drivers killed and distance driven")
} else {
  print("There is no correlation bettween number of drivers killed and distance driven")
}
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
years <- unique(sb$year)
killed <- data.frame(
  "year" = years,
  "Drivers.Killed" = integer(length(years)),
  "Front.Passengers.Killed" = integer(length(years)),
  "Rear.Passengers.Killed" = integer(length(years)),
  "Law.Exists" = logical(length(years)))
for (i in 1:length(years)) {
  y.data <- subset(sb, year == years[i])
  killed[i, 1] <- years[i]
  killed[i, 2] <- sum(y.data$DriversKilled)
  killed[i, 3] <- sum(y.data$front)
  killed[i, 4] <- sum(y.data$rear)
  #killed[i, 5] <- (years[i] >= 1983)
  killed[i, 5] <- any(y.data$law > 0)
}
write.table(killed, file = "Killed.txt", sep = "\t", row.names = FALSE)