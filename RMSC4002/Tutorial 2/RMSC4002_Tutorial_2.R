### Read in Data
# Read in data (CSV files) under Dataset
# Save them to objects named d5, d2, d1
d5 <- read.csv("./../Dataset/0005.HK.csv")
d2 <- read.csv("./../Dataset/0002.HK.csv")
d1 <- read.csv("./../Dataset/0001.HK.csv")

# as.character: coerce its argument to character type
d5$Date <- as.character(d5$Date)
d2$Date <- as.character(d2$Date)
d1$Date <- as.character(d1$Date)

str(d5)            # str: display the structure of an object
str(d2)
str(d1)

### Clean Data
# Combine the three CSV files into one containing the adjusted daily closing prices only.
HSBC <- d5$Adj.Close
CLP <- d2$Adj.Close
CK <- d1$Adj.Close

# Sanity check: the same date
mean(d5$Date == d2$Date)          # 1 means they are identical
mean(d2$Date == d1$Date)          # 1 means they are identical

Date <- d5$Date                           # Save the date

d <- data.frame(Date, HSBC, CLP, CK)      # data.frame: create a data frame
head(d)                                   # Return the first part of data
tail(d)                                   # Return the last part of data

# write.csv: create a CSV file
write.csv(d, "./../Dataset/stock_2018.csv", row.names = FALSE) 

### Time Series Plot
is.ts(d$HSBC)              # is.ts: test whether an object is a time series
class(d$HSBC)              # class: prints the names of classes an object inherits from

# as.ts: coerce an object to a time-series
t1 <- as.ts(d$HSBC)        # For stock HSBC (0005)
is.ts(t1)
class(t1)

t2 <- as.ts(d$CLP)         # For stock CLP (0002)
t3 <- as.ts(d$CK)          # For stock Cheung Kong (0001)

# Compute daily percentage return
u1 <- (lag(t1)-t1)/t1      # lag: compute a lagged version of a time series
u2 <- (lag(t2)-t2)/t2
u3 <- (lag(t3)-t3)/t3

# Sanity check: match positive and negative returns
head(d)                    # Return the first part of data (default: 6 rows)

# First element corresponds to daily return on the 2nd day
head(u1, 5)                # Return the first 5 daily returns of HSBC
head(u2, 5)                # Return the first 5 daily returns of CLP
head(u3, 5)                # Return the first 5 daily return of Cheung Kong

# par: set or query graphical parameters
# mfrow and mfcol: the form c(nr, nc) means figures are drawn in
# an nr-by-nc array on the device by columns (mfcol) or rows (mfrow)
par()$mfrow                # mfrow = c(nr, nc)
par(mfrow = c(3,1))        # Set multi-frame for ploting
plot(u1)
plot(u2)
plot(u3)

# Compute average daily percentage return
cat("Average daily percentage return of", "\n",
    "HSBC: ", paste0(round(mean(u1)*100, 3), "% ;"), "\n",
    "CLP:  ", paste0(round(mean(u2)*100, 3), "% ;"), "\n",
    "CK:   ", paste0(round(mean(u3)*100, 3), "%"),
    sep = "")

# As you can see, the daily percentage returns fluctuate around 0 (more precisely on upward trend).

### Histogram and Normal QQ plot
par(mfrow = c(3,2))
hist(u1)                   # Produce histogram
qqnorm(u1)                 # Produce normal QQ plot
qqline(u1)                 # Add a line through theoretical 1st and 3rd quartiles

hist(u2)
qqnorm(u2)
qqline(u2)

hist(u3)
qqnorm(u3)
qqline(u3)

# There is some discrepancy, especially in the two tails. It suggests that normal distribution may not be plausible. More specifically, heavier-tailed distributions are needed.

### Check for Normal Distribution
# In statistical hypothesis testing, the p-value is the probability for a given statistical model that, when the null hypothesis is true, 
# the test statistic would be the same as or of greater magnitude than the actual observed results. 
# You would reject the null hypothesis when the p-value is small.

# ks.test: perform a Kolmogorov-Smirnov test
ks.test(u1, pnorm)                # KS normality test for u1, u2 and u3
ks.test(u2, pnorm)
ks.test(u3, pnorm)

# Write a function for JB-test
JB.test <- function(u) {
    n <- length(u)                # Sample size
    s <- sd(u)                    # Standard deviation
    sk <- sum(u^3)/(n*s^3)        # Skewness
    ku <- sum(u^4)/(n*s^4) - 3    # Excess kurtosis
    JB <- n*(sk^2/6 + ku^2/24)    # JB test statistic
    p <- 1 - pchisq(JB, 2)        # p-value
    cat("JB-stat:", JB, " p-value:", p,"\n")
}

JB.test(u1)
JB.test(u2)
JB.test(u3)

# Since the p-values are very small (close to 0), you should reject the null hypothesis that the daily percentage returns come from normal distribution. 
# It matches with the intuition gained from the plots.

### Check for t-distribution
# Write a function for QQ-t plot
QQt.plot <- function(u) {
    su <- sort(u)                     # Sort u
    n <- length(u)                    # Sample size
    s <- sd(u)                        # Standard deviation
    ku <- sum(u^4)/(n*s^4) - 3	      # Excess kurtosis
    v <- round(6/ku + 4)              # Estimate df, round to the nearest integer
    i <- ((1:n) - 0.5)/n              # Create a vector of percentile
    q <- qt(i, v)                     # Percentile point from t(v)
  
    hist(u)                           # Histogram of u
    plot(q, su, main = "QQ-t plot")   # Plot(q, su)
    abline(lsfit(q, su))              # Add least squares fit line
    v                                 # Output estimated df
}

par(mfrow = c(3,2))
v1 <- QQt.plot(u1)                    # QQ-t plot for u1, u2, u3 and save df
v2 <- QQt.plot(u2)
v3 <- QQt.plot(u3)

ks.test(u1, pt, v1)                   # KS t-test for u1, u2 and u3
ks.test(u2, pt, v2)
ks.test(u3, pt, v3)

# From the plots, t-distribution fits the tails better than normal distribution does. 
# However, the p-values are very small (close to 0) so you should reject the null hypothesis that the daily percentage returns come from t-distribution.

# Famous statistician George Box said "All models are wrong but some are useful".