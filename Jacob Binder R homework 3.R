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


# Dmitri's comments: 

# Alternatively, you can do it in a simpler way through subsetting: 

year <- unique(sb$year)

deaths <- data.frame(
  "Year" = year,
  "Driver" = integer(length(year)),
  "Front" = integer(length(year)),
  "Rear" = integer(length(year)),
  "Seatbelts" = logical(length(year))
)
# We use = , not <- , for forming data frames

for (i in 1:length(year)){
  deaths[i, 1] <- year[i]  # deaths is a data frame, not a list, we don't use [[]] for data frames
  deaths[i, 2] <- sum(sb$drivers[sb$year == year[i]])
  deaths[i, 3] <- sum(sb$front[sb$year == year[i]])
  deaths[i, 4] <- sum(sb$rear[sb$year == year[i]])
  if (year[i] < 1983) {
    deaths[i, 5] <- FALSE
  } else {
    deaths[i, 5] <- TRUE
  }
}


  

