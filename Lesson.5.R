# R for bioinformatics lesson 5
# Plotting with ggplot2
# Heatmaps with pheatmap

setwd("~/Work/Python.club/Lesson.5/")
rm(list = ls())

# 
# DON'T FORGET TO RECORD!!!
#


library(ggplot2)
library(pheatmap)


# Scatterplots with ggplot2 -----------------------------------------------

# Read the dataset
expr <- read.table("expression.txt", sep = "\t", header = TRUE)

# Basic scatterplot
ggplot(data = expr, aes(x = FC, y = neg.log10.FDR)) + 
  geom_point()

# Let's fix the x-axis to make it symmetrical
ggplot(data = expr, aes(x = FC, y = neg.log10.FDR)) + 
  geom_point() + 
  xlim(-3, 3)

# Add a column with colors of the data points
expr$color <- "grey"
expr$color[expr$FC < -0.585 & expr$FDR < 0.05] <- "blue"
expr$color[expr$FC > 0.585 & expr$FDR < 0.05] <- "red"

# Let's add the lines to indicate the significance cutoffs
ggplot(data = expr, aes(x = FC, y = neg.log10.FDR)) + 
  geom_point(color = expr$color) + 
  xlim(-3, 3) + 
  geom_vline(xintercept = -0.585, color = "black") + 
  geom_vline(xintercept = 0.585, color = "black") + 
  geom_hline(yintercept = -1*log10(0.05), color = "red", linetype = "dashed")

# See how many blue and red dots we've got: 
length(which(expr$color == "blue")) #19
length(which(expr$color == "red"))  #202

# Add annotations
ggplot(data = expr, aes(x = FC, y = neg.log10.FDR)) + 
  geom_point(color = expr$color) + 
  xlim(-3, 3) + 
  geom_vline(xintercept = -0.585, color = "black") + 
  geom_vline(xintercept = 0.585, color = "black") + 
  geom_hline(yintercept = -1*log10(0.05), color = "red", linetype = "dashed") +
  annotate("text", x = -2.5, y = 1.5, label = "19") + 
  annotate("text", x = 2.5, y = 1.5, label = "202") 

# Add titles and change axis labels
ggplot(data = expr, aes(x = FC, y = neg.log10.FDR)) + 
  geom_point(color = expr$color) + 
  xlim(-3, 3) + 
  geom_vline(xintercept = -0.585, color = "black") + 
  geom_vline(xintercept = 0.585, color = "black") + 
  geom_hline(yintercept = -1*log10(0.05), color = "red", linetype = "dashed") +
  annotate("text", x = -2.5, y = 1.5, label = "19") + 
  annotate("text", x = 2.5, y = 1.5, label = "202") + 
  labs(title = "Gene expression changes", subtitle = "Day 1 post vaccination") +
  xlab("log2 Fold-change") + 
  ylab("-log10(FDR)")

# Remove the grey background
ggplot(data = expr, aes(x = FC, y = neg.log10.FDR)) + 
  geom_point(color = expr$color) + 
  xlim(-3, 3) + 
  geom_vline(xintercept = -0.585, color = "black") + 
  geom_vline(xintercept = 0.585, color = "black") + 
  geom_hline(yintercept = -1*log10(0.05), color = "red", linetype = "dashed") +
  annotate("text", x = -2.5, y = 1.5, label = "19") + 
  annotate("text", x = 2.5, y = 1.5, label = "202") + 
  labs(title = "Gene expression changes", subtitle = "Day 1 post boost") +
  xlab("log2 Fold-change") + 
  ylab("-log10(FDR)") + 
  theme_bw()

# And save the plot as a PDF 
ggsave("Scatterplot.pdf", plot = last_plot())


# Hands on practice 1 -----------------------------------------------------

# Read the dataset iris.txt
# Plot a scatter plot of sepal length vs. sepal width and color it by the species
# Hint: include color in the aesthetics of the main ggplot object

# Cheat sheet 1 -----------------------------------------------------------

iris <- read.table("iris.txt", sep = "\t", header = TRUE)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
  geom_point()

# Box plots with ggplot2 --------------------------------------------------

data("ToothGrowth")
ToothGrowth$dose <- as.factor(ToothGrowth$dose)

# Basic boxplot
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot()

# Add individual dots
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot() +
  geom_jitter(shape=16, position=position_jitter(0.2))

# Color the outlines of  boxes
ggplot(ToothGrowth, aes(x=dose, y=len, color = dose)) + 
  geom_boxplot() +
  geom_jitter(shape=16, position=position_jitter(0.2))

# And make the dots black again  
ggplot(ToothGrowth, aes(x=dose, y=len, color = dose)) + 
  geom_boxplot() +
  geom_jitter(shape=16, position=position_jitter(0.2), color = "black")

# Fill the boxes with colors
ggplot(ToothGrowth, aes(x=dose, y=len, fill = dose)) + 
  geom_boxplot() +
  geom_jitter(shape=16, position=position_jitter(0.2), color = "black")

