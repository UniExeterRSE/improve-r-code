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

- implement general good coding practices for readibility and functionality
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
The following script will run a static code analysis to check the readability and stylistic elements of your script (first change the variable `infile` to the path to your script). 
<linter and speed tests>

    
<details>
    <summary><code>workshopTest.R</code></summary>

```r
##---------------------------------------------------------------------#
## Title: Linter test =================================================
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

## check names of things to check
names(lintr::linters_with_defaults())


## using a linter to check style adherence
linter<-lint(infile, 
     linters = linters_with_defaults(object_name_linter('camelCase')))
linter
cbind(filename=infile, styleTest=length(linter))
```
    
</details>
<details open>
    <summary><h2>1. Aesthetics</h2></summary>

<details open>
    <summary><h3>1.1. Linters</h3></summary>

Naming conventions and grammatical structure in your code all aid in readability and reproducibility of code. There are tools known as linters which provide a static code analysis, checking for syntax errors, sematic issues and adherence to particular style. 

The package `lintr` applies this static code analysis in R. By default, it follows the tidyverse style guide but can be configured to report whichever style you might want to use. To try this out, you can simply run: 

`install.packages("lintr")`

`library(lintr)`

`lint("<file-name.R>")`

To configure this, perhaps you want to change the default naming convention to camelCase:

`lint("<file-name.R>", linters = linters_with_defaults(object_name_linter("camelCase"))`

You can then address each point from the console output, or alternatively you may use the `styler` package which will reformat the syntax and grammar of your code according to the same defaults as `lintr`. *Though be careful! - this will overwrite the original file.* 

> 💡 **ctrl-shift-a**        automatically format highlighted code with spaces

  
</details>         
<details open>
<summary><h3>1.2. Code order</h3></summary>

There are also standard practices for code organisation. These will make your code more easily accessible - both for others using your code and your future self - and also more easily editable. Main aspects to follow:

1. call your libraries on top of code
2. set all default variables or global options and all the path variables at the top of the code.
3. source all the code at the beginning
4. load all the data-files at the top

See here: [Chapter 3 Code Structure | Best Coding Practices for R (bookdown.org)](https://bookdown.org/content/d1e53ac9-28ce-472f-bc2c-f499f18264a3/code.html)

Other aesthetic tips:

- In RStudio:
    - section headings to navigate the document
        
        > 💡 **ctrl-shift-r**       to create new sections
        
        > 💡 **shift-alt-j**         brings up document navigation
        
        
    - snippets
    ~~~
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
    ~~~
</details>
</details>
<details open>
<summary>
     
## 2. Functionality</summary>

This depends on what you are trying to achieve with your code!

<details open>
<summary>
    
### 2.1. Using functions</summary>

One coding rule is that you should never duplicate code. If you use a piece of code more than once, this should be put into a function for repeat use. 

</details>
<details open>
<summary>
    
### 2.2. Benchmarking</summary>

[https://bookdown.org/rdpeng/RProgDA/profiling-and-benchmarking.html](https://bookdown.org/rdpeng/RProgDA/profiling-and-benchmarking.html)

To increase the functionality of your code, you can use the package microbenchmark

</details>
<details open>
<summary>
    
### 2.3. Profiling</summary>

Now that you know the speed of your script, you’ll likely want to know which elements of your script are causing the bottlenecks and therefore where to focus your optimisation.

The package `profvis`is useful for this. To profile code with `profvis`, just input the code into `profvis()` , using braces if it is multi-line (you need to take it out of the function if it is in one).
</details>
</details>
    
## Additional resources
[Why is R Slow?](http://adv-r.had.co.nz/Performance.html#language-performance)
