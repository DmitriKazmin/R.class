# Extract the smallest number from the first column of mat.1
min(mat.1[,1])
# Extract the greatest number from the last row of mat.1
max(mat.1[nrow(mat.1),])
# Find out the name of the student (or students) who is taller than 180 cm and is blonde in the df data frame
subset(df, Height.cm > 180 & Blonde)$Name
# Find out the name of the student with the lowest grade in the df data frame (don't assume that the lowest grade is C )
subset(df, Grade == max(df$Grade))$Name

# 1. Create one variable of each type known to you, except a list
scalar <- "Hello"
vector <- c("Number picker", 1:10)
mat.3 <- matrix(nrow = 3, ncol = 3, integer(9))
data_frame <- data.frame(
  "Class" = c("Python", "Scratch", "Java"),
  "Avg.age" = c(12, 8, 13))
# 2. Create a list of all of these variables
lst <- list(scalar, vector, mat.3, data_frame)
# 3. Extract subsets of data from each member of the list using indexing
substr(lst[[1]], 1, 1)
lst[[2]][1]
lst[[3]][3, 3]
lst[[4]]$Class