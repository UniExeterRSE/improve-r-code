---
layout: page
title: Improve your own R code
order: 2
session: 1
length: 30
toc: true
---

## Why do you want to improve your code?

🏃‍♀️ **Activity: Why are you here today?** 

In small groups/Slido discuss the points below. Think about all your codes not just the one you have brought with you today. 

- What is it about your code that you think needs improving?
- If you know what you need to do, why have you yet to implement it?
- Why is it important that your code looks good?

## What does 'improving' your code mean?
 
"Improve" is a vague concept and it is likely that you have all interpreted it differently. There are a number of reasons or ways you might want to "improve" your script. Of course it is highly possible that you want to achieve all of these.
+ Are you aiming to make your code more readable/user friendly? Or look more "professional"? Maybe you want to share your script, either internally or publicly, and you think it's messy, hard to follow, or unconventional in it's structure. Perhaps you are interested in looking out for your future self and editting your script so you can understand it in the future.  
+ You think your script is inefficient. Maybe you need to speed up parts of your analysis to decrease the overall run time. So you want to identify where the bottlenecks are? Or the code is overly repetative/verbose, there are unnecessary steps and could be condensed to improve usability. Maybe you are actually concerned about the memory demands rather than speed.
+ You want to generalise your code such that it can be reused in another analysis/project, either in it's entirity or components of it. 
+ You are concerned that there might be an error in your code, such that it doesn't do what it should. Or perhaps there is an error in the method you have chosen.

For the purpose of this session we have grouped these reasons into two main concepts; aesthetics and functionality. Arguably many improvements affect both of these.

Everyone here might have different reasons for attending this class today, we will touch on all of these, and it is up to you which you choose to focus on and incorporate into your coding today. 


## Profile your script

Hopefully you have brought along a script which you want to improve. 

First, we are going to assess the readability and stylistic elements of your script. For this you will need the `testStyle_1.R` script (located in [resources](https://uniexeterrse.github.io/improve-r-code/resources.html)). This script requires the R package [lintr](https://lintr.r-lib.org/) which is available on CRAN.

To get this script to run a static code analysis of the script you have brought, you need to first change the variable `infile` to the path to your script. 

Next, we are going to assess the speed of your script. To run this you need to copy the content of `testSpeed_1.R` into your script (also shown below). This script requires the R package [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html). This will enable you to calculate the speed of your script and the functions within it. Note the style test needs to be run before the speed test, as they script also combines the output.

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

<details>
    <summary><b>Output</b></summary>
    
These test scripts have run a few different profiling tools on your script. For the moment, the only output is a text file called `scriptTest.txt` which contains metrics for how well your script conforms to a standard coding style, and how fast it runs. We will be discussing these profiling tools in greater detail and will check back to these metrics at the end to compare how these differ pre- and post-improvement.
    
</details>
