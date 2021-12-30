# My first line of code is a comment
print("Hello world!")

# Now we are going to create the first variable. Let's call it "My_first_variable"
My_first_variable <- "Hello world!"

# We can make functions to take variables as arguments
print(My_first_variable)   # We do not enclose variable names in quotes

# Let's find out the class of the My_first_variable variable
class(My_first_variable)

# We can also find out the dimensions of the variable (in this case, the length of the vector)
dim(My_first_variable) # Which is "NULL", indicating that this variable has no dimensions

# Let's create a more complex variable: 
My_second_variable <- c("Hello", "world","!")
# c(), which stands for "combine", is an accessory function which combines its arguments into a single variable. 

# We can find out the dimensions of the new variable: However it will not be 1 by 3, as vectors do not have dimensions
dim(My_second_variable)

# However, vectors have length, which can be found out by using the length() function
length(My_second_variable)

# Now let's refer to the individual elements of the character vector: 
My_second_variable[1]     # This will display the contents of the first element in the command line window 
one <- My_second_variable[1]    # This will assign the contents of the first element of the My_second_variable to the new variable, "one"

# And likewise we can do for the second and the third elements: 
My_second_variable[2]
two <- My_second_variable[2]
My_second_variable[3]
three <- My_second_variable[3]

# We can put the three variables back together into a character variable, and can also add something to it: 
My_third_variable <- c(one, two, three, "My name is Vanya", "I am", 38, "years", "old")

# Can we print the contents of a character array as a readable text? 
print(My_third_variable)  # Ugh... this is not what we want
# but what if we try it with cat()? (Anothеr concatenation function. The same function also exists in Bash)
cat(My_third_variable, "\n", sep=" ")

# Likewise, we can use the paste() function to output a concatenated string to a variable: 
mitia <- paste("Dmitri", "Kazmin", sep=" ")

# Hands-on exercise: 

# Create a variable named "first" that contains your first name
# Create a variable named "last" that contains your last name
# Create a variable named "name" that contains both your first and your last names separated by a white space
# Create a variable named "age" that contains your age in years
# Create a variable named "location" that contains the name of your hometown and state (such as "New York, NY")

# Using paste() and cat() functions to create the following output: 

#  Hello! My name is YourFirstName YourLastName. 
#  I live in YourHomeTown.
#  I was born in (2021 - YourAge).



# Cheat sheet -------------------------------------------------------------

first <- "Dmitri"
last <- "Kazmin"
name <- paste(first, last, sep = " ")
age <- 50
location <- "Lilburn, GA"
birthyear <- 2021 - age

cat("Hello! My name is", name, ".", "\n", 
    "I live in", location, ".", "\n", 
    "I was born in", birthyear, "\n")
