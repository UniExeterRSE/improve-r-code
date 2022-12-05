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

For example, you may have heard the classic R advice which is to use the `apply` family of functions instead of a `for` loop. However, in some cases it can be quicker to run a for loop. Let's test this using the earlier demo script, this time `demo_2.R`.     
    
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

    
We will implement this with the previous script, `demo_3.R`:
     
Now that we know where the issue is, different methods for achieving this step can also be profiled with `profvis` demonstrating the quickest method. 

</details>
</details>

-----
    
## :running: Activities

- [ ] Implement these edits to develop your own script
- [ ] Rerun the test scripts `testStyle_2.R` and `testSpeed_2.R` to see how these changes have improved the speed or style of your script
- [ ] Exchange scripts with someone sat nearby to review the readability and organisation of your script

-----
