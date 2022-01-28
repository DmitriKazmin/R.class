rm(list = ls())

setwd("/Users/jacob/Downloads/RClub/R.class-Lesson-3")

sb<- read.table("Seatbelts.txt", sep = "\t", header = TRUE)

year <- unique(sb$year)

driver <- list(sb$DriversKilled)[[1]]
front <- list(sb$front)[[1]]
rear <- list(sb$rear)[[1]]


deaths <- data.frame(
  "Year" <- year,
  "Driver" <- integer(length(year)),
  "Front" <- integer(length(year)),
  "Rear" <- integer(length(year)),
  "Seatbelts" <- logical(length(year))
)

for (i in 1:length(year)){
  deaths[[1]][[i]] <- year[i]
  for (j in 1:12){
    location <- 12*i-12+j
    deaths[[2]][[i]] <- driver[[location]]+deaths[[2]][[i]]
    deaths[[3]][[i]] <- front[[location]]+deaths[[3]][[i]]
    deaths[[4]][[i]] <- rear[[location]]+deaths[[4]][[i]]}
  if (year[i] < 1983) {
    deaths[[5]][[i]] <- FALSE
  } else{
    deaths[[5]][[i]] <- TRUE
  }
}
