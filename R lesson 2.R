
# R lesson 1 part 2 -------------------------------------------------------

rm(list = ls())  # This deletes all variables, values and functions and clears the workspace. 

setwd("~/Work/Python.club/")  # This sets the active (working) directory. 
# Modify this line to include the path to your working directory. 


# Data classes -------------------------------------------------------------------

# R operates with several CLASSES of data. These include: 
#
# Strings, a.k.a. "character"
# Numbers, a.k.a. "numeric"
# Integer, a.k.a. "integer"
# Complex numbers, a.k.a. "complex"
# Logicals (TRUE or FALSE), a.k.a. "logical"

# In this class we will mostly deal with numeric, character and logical classes of variables. 

# Create a character variable: 
myString <- "Hello world!"  # We always include strings in single ' ' or double " " quotes
class(myString)

# Create a numeric variable: 
myNumber <- 10
class(myNumber)

# Create a logical variable: 
myLogical <- TRUE # We do not enclose logical values in quotes, otherwise it will be treated as a string
class(myLogical)


# Data types --------------------------------------------------------------

# R deals with the following data TYPES, which can store variables of various classes
# 
#  Scalars
#  Vectors
#  Matrices
#  Data frames
#  Lists
#


# Scalars -----------------------------------------------------------------

# Scalars are the simplest types of variables, which contain only one element. 
# myString, myNumber, myLogical above are all examples of scalars


# Vectors -----------------------------------------------------------------

# vectors are linear arrays of two or more elements. Vectors can only store elements 
# of the same class. 

# To create a vector we use the c() function, which includes the elements of the 
# vector as its arguments. c stands for "combine" or "concatenate"

myNumericVector <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
# which is the same as 
myNumericVector <- c(1:10)
# the symbol : means "everything in between". 1:10 means "every integer from 1 to 10"

myStringVector <- c("I am", 50, "years old")
myStringVector
# Pay attention that the numeral 50 was converted to a string to be compatible 
# with the classes of the other two elements

# Matrices -------------------------------------------------------

# Matrix is a two-dimensional numeric or logical array

# Let's create a matrix and fill it with random numbers sampled from a uniform distribution
mat.1 <- matrix(ncol = 5, nrow = 10, c(sample(1:100, 50)))
# When a matrix is filled with values, it is always filled column-wise: 
# First we fill all rows in the first column, 
# then all rows in the second column, and so on

# We can give the rows and columns of a matrix their names
row.names(mat.1) <- letters[1:10]  # Letters is a built-in variable in R
colnames(mat.1) <- c("John", "Mary", "NoName", "DropTableStudents", "Opossum")

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
mat.1[, ncol(mat.1)]   # ncol() is a function that produces the number of columns in a matrix or data frame

# Or the previous to last row: 
mat.1[nrow(mat.1) - 1, ]   # nrow() is a function that produces the number of rows in a matrix or data frame


# Hands-on practice 1 -----------------------------------------------------

# Create a 5x7 matrix mat.2. Populate it with sequential numbers from 1 to 35
# using the : operator

# Give the matrix some row.names and colnames. Make them strings of your choice

# Get the dimensions of the matrix. You should get an array of numbers 5 and 7, in this order

# Without looking, can you tell which numbers are in the last row of the matrix? 

# Check your answer by displaying the values from the last row. Were you correct? 


# Cheat sheet 1 -----------------------------------------------------------

mat.2 <- matrix(nrow = 5, ncol = 7, c(1:35))
row.names(mat.2) <- c("Annie", "Bob", "Charlie", "Douglas", "Eva")
colnames(mat.2) <- c("Weight", "Height", "Number.of.fingers", 
                     "Number.of.teeth", "Number.of.whiskers", 
                     "Grade.test.1", "Grade.test.2")
dim(mat.2)

# Multiples of 5, because the matrix is filled column-wise
mat.2[5, ]


# Data frames -------------------------------------------------------------

# Data frames are two-dimensional structures that can hold both character, numeric and logical values

# Create an empty 4x6 data frame (4 rows and 6 columns)
df <- data.frame("Name" = character(4), 
                 "Age.years" = integer(4), 
                 "Weight.lb" = numeric(4), 
                 "Height.cm" = numeric(4), 
                 "Grade" = character(4), 
                 "Blonde" = logical(4))
# Here we specify the types of data that will go into each column. 
# You cannot mix different data types (numbers, strings or logicals) in one column. 

# Fill it with values. 
# To refer to the columns of a data frame, we use the dollar sign $
df$Name <- c("Mary", "John", "Agnes", "Bob")
df$Age.years <- c(17, 16, 19, 18)
df$Weight.lb <- c(115, 180, 135, 163)
df$Height.cm <- c(150, 182, 165, 190)
df$Grade <- c("A", "A", "B", "C")
df$Blonde <- c(TRUE, TRUE, FALSE, FALSE)

View(df) 

# We can give rows names, just like with matrices
row.names(df) <- paste("Student.", c(1:4), sep = "")

# We can always add more columns to the data frame
df$Eye.color <- c("Green", "Brown", "Grey", "Red")

# Subsetting a data frame
girls <- subset(df, Name == "Mary" | Name ==  "Agnes")  # | is a boolean operator "OR". 
heavy <- subset(df, Weight.lb > 150)
vampires <- subset(df, Eye.color == "Red")

# Ordering a data frame
df <- df[order(df$Age.years), ]

# Deleting data from a data frame
df.1 <- df[, -6]
df$Blonde  # Gives us a logical vector
df.2 <- df[df$Blonde == TRUE, ]  
# Which is the same as to type: 
df.3 <- df[df$Blonde, ]
# Or choose rows which contain data for NOT BLONDES
df.4 <- df[!(df$Blonde == TRUE), ]  # ! sign stands for "not"  (also a boolean) (not TRUE is FALSE)

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
l1 <- list(l2, mat.1, df, c(TRUE, TRUE, FALSE), c("Dmitri", "Kazmin"), c(1:10)) 

# Investigate the contents of the list
l1[[1]][[1]][3] # This should be "c"
l1[[2]][2,3]  # This should be whatever random number
l1[[3]]$Name  # THis should produce the names of four students
l1[[4]]  # This should produce a logical vector
paste(l1[[5]][1], l1[[5]][2], sep = " ")  # This should produce "Dmitri Kazmin"
l1[[6]][11]  # This should produce out-of-bounds error or an NA value

# Hands-on exercise: 

# Extract the smallest number from the first column of mat.1
# Extract the greatest number from the last row of mat.1
# Find out the name of the student (or students) who is taller than 180 cm and is blonde in the df data frame
# Find out the name of the student with the lowest grade in the df data frame (don't assume that the lowest grade is C )


# Cheat sheet -------------------------------------------------------------

# in my case 
mat.1[9, 1]
mat.1[10, 1]

df$Name[df$Height.cm > 180 & df$Blonde == TRUE]

df <- df[order(df$Grade), ]
df$Name[4]


# HOMEWORK ----------------------------------------------------------------

# 1. Create one variable of each type known to you, except a list
# 2. Create a list of all of these variables
# 3. Extract subsets of data from each member of the list using indexing
# 4. Create an account on Github
# 5. Send me your email that you used to register, or your user name, so I could invite you to the repository. 

# Upload your code to Github to the branch named "homework"!!! 
# Make sure your homework code is labeled with your name in the filename!!!
# If you get stuck, open an issue on Github





