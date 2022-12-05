library(magrittr)
    
start_time <- Sys.time()
              
<your-script-here>    
    
end_time <- Sys.time()

# combine previous stylistic test results with speed
res <- read.table("scriptTest.txt", header = TRUE) %>%
  cbind(speedTest = end_time - start_time)

# write results to file
write.table(res, "scriptTest.txt", sep = '\t', row.names = FALSE, quote = FALSE)
