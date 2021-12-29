
# R lesson 1 part 2 -------------------------------------------------------

# Matrices -------------------------------------------------------

# Matrix is a two-dimensional numeric array

# Let's create a matrix and fill it with random numbers sampled from a uniform distribution
mat.1 <- matrix(ncol = 5, nrow = 10, c(sample(1:100, 50)))

# We can also create an empty matrix filled with NAs (generally a bad idea)
mat2 <- matrix(, ncol = 5, nrow = 10)

# We can give the rows and columns of a matrix names
dimnames(mat.1) <- list(c(letters[1:10]), 
                        c("John", "Mary", "NoName", "DeleteTableStudents", "Opossum"))

# And see what are the names of the rows and columns
row.names(mat.1)
colnames(mat.1)

# We can also replace any name with something else
colnames(mat.1)[4] <- "DoNotDelete"
colnames(mat.1)

# We can get the dimensions of the matrix
dim(mat.1)  # First dimension is always rows, the second is columns

# We can refer to any member of the matrix by it's index, or "coordinates". 
# Indices are enclosed in square brackets. 
# Vertical coordinate goes first, the horizontal coordinate goes second. 
# Indexing starts with 1, not with 0 as in Python
# Indices are separated by a comma
# If we want to get the entire row of column of a matrix, we replace the corresponding index with an empty space (or no space)
mat.1[1,1]
mat.1[5,5]
mat.1[, 3]
mat.1[5, ]

# To get the last column, we can use: 
mat.1[, ncol(mat.1)]

# Or the previous to last row: 
mat.1[nrow(mat.1) - 1, ]


# Data frames -------------------------------------------------------------

# Data frames are two-dimensional structures that can hold both character, numeric and logical values

# Create an empty 4x6 data frame
df <- data.frame("Name" = factor(4), 
                 "Age.years" = integer(4), 
                 "Weight.lb" = numeric(4), 
                 "Height.cm" = numeric(4), 
                 "Grade" = character(4), 
                 "Blonde" = logical(4))

# Fill it with values. 
# To refer to the columns of a data frame, we use the dollar sign $
df$Name <- c("Mary", "John", "Agnes", "Bob")
df$Age.years <- c(17, 16, 19, 18)
df$Weight.lb <- c(115, 180, 135, 163)
df$Height.cm <- c(150, 182, 165, 190)
df$Grade <- c("A", "A", "B", "C")
df$Blonde <- c("TRUE", "TRUE", "FALSE", "FALSE")

# We can give rows names, just like with matrices
row.names(df) <- paste("Student.", c(1:4), sep = "")

# We can always add more columns to the data frame
df$Eye.color <- c("Green", "Brown", "Grey", "Red")

# Subsetting a data frame
girls <- subset(df, Name == "Mary" | Name ==  "Agnes")
heavy <- subset(df, Weight.lb > 150)
vampires <- subset(df, Eye.color == "Red")

# Ordering a data frame
df <- df[order(df$Age.years), ]

# Deleting data from a data frame
df.1 <- df[, -6]
df.2 <- df[!(df$Blonde == "TRUE"), ]


# Lists -------------------------------------------------------------------

# Lists are linear structures that can contain characters, numbers, vectors, logicals, matrices, data frames or other lists

# Initialize an empty list
l1 <- list()

# Initialize a pre-filled list
l2 <- list(letters[1:10], seq(from = 1, to = 100, by = 5))

# To refer to a member of a list, we use double square brackets [[ ]]
l2[[2]]
l2[[1]][3:5]

# Add data to an empty list
l1 <- list(l2, mat.1, df, c("TRUE", "TRUE", "FALSE"), c("Dmitri", "Kazmin"), c(1:10)) 

# Investigate the contents of the list
l1[[1]][[1]][3] # This should be "c"
l1[[2]][2,3]  # This should be 87
l1[[3]]$Name  # THis should produce the names of four students
l1[[4]]  # This should produce a logical vector
paste(l1[[5]][1], l1[[5]][2], sep = " ")  # This should produce "Dmitri Kazmin"
l1[[6]][11]  # This should produce out-of-bounds error or an NA value


# HOMEWORK ----------------------------------------------------------------

# 1. Create one variable of each type known to you, except a list
# 2. Create a list of all of these variables
# 3. Extract subsets of data from each member of the list using indexing

# Upload your code to Github!!! 
# Make sure your homework code is labeled with your name in the filename!!!





