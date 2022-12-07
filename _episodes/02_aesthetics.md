---
layout: page
title: Attention on the Aesthetics
order: 3
session: 1
length: 20
toc: true
---


## 1. Aesthetics

Have you ever opened a script and been overcome with a sense of dread at trying to work out what it does and how? Or have you ever looked a script and found it enticing. The computer largely doesn't care how it is presented, it works it's way through from top to bottom. However, the way the code looks and is structured on the page helps a fellow programmer understand what the purpose of your code is and follow how the problem is tackled. 

🏃‍♀️ **Activity: the concept of "good" code. Judging a book by it's cover** 

>Good and bad are subjective concepts. When we look at a new piece of code we probably make an internal judgement on whether it is good or bad based solely on how it is presented. Can you reflect in small groups, what specific characteristics you use to make this judgement. Focus purely on how it looks on the page.


While the concept of aethetics and functionality are not completely overlapping, a well organised code is likely to function more efficiently. By aesthetics we refer to elements that aid both the writing and human-readability. These are also elements that we should all be able to implement without too much effort or new knowledge of how computer programming works. Essentially it is about consistency and establishing some standards for our own personal work that we adhere to and thus make it easier for someone else to read our scripts and know where to look for various information.  

-----

### 1.1. Coding style

Ever wondered how large coding projects make their code base look the same despite a large number of developers and contributers. Most large, collaborative coding projects have defined coding style guides that all developers adhere to. This set of standards ensures the code looks the same and gives it a form of identity and sense of familiarity. It also saves your mental energy from making lots of micro-decisions about variable names and how many spaces to put after a curly brace. Ultimately this makes the project look more considered and professional, likely giving the user confidence in it's functionality. 

A number of different coding styles have been developed, and arguably each programming language has laid some foundations for the basis of a coding style for that language. Often they focus on:

- variable names
- function names
- spacing

There are tools known as linters which check for adherence to particular coding style, syntax errors and sematic issues. The package `lintr` applies this static code analysis in R. By default, it follows the [tidyverse style guide](https://style.tidyverse.org/) but can be configured to report whichever style you might want to use. To try this out, you can simply run: 

~~~
install.packages("lintr")
library(lintr)`
lint("<file-name.R>")
~~~

To configure this, perhaps you want to change the default naming convention to camelCase:

`lint("<file-name.R>", linters = linters_with_defaults(object_name_linter("camelCase"))`

You can then address each point from the console output, or alternatively you may use the `styler` package which will reformat the syntax and grammar of your code according to the same defaults as `lintr`. *Though be careful! - this will overwrite the original file.* 

> 💡 **ctrl-shift-a**        automatically format highlighted code with spaces

We will demonstrate with a script, `demo_1.R` (in [resources](https://uniexeterrse.github.io/improve-r-code/resources.html)), which creates a dataframe, adds an ID column, calculates the mean of each column and then subtracts the mean from each value. Don't worry about coding along as you will get a chance to implement this with your script at the end.

-----

### 1.2. Features of the code

There are also standard practices for code organisation. These will make your code more easily accessible - both for others using your code and your future self - and also more easily editable. Main aspects to follow:

1. call your libraries on top of code
2. set all default variables or global options and all the path variables at the top of the code.
3. source all the code at the beginning
4. load all the data-files at the top

See here: [Best Coding Practices for R](https://bookdown.org/content/d1e53ac9-28ce-472f-bc2c-f499f18264a3/code.html)

If you are working in RStudio, there are a few extra things you can include to make the document more readable and easier to navigate    

- section headings to navigate the document
        
> 💡 **ctrl-shift-r**       to create new sections
        
> 💡 **shift-alt-j**         brings up document navigation
        
        
- snippets

In RStudio, go to *Tools > Global Options > Code > Edit snippets*, enter the code below and save. Now type `title` into a script, run and see what happens.

~~~r
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
~~~

-----

### 1.5. Commenting

We all know we need to comment on code, but effective commenting requires some consideration. Too many comments mean it can be hard to see the code, risk becoming outdated and often are redundant. If your function and variable names are well-written, this can reduce the need for comments, but too few comments leave gaps in the understanding.

Think about the purpose of comments:

https://www.hongkiat.com/blog/source-code-comment-styling-tips/

🗣️ **Discussion**    

>Look at the code below and decide whether any of these lines of codes are over or under commented. Discuss with the person next to you and post on Slido what changes you would make to the code.

    
~~~r
## Calculate total proportion of marks in each chromosome
files <- list.files(compDir, pattern = 'chr\\d+_binary.+')
allChr <- NULL
## For loop reading in files to all chromosomes
for (each in files) {
  tmp <- read.delim(paste(compDir, each, sep = '/'), skip = 1)
  allChr <- rbind(allChr, tmp)
}
    
## Calculate proportions    
prop <- apply(allChr, 2, function(x){
  sum(x)/nrow(allChr)
  })

## Write proportion to table       
write.table(prop[1], file = paste0(compDir,'/', args[3], "/completeness.txt"), 
            sep = '\t', col.names = FALSE, 
            row.names = FALSE)    
~~~    
        

-----
    
## 🏃‍♀️ Activities

- [ ] Try running `lintr` on your own script and addressing the lines in the console. Do you need to configure the defaults in line with your own style?
- [ ] Exchange scripts with someone sat nearby to review the readability and organisation of your script
- [ ] Rerun the test script `testStyle_2.R` to see how these changes have improved the style of your script

-----
