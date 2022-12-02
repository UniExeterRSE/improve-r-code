---
layout: page
title: Focus on the Asthetics
order: 3
session: 1
length: 20
toc: true
---


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