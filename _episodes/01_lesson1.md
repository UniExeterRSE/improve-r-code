---
layout: page
title: Improve your own R code
order: 2
session: 1
length: 20
toc: true
---

## Why do you want to improve your code?

Discussion activity: 
- Why are you here today? 
- What is it about your code that you think needs improving?
- If you know what you need to do, why have you yet to implement it?
- Why is it important that your code looks good?

"Improve" is a vague concept and it is likely that you have all interepted it differently. There are a number of reasons/way you might want to "improve" your script. Of course it is highly possible that you want to achieve all of these.

1) Are you aiming to make your code more readable/user friendly? Or look more "professional"? Maybe you want to share your script, either internallly or publically, and you think it's messy, hard to follow, or unconventional in it's structure. Perhaps you are interested in looking out for your future self and editting your script so you can understand it in the future.  

2) You think your script is inefficient. Maybe you need to speed up parts of your analysis to decrease the overall run time and identify which functions are 
slowing down your script? Or the code is overly repeatative/verbose, there are unnesseecary steps and could be condensed to improve usability.

3) You want to generalise your code such that it can be reused in another analysis/project, either in it's entirity or components of it. 

4) You are concerned that there might be an error in your code, such that it doesn't do what it should. Or perhaps there is an error in the method you have choosen.   

These reasons can be grouped into two main concepts; aesthetics and functionality. 
Everyone here might have different reasons for attending this class today, we will cover all of these, and it is up to you which you choose to focus on and incorporate into your coding today. 

    
## First, a test of your script...

Hopefully you have brought along a script which you want to improve. 

First, we are going  assess the readability and stylistic elements of your script. For this you will need the `styleTest.R` script. 
To get this script to run a static code analysis of the script you have brought you need to first change the variable `infile` to the path to your script. 


## ADD SOME INTERPRETATION

The second profiling script needs to be copied into your script and will calculate the speed of your script and the functions within it. 


~~~r
library(magrittr)
    
start_time <- Sys.time()
              
<your-script-here>    
    
end_time <- Sys.time()

# combine previous stylistic test results with speed
res <- read.table("scriptTest.txt", header = TRUE) %>%
  cbind(speedTest = end_time - start_time)

# write results to file
write.table(res, "scriptTest.txt", sep = '\t', row.names = FALSE, quote = FALSE)
~~~

<details open>
    <summary><h2>1. Aesthetics</h2></summary>

<details open>
    <summary><h3>1.1. Linters</h3></summary>

Naming conventions and grammatical structure in your code all aid the readability and reproducibility of your code. There are tools known as linters which provide static code analysis, checking for syntax errors, sematic issues and adherence to particular coding style. 

The package `lintr` applies this static code analysis in R. By default, it follows the tidyverse style guide but can be configured to report whichever style you might want to use. To try this out, you can simply run: 

