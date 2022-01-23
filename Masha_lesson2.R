# 1. Create one variable of each type known to you, except a list
scalar <- "Hello World!"
vector <- c(1:5)
matrix <- matrix(nrow = 5, ncol = 5, c(1:25))
dataFrame <- data.frame(
  "Name" = c("Gorodetski,", "Masha"),
  "Grade" = c("10"),
  "Age" = c("16"))
# 2. Create a list of all of these variables
list <- list(scalar, vector, matrix, dataFrame)
# 3. Extract subsets of data from each member of the list using indexing
list[[1]]
list[[2]][3]
list[[3]][2,4]
list[[4]]$Name
