if (!require("lintr", quietly = TRUE))
    install.packages("lintr")

library(lintr)

# IMPORT DATA ===========================================================

## set variable files to check
infile <- "<path/to/your/script/here>"

## using a linter to check style adherence
linter<-lint(infile) 
linter
res <- cbind(filename=infile, styleTest=length(linter))

# write results to file
write.table(res, "scriptTest.txt", sep = '\t', row.names = FALSE, quote = FALSE)
