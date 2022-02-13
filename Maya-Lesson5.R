# Create a fake gene expression dataset similar to the one used in the lesson
# Create annotation data frames with as many levels of annotation as you wish
# Create a heatmap of your dataset with row and column annotations. 
geneset <- data.frame(matrix(nrow = 50, ncol = 20))

geneset[c(1:25), c(1:5)] <- rnorm(mean = -2, 125)
geneset[c(26:50), c(1:5)] <- rnorm(mean = -3, 125) 
geneset[c(1:25), c(6:10)] <- rnorm(mean = -5, 125)
geneset[c(26:50), c(6:10)] <- rnorm(mean = -8, 125)

geneset[c(1:25), c(11:15)] <- rnorm(mean = 9, 125)
geneset[c(26:50), c(11:15)] <- rnorm(mean = 8, 125) 
geneset[c(1:25), c(16:20)] <- rnorm(mean = 7, 125)
geneset[c(26:50), c(16:20)] <- rnorm(mean = 6, 125)

colnames(geneset) <-  paste("M.Drug", seq(1:10), sep = "")
colnames(geneset)[11:20] <-  paste("F.Drug", seq(1:10), sep = "")
row.names(geneset) <- paste("Gene", seq(1:50), sep = "")

ann.col <- data.frame(
  "Parent" = c(rep("Mother", 10), rep("Father", 10)), 
  "DrugType" = rep(c(rep("Boring", 5), rep("Happy", 5)), 2)) 
  
row.names(ann.col) <- colnames(geneset)

ann.row <- data.frame("Dominance" = c(rep("Dominant", 25), 
                                    rep("Recessive", 25)))
row.names(ann.row) <- row.names(geneset)

pheatmap(geneset, 
         show_rownames = FALSE, 
         annotation_row = ann.row, 
         annotation_col = ann.col, 
         main = "Effects of Drugs Taken By Parents")


