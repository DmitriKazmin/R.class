setwd("/Users/jacob/Downloads/RClub/R.class-Lesson-5")
rm(list = ls())

library(pheatmap)

#1
genes <- data.frame(matrix(nrow = 10, ncol = 10))

genes[c(1:5), c(1:5)] <- rnorm(mean = 1, 1000)
genes[c(1:5), c(6:10)] <- rnorm(mean = -4, 100) 
genes[c(6:10), c(1:5)] <- rnorm(mean = 5, 350)
genes[c(6:10), c(6:10)] <- rnorm(mean = -2, 200) 

colnames(genes) <- paste("Sample.", seq(1:10), sep = "")
row.names(genes) <- paste("Gene.", seq(1:10), sep = "")

#2
ann.col <- data.frame("Treatment" = c(rep("Drug", 5), 
                                      rep("Control", 5)), 
                      "Time" = c(rep("1 hour", 2), 
                                 rep("2 hours", 3), 
                                 rep("10 hours", 3), 
                                 rep("10 seconds", 2)))
row.names(ann.col) <- colnames(genes)

ann.row <- data.frame("Pathway" = c(rep("Cell growth", 5), 
                                    rep("Cell death", 5)))
row.names(ann.row) <- row.names(genes)

#3
pheatmap(genes, 
         annotation_row = ann.row, 
         annotation_col = ann.col,
         main = "Genes more like jeans",
         display_numbers = TRUE)
