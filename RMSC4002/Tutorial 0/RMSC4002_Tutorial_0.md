---
title: "CUHK RMSC4002 Tutorial 0"
author: "Benjamin Chan"
date: "September 9, 2018"
output: 
  html_document: 
    keep_md: yes
editor_options: 
  chunk_output_type: console
---



## Introduction to R
### Downloading and installing R
You can download R from https://www.r-project.org/ and RStudio from https://www.rstudio.com/products/rstudio/download/#download. Follow the instruction there to install them. RStudio is strongly recommended because it is more user-friendly.

### Executing code
Of course you can type any command in R Console and get the result directly. It is the reason why R is regarded as an interactive program that has a command line interface. Nevertheless, to transit from a user to a programmer, you have to write script/code.

If you are using R Script in RStudio, you can click on a line of code and then press `Ctrl` + `Enter` together to execute it. You can also execute a block of code by first selecting any code and then pressing `Ctrl` + `Enter` together.

If you are using R Script in R, you should press `Ctrl` + `R` together instead.

If you are using R Markdown in RStudio, you can click on a line and then press `Ctrl` + `Enter` together to execute that line ONLY. Alternatively you can press `Ctrl` + `Shift` + `Enter` together to execute a block of code (starting and ending with triple grave \```) without selection.

### Getting help
You can use `help(function)` or `?function` to get help from R documentation, where `function` is the function name. You can find the function description, the package it belongs to, arguments explanation and some examples, etc.

If you are using RStudio, you can see R documentation from `Help` tab. If you are using R, a webpage version is popped up.

```r
help(read.csv)
?apply
```

As you can see, `read.table` is a function under `utils` package. The description says "Reads a file in table format and creates a data frame from it, with cases corresponding to lines and variables to fields in the file". Moreover, it says "`read.csv` is identical to `read.table` except for the defaults. It is intended for reading 'comma separated value' files ('.csv')".

Similarly, `apply` is a function under `base` package. The description says "Returns a vector or array or list of values obtained by applying a function to margins of an array or matrix".

### Writing comments
You can add `#` before the statement. Comments are not executed but are useful for enhancing readability of your code.

```r
# This statement is not executed.
```

If you are using RStudio, you can select a block of code and then press `Ctrl` + `Shfit` + `C` together to turn it into comments. On the other hand, you can select a block of comments and then press `Ctrl` + `Shfit` + `C` together to turn them into code.

### Setting working directory
You can regard a directory as a folder that R is working on.

In RStudio, choose one of the following four options: </br>
1. Click `Session` $\rightarrow$ `Set Working Directory` $\rightarrow$ `Choose Directory` </br>
2. Press `Alt` $\rightarrow$ `S` $\rightarrow$ `W` $\rightarrow$ `C`  </br> 
3. Press `Ctrl` + `Shift` + `H` </br>
4. Type `setwd(dir)` in console/code to set the working directory, where `dir` (starting and ending with quotes \") is the target working directory.

In R, choose one of the following three options: </br>
1. Click `File` $\rightarrow$ `Change directory` </br>
2. Press `Alt` $\rightarrow$ `F` $\rightarrow$ `C` </br> 
3. Type `setwd(dir)` in console/code to set the working directory, where `dir` (starting and ending with quotes \") is the target working directory.


```r
# Get your current working directory
getwd()
```

```
[1] "C:/Users/Benjamin Chan/Desktop/Tutorial/CUHK-STAT-or-RMSC-Tutorial-Note/RMSC4002/Tutorial 0"
```

```r
# Set your target working directory (assumed to be "C:/Temp")
setwd("C:/Temp")
```

### Installing and loading packages
You only need to install a package once in your computer. However, you may need to load a package each time you open a new R session.

```r
# Use tseries package for example
install.packages("tseries")  # Install package
library(tseries)             # Load package
```