# Make the boxes translucent
ggplot(ToothGrowth, aes(x=dose, y=len, fill = dose)) + 
  geom_boxplot(alpha = 0.5) +
  geom_jitter(shape=16, position=position_jitter(0.2), color = "black")

# Split the boxes by the type of supplement
ggplot(ToothGrowth, aes(x=dose, y=len, fill = supp)) + 
  geom_boxplot(alpha = 0.5)

# Add dots 
ggplot(ToothGrowth, aes(x=dose, y=len, fill = supp)) + 
  geom_boxplot(alpha = 0.5) + 
  geom_dotplot(binaxis='y', stackdir='center', position=position_dodge(0.8), binwidth = 0.5) 

# Add legends and axis titles
ggplot(ToothGrowth, aes(x=dose, y=len, fill = supp)) + 
  geom_boxplot(alpha = 0.5) + 
  geom_dotplot(binaxis='y', stackdir='center', position=position_dodge(0.8), binwidth = 0.5) + 
  labs(title = "Tooth growth by the dose of vitamin C", subtitle = "in guinea pigs") + 
  xlab("Dose") + 
  ylab("Tooth growth")

# Change the legend name
ggplot(ToothGrowth, aes(x=dose, y=len, fill = supp)) + 
  geom_boxplot(alpha = 0.5) + 
  geom_dotplot(binaxis='y', stackdir='center', position=position_dodge(0.8), binwidth = 0.5) + 
  labs(title = "Tooth growth by the dose of vitamin C", subtitle = "in guinea pigs") + 
  xlab("Dose") + 
  ylab("Tooth growth") + 
  labs(fill = "Supplement")

ggsave("Boxplot.pdf", plot = last_plot())


# Hands on practice 2 -----------------------------------------------------

# Read dataset mtcars.txt
# Make a box plot of horsepower vs. the number of cylinders
# Color the boxes to make them look pretty
# Make the boxes translucent

# Hint: convert the cylinders (cyl) column to factors by using 
# as.factor(mtcars$cyl)

# Cheat sheet 2 -----------------------------------------------------------

mtcars <- read.table("mtcars.txt", sep = "\t", header = TRUE)
mtcars$cyl <- as.factor(mtcars$cyl)

ggplot(mtcars, aes(x = cyl, y = hp, fill = cyl)) + 
  geom_boxplot(alpha = 0.5)

# Heatmaps ----------------------------------------------------------------

# Create a fake gene expression dataset
genes <- data.frame(matrix(nrow = 100, ncol = 40))

genes[c(1:50), c(1:10)] <- rnorm(mean = 8, 500)
genes[c(51:100), c(1:10)] <- rnorm(mean = -4, 500) 

genes[c(1:50), c(11:20)] <- rnorm(mean = 6, 500)
genes[c(51:100), c(11:20)] <- rnorm(mean = -6, 500)

genes[c(1:50), c(21:30)] <- rnorm(mean = -3, 500)
genes[c(51:100), c(21:30)] <- rnorm(mean = 3, 500)

genes[c(1:50), c(31:40)] <- rnorm(mean = 4, 500)
genes[c(51:100), c(31:40)] <- rnorm(mean = -8, 500)

colnames(genes) <- paste("Sample.", seq(1:40), sep = "")
row.names(genes) <- paste("Gene.", seq(1:100), sep = "")

# Create annotation data frames for rows and columns of the gene expression dataset
ann.col <- data.frame("Treatment" = c(rep("Drug", 20), 
                                      rep("Control", 20)), 
                      "Time" = c(rep("1 hour", 10), 
                                 rep("2 hours", 10), 
                                 rep("1 hour", 10), 
                                 rep("2 hours", 10)))
row.names(ann.col) <- colnames(genes)

ann.row <- data.frame("Pathway" = c(rep("Cell growth", 50), 
                                    rep("Cell death", 50)))
row.names(ann.row) <- row.names(genes)

# Plot heatmaps

# default heatmap
pheatmap(genes)

# remove row names
pheatmap(genes, 
         show_rownames = FALSE)

# Add row and column annotations as color bars
pheatmap(genes, 
         show_rownames = FALSE, 
         annotation_row = ann.row, 
         annotation_col = ann.col)

# Don't cluster columns, to preserve the order of samples
pheatmap(genes, 
         show_rownames = FALSE, 
         annotation_row = ann.row, 
         annotation_col = ann.col, 
         cluster_cols = FALSE)

# Add a title
pheatmap(genes, 
         show_rownames = FALSE, 
         annotation_row = ann.row, 
         annotation_col = ann.col, 
         main = "My Heatmap")



# Homework ----------------------------------------------------------------

# Create a fake gene expression dataset similar to the one used in the lesson
# Create annotation data frames with as many levels of annotation as you wish
# Create a heatmap of your dataset with row and column annotations. 

