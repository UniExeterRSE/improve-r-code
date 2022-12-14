if (!require("profvis", quietly = TRUE))
  install.packages("profvis")
library(profvis)

times <- 400000
cols <- 100
data <- as.data.frame(matrix(rnorm(times * cols, mean = 5),
                             ncol = cols))
data <- cbind(id = paste0("E", seq_len(times)), data)

profvis({
  ## store in new variable
  newData <- data
 
  ## column means
  means <- apply(newData[, names(newData)!="id"], 2, mean)
  
  ## minus mean from each column
  for (i in seq_along(means)) {
    newData[, names(newData) != "id"][,i] <- newData[,names(newData) != "id"][, i] - means[i]
  }
})
