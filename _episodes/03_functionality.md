---
layout: page
title: Focus on the Functionality
order: 4
session: 1
length: 20
toc: true
---


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