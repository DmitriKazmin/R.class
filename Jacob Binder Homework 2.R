#Making the variables

scalar <- 1
vector <- c(1, 2)
dataframe <- data.frame("Name" = c("Jacob", "Bocaj"),
                        "Age" = c(13, 31))
matrix <- matrix(ncol = 2, nrow = 2, c(sample(1:4)))

#Making the list

list <- list(scalar, vector, dataframe, matrix)

#Extracting from the list

list[1]
list[[2]][1]
list[[3]]$Name[1]
list[[4]][1, 1]