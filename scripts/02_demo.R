if (!require("microbenchmark", quietly = TRUE))
  install.packages("microbenchmark")
library(microbenchmark)

times <- 400000
cols <- 100
data <- as.data.frame(matrix(rnorm(times * cols, mean = 5),
                             ncol = cols))
data <- cbind(id = paste0("E", seq_len(times)), data)


## store in new variable
newData <- data

for_family <- function(data) {
  means <- apply(data[, names(data) != "id"], 2, mean)
  
  ## minus mean from each column
  for (i in seq_along(means)) {
    data[, names(data) != "id"][, i] <-
      data[, names(data) != "id"][, i] - means[i]
  }
  return(data)
}

apply_family <- function(data) {
  newData <- apply(data[, 2:ncol(data)], 2, function(x) {
    x - mean(x)
  })
  data <- cbind.data.frame(id = data[, 1], newData)
  return(data)
}

identical(apply_family(newData), for_family(newData))

microbenchmark(apply_family(newData), for_family(newData), times = 10)
