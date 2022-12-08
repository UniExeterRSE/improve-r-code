---
layout: page
title: Focus on the Functionality
order: 4
session: 1
length: 20
toc: true
---


## Functionality

Are you aiming to make your code run faster? Be more efficient? Do you feel that you have some idea of what this may look like, but are unsure of exactly how to implement these structures? Implementing changes to the functionality of your scripting can be as simple or as complicated as it gets. Ultimately though, even simple changes implemented throughout your code will make a big difference to the speed of your scripts overall and their reproducibility. 
    
Functionality refers to not only how efficiently a script runs, but also how efficiently it is written and how robust it is. It is likely that your idea of 'good' code involves using functions and ensuring that you are using control structures like `if` statements in the most effective way. We will cover a few things within improving the functionality.
    
Further reading: [Mastering Software Development in R: Profiling and Benchmarking](https://bookdown.org/rdpeng/RProgDA/profiling-and-benchmarking.html)

----

### Benchmarking
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

### Profiling

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

### Spaghetti code and code smells

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

### Defining functions

The utility of a function is that it will perform its given action on whatever value is passed to the named argument(s). It means we can repeat the same operations with a single command.

Let's start by defining a function `fahr_to_kelvin` that converts temperatures from Fahrenheit to Kelvin:

```r
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
```

We define `fahr_to_kelvin` by assigning it to the output of `function`.
The list of argument names are contained within parentheses.
Next, the body of the function--the statements that are executed when it runs--is contained within curly braces (`{}`).
The statements in the body are indented by two spaces, which makes the code easier to read but does not affect how the code operates.

When we call the function, the values we pass to it are assigned to those variables so that we can use them inside the function.
Inside the function, we use a return statement to send a result back to whoever asked for it.

In R, it is not necessary to include the return statement.
R automatically returns whichever variable is on the last line of the body
of the function. 

Calling our own function is no different from calling any other function:

```r
# freezing point of water
fahr_to_kelvin(32)
# boiling point of water
fahr_to_kelvin(212)
```
Now that we've seen how to turn Fahrenheit into Kelvin, it's easy to turn Kelvin into Celsius:

```r
kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}

#absolute zero in Celsius
kelvin_to_celsius(0)
```

What about converting Fahrenheit to Celsius?
We could write out the formula, but we don't need to.
Instead, we can compose the two functions we have already created:

```r
fahr_to_celsius <- function(temp) {
  temp_k <- fahr_to_kelvin(temp)
  result <- kelvin_to_celsius(temp_k)
  return(result)
}

# freezing point of water in Celsius
fahr_to_celsius(32.0)
```
This is a taste of how larger programs are built: we define basic
operations, then combine them in ever-larger chunks to get the effect we want.
Real-life functions will usually be larger than the ones shown here--typically half a dozen to a few dozen lines--but they shouldn't ever be much longer than that, or the next person who reads it won't be able to understand what's going on.

## Running your script under different scenarioes

Sometimes you may have a task that you want to repeat with subtle changes. We ar probably already aware that we can use variables at the top of our script to define, elements we want to modify. This can make it easy to rerun essentially the same code either with a different input file or with different parameters. However, how do you document this process? You want to keep the script with the exact parameters you ran. Also when you reuse the script in the future do you make a copy of it?  or over write it? What if yuo have multiple copies of the same script, just with different input conditions and you want to edit it, which version do you edit? How do know that you've remembered to edit all version of it. 

In these situations we want to start thinking of our code as a piece of software or a programme which will do a given thing with provided inputs. To make this happen we need to be able to easily maintain a single version of the code and provide it with different values for the parameters when we run it. There are a couple of ways of approaching this task.

* config files. Your R software takes advantage of a second R script, where the variables are defined. This is a very simple script, which essentially only includes assignment commands. Instead of having these at the top of your usual script, you put them in the config file. You then load the parameters via `source ` at the top of the script. From a maintanence point of view you then have a single script to do the compute, but you have multiple config files. 

* specify on the command line. You may be used to using command line software (or even UNIX) where you provide the parameters as you execute the script. For example the UNIX `ls` command can be run with a provided filepath and then lists the files from that directory. In this way you can use a single command to list the contents of any directory on the system. It is an optional parameter, as it has a default value (the current directory) which it uses if you don't provide a file path.

```
ls /usrs/home/ejh243
```
R scriptscan be run from the command line. (In fact we would argue that the final execution should be done this way as coping and pasting into the console is liable to problems). For example if you had an Rscript called `runAnalysis.r`, you could execute it as follows

```
Rscript runAnalysis.r
```

This is how you might need to do it if you were using a HPC system with a scheduler where you submit your scripts via shell scripts. 

In this way your script starts to function more like a programme, and you can provide parameters or arguments on the command line by add them after the script name. For example

```
Rscript runAnalysis.r /path/to/inputfile
```
You then need to add a few commands to `runAnalysis.r` so R knows where to find the values of the parameters.

```
args = commandArgs(trailingOnly=TRUE) # creates a variable of all the provided arguments

inputFile = args[1] # takes the first argument at stores it in a more meaningful variable name.
```

You can use this approach to have as many arguments as you need. The only limitation of this method is you need to specify the arguments in the correct order, otherwise they will get assigned to the wrong variable. You also need to thing about how the programme would work if they were not provided at execution. For example you might need something like

```
args = commandArgs(trailingOnly=TRUE) # creates a variable of all the provided arguments

if(!is.null(args[1])){
  inputFile = args[1] # takes the first argument at stores it in a more meaningful variable name.
} else {
  inputFile = "<insert default>"
}
```

If you want more flexibility, in the order you provide the arguments and a pre scpeficied framework for providing defaults take a look at the [optparse](https://cran.r-project.org/web/packages/optparse/) package which uses flags (e.g. "-p" ) to aid the configuration of a script on the command line.

----
    
## 🏃‍♀️ Activities

- [ ] Have a look now at your own script. How fast does it run? Which parts of the code are the slowest? Can you make any changes to reduce the bottleneck? 
- [ ] Do you use a for loop in your script? An apply function? Write as the opposite and test with `microbenchmark`. Which is the fastest way of iterating through your data?
- [ ] Exchange scripts with the person next to you and see if you can 'smell' any issues with their code.  
- [ ] Rerun the test script `testSpeed_2.R` to see how these changes have affected the speed of your script

-----
