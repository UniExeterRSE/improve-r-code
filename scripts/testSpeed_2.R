start_time <- Sys.time()

<your-script-here>    

end_time <- Sys.time()

# combine with previous results
res <- read.table("scriptTest.txt", header = TRUE) 
res[nrow(res), 3] <- end_time - start_time

write.table("scriptTest.txt", sep = '\t', row.names = FALSE, quote = FALSE)    
