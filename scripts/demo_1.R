if (!require("lintr", quietly = TRUE))
  install.packages("lintr")
library(lintr)

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

lint("demo_1.R")
