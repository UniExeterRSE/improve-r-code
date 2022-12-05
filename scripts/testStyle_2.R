## read in and write back to test file
res <- read.table("scriptTest.txt", header = TRUE) %>%
              rbind(c(.[1,1], length(lint(infile)), '')) %>%
              write.table("scriptTest.txt", sep = '\t', row.names = FALSE, quote = FALSE)          
