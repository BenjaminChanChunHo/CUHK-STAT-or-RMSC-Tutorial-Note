## Basic Principle in R Function
num <- 3.678

# Function definition: round(x, digits = 0) 
# Round the values in x to the specified number of decimal places (default 0). 
round(num)                    # Round to default 0 decimal place
round(x = num)                # Same as above
round(num, 2)                 # Round to 2 decimal places
round(x = num, digits = 2)    # Same as above
round(digits = 2, x = num)    # Note: swapped order of arguments

## Basic Matrix Operation in R
### Read in data
# Get your current working directory
getwd()

# List the names of files in the named directory
# First single dot (.) means relative to the current directory
dir("./")      # Dataset is not found here

# Second double dots (..) means one directory upward from the current directory
dir("./../")   # Dataset is found here

# Read in data (a CSV file) under Dataset
# Save it to an object named d
d <- read.csv("./../Dataset/fin-ratio.csv")
names(d)    # Output the variable names
head(d)     # Return the first part of data (default: 6 rows)
str(d)      # Display the structure of an object

### Manipulate data
# Extract the first 6 columns in d and save it to an object named x
x <- d[, 1:6]

# Calculate the column means of x and save it to an object named m
# Display object m right after assignment by putting code inside parentheses ()
(m <- apply(x, 2, mean))

# Alternatively
m <- apply(X = x, MARGIN = 2, FUN = mean)    # See Basic Principle in R Function
m

# Calculate the sample covariance matrix of x and save it to an object named S
S <- var(x)
(round(var(x), 3))      # Display only 3 decimal places

# Calculate the sample correlation matrix of x
round(cor(x), 3)        # Display only 3 decimal places

### Manipulate matrices
options(digits = 4)     # Control display to 4 decimals
det(solve(S))           # Determinant of inverse of S
1/det(S)

eig <- eigen(S)         # Save eigenvalues and eigenvectors of S
names(eig)              # Display items in eig
(eval <- eig$values)    # Save eigenvalues
(H <- eig$vectors)      # Save matrix of eigenvectors

# t(x) returns the transpose of x
# %*%: matrix multiplication
round(t(H)%*%H, 3)      
round(H%*%t(H), 3)

h1 <- H[, 1]            # Extract first column of H (first eigenvector) to h1
eval[1]*h1              # Compute lambda1*h1  (displayed as row vector)
as.vector(S%*%h1)       # Compute S*h1        (displayed as row vector)

round(t(H)%*%S%*%H, 3)

D <- diag(eval)          # Form diagonal matrix D
H%*%D%*%t(H)

sqrt(D)
(rS <- H%*%sqrt(D)%*%t(H))
rS%*%rS