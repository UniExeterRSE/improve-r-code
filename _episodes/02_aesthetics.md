---
layout: page
title: Attention on the Aesthetics
order: 3
session: 1
length: 20
toc: true
---


## Aesthetics

Have you ever opened a script and your eyebrows have furrowed as to work out what it does and how? Alternatively have you ever looked a script and found yourself wishing you could write something so succinct and elegant? The computer largely doesn't care how code is presented, it works it's way through from top to bottom. However, the way the code looks and is structured on the page helps a fellow programmer read it, understand what the purpose of your code is and follow how the problem is tackled. 

🏃‍♀️ **Activity: the concept of "good" code.** 

>Good and bad are subjective concepts. When we look at a new piece of code we probably make an internal judgement on whether it is good or bad based solely on how it looks in a text editor. Can you reflect in small groups, what specific characteristics/features you use to make this judgement. Focus purely on how it looks on the page.

The concepts of aethetics and functionality are not completely distinct - a well organised code is likely to function more efficiently as it highlights redundancy. By aesthetics we refer to elements that aid both the writing and human-readability. While you primarily write code to issue instructions to a computer, your code is likely to need to be read by humans as well, including yourself. Highly functional code is not always the easiest to navigate. Often there is a trade off between succinct code perhaps highly efficient code and something that looks more logical/readable to the human eye. It is worth baring in mind the target audience of your code and the overall purpose. The balance of efficiency vs user-friendliness.  

Improving how code looks on the age are changes we can make without too much effort or requiring new knowledge of how computer programming works. You could argue that you have sold yourself short, if your code is unreadable by someone else. Essentially it is about consistency and establishing some standards for our own personal work that we adhere to and thus make it easier for someone else to navigate our scripts and know where to look for different components or layers of information.  

-----

### Coding style

Ever wondered how large coding projects make their code base look the same despite a large number of developers and contributers. Most large, collaborative coding projects have a defined coding style guide that all developers adhere to. This set of standards ensures the code looks the same and gives it a form of identity and sense of familiarity. From a personal point of view, it also saves your mental energy from making lots of micro-decisions about things like variable names and how many spaces to put after a curly brace. Ultimately this makes the project look more considered and professional, likely giving the user confidence in it's functionality. 

A number of different coding styles have been developed, and arguably each programming language has laid some foundations for the basis of a coding style for that language. Often they focus on:

- filenames
- variable names
- function names
- spacing & indentation
- how to set out brackets

You can see publicly available examples from [Google](https://web.stanford.edu/class/cs109l/unrestricted/resources/google-style.html), [Hadley Wickham](http://adv-r.had.co.nz/Style.html), and [AWS](https://rstudio-pubs-static.s3.amazonaws.com/390511_286f47c578694d3dbd35b6a71f3af4d6.html). 

One benefit of having a set of rules for formatting your code is that you can develop tools, to check that a script conforms to the standards. These tools known as linters, and assess every line of your script for adherence to particular coding style, syntax errors and sematic issues. The package `lintr` applies this static code analysis in R. By default, it follows the [tidyverse style guide](https://style.tidyverse.org/) but can be configured to report whichever style you might want to use. To try this out, you can simply run: 

~~~
install.packages("lintr")
library(lintr)`
lint("<file-name.R>")
~~~

As well as check against the tidyverse style guide, you can configure this linter to check for other common elements of style guides. For example, perhaps you want to change the default naming convention to camelCase:

`lint("<file-name.R>", linters = linters_with_defaults(object_name_linter("camelCase"))`

You can then address each point from the console output, or alternatively you may use the `styler` package which will reformat the syntax and grammar of your code according to the same defaults as `lintr`. *Though be careful! - this will overwrite the original file.* 

> 💡 **ctrl-shift-a**        automatically format highlighted code with spaces

We will demonstrate with a script, `demo_1.R` (in [resources](https://uniexeterrse.github.io/improve-r-code/resources.html)), which creates a dataframe, adds an ID column, calculates the mean of each column and then subtracts the mean from each value. Don't worry about coding along as you will get a chance to implement this with your script at the end.

-----

### Code Organisation

There are also standard practices for code organisation. These will make your code easier to navigate - both for others using your code, your future self and your current self as your edit and develop your script. 

One general principal is to group together bits of code with the same purpose, for example load all your libaries in the same part of the script. A second guiding principle, is to locate at the start of the script (where it is easy to find) anything that you might want to change/edit.

More specifically your script should start with the following elemets:

1. load the necessary libraries
2. set all default variables & global options & path variables
3. source any other scripts
4. load all data-files

Further details on this can be found in [Best Coding Practices for R](https://bookdown.org/content/d1e53ac9-28ce-472f-bc2c-f499f18264a3/code.html). 

You then get into the mechanics of your code, which depending on the length may benefit from future sub-structuring. 

If you are working in RStudio, there are a few extra elements you can include to make the document more readable and easier to navigate. Note that ieven if you edit your R scripts in a different editor, there is nothing to stop you adding these in manually.   

- section headings to navigate the document
        
> 💡 **ctrl-shift-r**       to create new sections
        
> 💡 **shift-alt-j**         brings up document navigation
        
        
- snippets

In RStudio, go to *Tools > Global Options > Code > Edit snippets*, enter the code below and save. Note that there should be a tab on every line after the first line. Now type `title` into a script, run and see what happens.

~~~r
snippet title
	##---------------------------------------------------------------------#
	##
	## Title:			 ========================================================
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

### Commenting

We all know we need to comment on code, but effective commenting requires some consideration. Too many comments mean they can swamp the code, making it hard to follow, risk becoming outdated and often are redundant. But too few comments leave gaps in the understanding. As I am sure you are quickly realising, none of this is indepedent - well organised code and adherence to a coding style where function and variable names are well-written and meaningful, should reduce the need for comments and in turn means your comments can be more purposeful. 

It can be helpful here to think about the purpose of comments. They are an aid to help you understand the code. They should not need to be an extended explanation of what the code is going to do. They shuold typically be used to answer why questions such as: why did you do it like that? or why did you choose that value? At there most valuable comments should be neat and concise and avoid repetition.

There are two types of comments

1. Inline comments. These are short comments, which you can drop into the code at any point. They should mainly be used to explain or clarify functionality at places where it is not obvious why you have chosen to do something a particular way. These should be used sparingly.

2. Block comments. This are longer (i.e. > 1 line) sections of comments, that might look more like a paragraph. They describe the purpose of the section of code and the algorithm behind it. They should accompany all functional elements (e.g. functions), and should be used to design or structure your script. It may be helpful to establish a standard format for how this are presented. 

Your goal should be that your code is self-documenting. By using meaningful variable/function/filenames you can remove the need for extra comments



🗣️ **Activity**    

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
