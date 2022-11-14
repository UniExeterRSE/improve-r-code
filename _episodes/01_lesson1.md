---
layout: page
title: Improve your own R code
order: 2
session: 1
length: 20
toc: true
---

## Learning Objectives
At the end of this lesson you will be able to

- implement general good coding practices for readability and functionality
- reflect on what makes code easy to follow/use
- define a personal coding style
- develop the structure and content of an R script to improve its functionality or reproducibility


    
## Why do you want to improve your code?

Are you aiming to make your code more readable? Maybe you want to share your scripts? Speed up parts of your analysis, or find out which functions are 
slowing down your script?
The reasons behind your rationale for joining this class will affect which parts of this course you incorporate into your coding. We have split up these 
aspects into two main areas; aesthetics and functionality.

    
## First, a test of your script...

Hopefully you have brought along a script which you are aiming to improve. 

This first script that follows will run a static code analysis to check the readability and stylistic elements of your script (first change the variable `infile` to the path to your script). 

<details>
    <summary><code>styleTest.R</code></summary>

```r
##---------------------------------------------------------------------#
## Title: Style test =================================================
##
## Date Created: 2022-11-11
##---------------------------------------------------------------------#

# LOAD PACKAGES ========================================================

if (!require("lintr", quietly = TRUE))
    install.packages("lintr")

library(microbenchmark)
library(lintr)
library(styler)

# IMPORT DATA ===========================================================

## set variable files to check
infile <- "<path/to/your/script/here>"

## using a linter to check style adherence
linter<-lint(infile) 
linter
res <- cbind(filename=infile, styleTest=length(linter))

# write results to file
write.table(res, "scriptTest.txt", sep = '\t', row.names = FALSE, quote = FALSE)
```
    
</details>

This second script requires being copied into your script (so that your script sits inside) and will then calculate the speed of your script. 

<details>
    <summary><code>speedTest.R</code></summary>

```r
start_time <- Sys.time()
              
<your-script-here>    
    
end_time <- Sys.time()

# combine previous stylistic test results with speed
res <- read.table("scriptTest.txt", header = TRUE) %>%
  cbind(speedTest = end_time - start_time)

# write results to file
write.table(res, "scriptTest.txt", sep = '\t', row.names = FALSE, quote = FALSE)
```
    
</details>
<details open>
    <summary><h2>1. Aesthetics</h2></summary>

<details open>
    <summary><h3>1.1. Linters</h3></summary>

Naming conventions and grammatical structure in your code all aid in readability and reproducibility of code. There are tools known as linters which provide a static code analysis, checking for syntax errors, sematic issues and adherence to particular style. 

The package `lintr` applies this static code analysis in R. By default, it follows the tidyverse style guide but can be configured to report whichever style you might want to use. To try this out, you can simply run: 

```r
install.packages("lintr")
library(lintr)`
lint("<file-name.R>")
```

To configure this, perhaps you want to change the default naming convention to camelCase:

`lint("<file-name.R>", linters = linters_with_defaults(object_name_linter("camelCase"))`

You can then address each point from the console output, or alternatively you may use the `styler` package which will reformat the syntax and grammar of your code according to the same defaults as `lintr`. *Though be careful! - this will overwrite the original file.* 

> 💡 **ctrl-shift-a**        automatically format highlighted code with spaces

We will demonstrate with the below script which creates a dataframe, adds an ID column, calculates the mean of each column and then subtracts the mean from each value. Don't worry about coding along as you will get a chance to implement this with your script at the end.

<details>
    <summary><code>badScript.R</code></summary>
    
```r
times=400000
cols=100
data<- as.data.frame(matrix(rnorm(times*cols, mean= 5),
                           ncol =cols))
data <-cbind(id =paste0("E",seq_len(times)), data)


## store in new variable
newData <- data

## column means
means <- apply(newData[, names(newData)!="id"], 2, mean)

## minus mean from each column
for (i in 1:length(means)) {
  newData[,names(newData) != "id"][,i] <-newData[,names(newData) != "id"][, i] - means[i]
}    
```
</details>
</details>         
<details open>
<summary><h3>1.2. Code order</h3></summary>

There are also standard practices for code organisation. These will make your code more easily accessible - both for others using your code and your future self - and also more easily editable. Main aspects to follow:

1. call your libraries on top of code
2. set all default variables or global options and all the path variables at the top of the code.
3. source all the code at the beginning
4. load all the data-files at the top

See here: [Chapter 3 Code Structure | Best Coding Practices for R (bookdown.org)](https://bookdown.org/content/d1e53ac9-28ce-472f-bc2c-f499f18264a3/code.html)

</details>         
<details open>
<summary><h3>1.3. Aesthetic tips</h3></summary>
Other aesthetic tips:

- In RStudio:
    - section headings to navigate the document
        
        > 💡 **ctrl-shift-r**       to create new sections
        
        > 💡 **shift-alt-j**         brings up document navigation
        
        
    - snippets
    ```r
    snippet title
      ##---------------------------------------------------------------------#
      ##
      ## Title:       ========================================================
      ##
      ## Purpose of script:
      ##
      ## Author: 
      ##
      ## Date Created: `r paste(Sys.Date())`
      ##
      ##---------------------------------------------------------------------#

      ## clear the R environment
      rm(list=ls()) 
      ## set working directory
      setwd("")

      #----------------------------------------------------------------------#
      # LOAD PACKAGES ========================================================
      #----------------------------------------------------------------------#

      #----------------------------------------------------------------------#
      # IMPORT DATA ==========================================================
      #----------------------------------------------------------------------#

    snippet header
      #----------------------------------------------------------------------#
      #             ==========================================================
      #----------------------------------------------------------------------#
    ```
</details>
</details>
<details open>
    <summary><h2>2. Functionality</h2></summary>

This depends on what you are trying to achieve with your code!

<details open>
    <summary><h3>2.1. Using functions</h3></summary>

One coding rule is that you should never duplicate code. If you use a piece of code more than once, this should be put into a function for repeat use. 

</details>
<details open>
    <summary><h3>2.2. Benchmarking</h3></summary>

[Mastering Software Development in R: Profiling and Benchmarking](https://bookdown.org/rdpeng/RProgDA/profiling-and-benchmarking.html)

To increase the functionality of your code, you can use the package `microbenchmark`. Install with CRAN:
    
```r
install.packages("microbenchmark")    
library(microbenchmark)
```    

</details>
<details open>
    <summary><h3>2.3. Profiling</h3></summary>

Now that you know the speed of your script, you’ll likely want to know which elements of your script are causing the bottlenecks and therefore where to focus your optimisation.

The package `profvis`is useful for this. To profile code with `profvis`, just input the code into `profvis()` , using braces if it is multi-line (you need to take it out of the function if it is in one).
    
```r
install.packages("profvis")
library(profvis)

profvis({ your
    code
    here
})
```
Once run in Rstudio, this will open a separate pane titled 'Profile 1' which looks something like below and will give you details about which parts of your script are taking the longest to run.    
</details>
</details>

:running: Activity

Now you can implement some of these additions.    
   
## Additional resources
[Why is R Slow?](http://adv-r.had.co.nz/Performance.html#language-performance)
