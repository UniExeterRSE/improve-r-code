profvis({
  newData<- data
  # Four different ways of getting column means
  means <- apply(newData[, names(newData) != "id"], 2, mean)
  means <- colMeans(newData[, names(newData) != "id"])
  means <- lapply(newData[, names(newData) != "id"], mean)
  means <- vapply(newData[, names(newData) != "id"], mean, numeric(1))
})