~~~
install.packages("lintr")
library(lintr)`
lint("<file-name.R>")
~~~

To configure this, perhaps you want to change the default naming convention to camelCase:

`lint("<file-name.R>", linters = linters_with_defaults(object_name_linter("camelCase"))`

You can then address each point from the console output, or alternatively you may use the `styler` package which will reformat the syntax and grammar of your code according to the same defaults as `lintr`. *Though be careful! - this will overwrite the original file.* 

> 💡 **ctrl-shift-a**        automatically format highlighted code with spaces

We will demonstrate with the below script which creates a dataframe, adds an ID column, calculates the mean of each column and then subtracts the mean from each value. Don't worry about coding along as you will get a chance to implement this with your script at the end.

<details>
    <summary><code>demo.R</code></summary>
    
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

This depends on what you are trying to achieve with your code! We will cover a few things within improving the functionality, including using functions and speeding up 
your script.
    
Further reading: [Mastering Software Development in R: Profiling and Benchmarking](https://bookdown.org/rdpeng/RProgDA/profiling-and-benchmarking.html)

<details open>
    <summary><h3>2.1. Using functions</h3></summary>

One coding rule is that you should never duplicate code. If you use a piece of code more than once, this should be put into a function for repeat use. 

</details>
<details open>
    <summary><h3>2.2. Benchmarking</h3></summary>

Multiple packages exist to benchmark the speed of R code. You can do this using `Sys.time()` as we did in the initial speed test, or to look more closely at your fucntions, you can use the package `microbenchmark`:
    
```r
install.packages("microbenchmark")    
library(microbenchmark)
```    

For example, you may have heard the classic R advice which is to use the `apply` family of functions instead of a `for` loop. However, in some cases it can be quicker to run a for loop. Let's test this using the earlier script:
    
<details>
    <summary><code>demo.R</code></summary>
    
```r
if (!require("microbenchmark", quietly = TRUE))
  install.packages("microbenchmark")
library(microbenchmark)

times <- 400000
cols <- 100
data <- as.data.frame(matrix(rnorm(times * cols, mean = 5),
                             ncol = cols))
data <- cbind(id = paste0("E", seq_len(times)), data)


## store in new variable
newData <- data

for_family <- function(data) {
  means <- apply(data[, names(data) != "id"], 2, mean)
  
  ## minus mean from each column
  for (i in seq_along(means)) {
    data[, names(data) != "id"][, i] <-
      data[, names(data) != "id"][, i] - means[i]
  }
  return(data)
}

apply_family <- function(data) {
  newData <- apply(data[, 2:ncol(data)], 2, function(x) {
    x - mean(x)
  })
  data <- cbind.data.frame(id = data[, 1], newData)
  return(data)
}

identical(apply_family(newData), for_family(newData))

microbenchmark(apply_family(newData), for_family(newData), times = 10)
```

</details>          
    
First check that your two functions make the same object with `identical()`, then run `microbenchmark`. You can add edit the `times = ` parameter, the default is 100.
    
</details>
<details open>
    <summary><h3>2.3. Profiling</h3></summary>

Now that you know the speed of your script, you’ll likely want to know which elements of your script are causing the bottlenecks and therefore where to focus your optimisation.

The package `profvis` is useful for this. To profile code with `profvis`, just input the code into `profvis()`, using braces if it is multi-line (you need to take it out of the function if it is in one).
    
```r
install.packages("profvis")
library(profvis)

profvis({ your
    code
    here
})
```
Once run in RStudio, this will open a separate pane titled 'Profile 1' which looks something like below and will give you details about which parts of your script are taking the longest to run.   
    
<center><img src="https://rstudioblog.files.wordpress.com/2016/05/profile.png" width="400"></center>

    
We will implement this with the previous script:
    
<details>
    <summary><code>demo.R</code></summary>
    
```r
if (!require("profvis", quietly = TRUE))
  install.packages("profvis")
library(profvis)

times <- 400000
cols <- 100
data <- as.data.frame(matrix(rnorm(times * cols, mean = 5),
                             ncol = cols))
data <- cbind(id = paste0("E", seq_len(times)), data)

profvis({
  ## store in new variable
  newData <- data
 
  ## column means
  means <- apply(newData[, names(newData)!="id"], 2, mean)
  
  ## minus mean from each column
  for (i in seq_along(means)) {
    newData[, names(newData) != "id"][,i] <- newData[,names(newData) != "id"][, i] - means[i]
  }
})
```
</details>
    
Now that we know where the issue is, different methods for achieving this step can also be profiled with `profvis` demonstrating the quickest method. 

<details>
    <summary><code>demo.R</code></summary>
    
```r
profvis({
  newData<- data
  # Four different ways of getting column means
  means <- apply(newData[, names(newData) != "id"], 2, mean)
  means <- colMeans(newData[, names(newData) != "id"])
  means <- lapply(newData[, names(newData) != "id"], mean)
  means <- vapply(newData[, names(newData) != "id"], mean, numeric(1))
})
```
</details>

</details>
</details>

-----
    
## :running: Activities

- [ ] Implement these edits to develop your own script
- [ ] Rerun the below script to see how these changes have improved the speed or style of your script
        <details>
        <summary><code>styleTest.R</code></summary>
    
        ## read in and write back to test file
        res <- read.table("scriptTest.txt", header = TRUE) %>%
                      rbind(c(.[1,1], length(lint(infile)), '')) %>%
                      write.table("scriptTest.txt", sep = '\t', row.names = FALSE, quote = FALSE)          
        
    </details>
        <details>
        <summary><code>speedTest.R</code></summary>
    
        start_time <- Sys.time()

        <your-script-here>    

        end_time <- Sys.time()

        # combine with previous results
        res <- read.table("scriptTest.txt", header = TRUE) 
        res[nrow(res), 3] <- end_time - start_time

        write.table("scriptTest.txt", sep = '\t', row.names = FALSE, quote = FALSE)    
        
    </details>
- [ ] Exchange scripts with someone sat nearby to review the readability and organisation of your script

-----
    
## Additional resources
[Why is R Slow?](http://adv-r.had.co.nz/Performance.html#language-performance)
    
Materials developed from: [Profiling R code with the RStudio IDE](https://support.posit.co/hc/en-us/articles/218221837-Profiling-with-RStudio)
