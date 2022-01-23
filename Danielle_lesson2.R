# 1. Create one variable of each type 

scalar <- 5
vector <- c(1:7)
dataFrame <- data.frame(
  "Name" = c("Danielle", "Hedvig"),
  "Age" = c("16"),
  "Favfood" = c"Icecream")
matrix <- matrix(nrow = 7, ncol = 7, c(1:49))


# 2. Create the list 

list <- list(scalar, vector, dataFrame, matrix)

# 3. Extract subsets 
list[1]
list[[2]][3]
list[[3]]$Name[2]
list[[4]][2,2]