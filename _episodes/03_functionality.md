---
layout: page
title: Focus on the Functionality
order: 4
session: 1
length: 20
toc: true
---


## 2. Functionality

Are you aiming to make your code run faster? Be more efficient? Do you feel that you have some idea of what this may look like, but are unsure of exactly how to implement these structures? Implementing changes to the functionality of your scripting can be as simple or as complicated as it gets. Ultimately though, even simple changes implemented throughout your code will make a big difference to the speed of your scripts overall and their reproducibility. 
    
Functionality refers to not only how efficiently a script runs, but also how efficiently it is written and how robust it is. It is likely that your idea of 'good' code involves using functions and ensuring that you are using control structures like `if` statements in the most effective way. We will cover a few things within improving the functionality.
    
Further reading: [Mastering Software Development in R: Profiling and Benchmarking](https://bookdown.org/rdpeng/RProgDA/profiling-and-benchmarking.html)

----

### 2.1. Benchmarking
Let's start with how fast your script runs. Multiple packages exist to benchmark the speed of R code. You can do this using `Sys.time()` as we did in the initial speed test, or to look more closely at your functions, you can use the package `microbenchmark`:
    
```r
install.packages("microbenchmark")    
library(microbenchmark)
```    

The `microbenchmark` function is particularly useful for comparing functions that take the same inputs and return the same outputs. For example, you may have heard the classic R advice which is to use the `apply` family of functions instead of a `for` loop. However, in some cases it can be quicker to run a for loop. Let's test this using the earlier demo script, this time `demo_2.R`.     
    
First check that your two functions make the same object with `identical()`, then run `microbenchmark`. You can add edit the `times = ` parameter to change how many iterations of your function are run, the default is 100.

<details>
    <summary>Output</summary> 
    
As you can see microbenchmark provides a number of summary statistics; `min`, `lq`, `mean`, `median`, `uq`, and `max`. What do you conclude from this? Which of the two functions is faster? 
    
</details>

-----

### 2.2. Profiling

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

RStudio also has `profvis` built in. You can go to *Profile > Start profiling* in the top bar.  
    
<center><img src="https://rstudioblog.files.wordpress.com/2016/05/profile.png" width="400"></center>

    
We will implement this with the previous script, `demo_3.R`:


<details>
    <summary>Output</summary>   
    
The profiler gives you two tabs to look at. The data view provides a top-down tabular view of the profile. In the flame graph, the horizontal direction represents time in milliseconds, and the vertical direction represents the call stack. You'll see that the flame graph shows you different length bars underneath 'Memory' and 'Time'. The former illustrates how much memory allocation this step of your script is using, while the latter gives an indication of which parts of the script take the longest to run. In the demo script, by far the largest time and memory allocation is going to the apply step calculating the column means of the data. Therefore this is where we want to focus our attention.
    
</details>

Now that we know where the issue is, different methods for achieving this step can also be profiled with `profvis` demonstrating the quickest method. An obvious alternative is to use the `colMeans` function. But there’s also another possibility. Data frames are implemented as lists of vectors, where each column is one vector, so we could use lapply or vapply to apply the mean function over each column. Let’s compare the speed of these four different ways of getting column means with `demo_4.R`.


<details>
    <summary>Output</summary>  

Which command is the fastest? Are you surprised? `colMeans` is about 6x faster than using apply with mean, but it's still using `as.matrix`, which takes a significant amount of time. `lapply/vapply` are faster yet – about 10x faster than apply. As the desired form is a numeric vector, which is the best option to go for?
    
</details>

----

### 2.3. Spaghetti code and code smells

Materials adapted from the [Good Code Handbook](https://goodresearch.dev/decoupled.html).

A code smell is a problem with the code that indicates there might be some larger underlying issue, for example:
- **Duplicated code.** Large portions of duplicated code with small tweaks
- **Large functions.** Big, unwieldy functions that do a little bit of everything
- **High cyclomatic complexity.** Lots of nested ifs and for loops
- **Embedded configuration.** Paths and filenames are hardcoded 

From this we can conclude that a better way to code is to: 

- **Never duplicate.** If you use a piece of code more than once, put into a function for repeat use. 
- **Write simple functions.** Each function should do one task only. i.e. if your function reads an input, does a few different calculations, plots a graph and writes to a table, how can you rewrite this to two or even three functions? Otherwise this is going to reduce the useability of that function in other circumstances, as well as add more complexity to your code.
- **Avoid writing for loop inside for loop inside for loop.** Use functions or the apply family if you have to do more than one iteration inside an iteration. 
- **Use config files.** Though we won't go into this too much today, having a separate file that you call with file paths specific to your computer aids in the portability of your code. Say you have your own config file with the variable `dataDir`. This may be `dataDir <- "/home/data/"` in your config, but `dataDir <- "home/phdProject/mainDataSource/"` in someone else's. By calling `source("./config.r")` in the R script, as long as that path is correct, you now have no embedded filepaths and the script can be shared between colleagues who are storing the data in separate places.

When code has a lot of code smells, it can become so fragile that it is difficult or impossible to change. Such code is often deemed spaghetti code, code so tightly wound that when you pull on one strand, the entire thing unravels. To be clear, the problem with spaghetti code is not that it doesn’t work, it's that it is inscrutable and unrobust.

-----
    
## 🏃‍♀️ Activities

- [ ] Have a look now at your own script. How fast does it run? Which parts of the code are the slowest? Can you make any changes to reduce the bottleneck? 
- [ ] Do you use a for loop in your script? An apply function? Write as the opposite and test with `microbenchmark`. Which is the fastest way of iterating through your data?
- [ ] Exchange scripts with the person next to you and see if you can 'smell' any issues with their code.  
- [ ] Rerun the test script `testSpeed_2.R` to see how these changes have affected the speed of your script

-----
