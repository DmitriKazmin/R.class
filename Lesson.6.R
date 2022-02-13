# Lesson 6. 
# Gene expression dataset
#

setwd("~/Work/Python.club/Lesson.6/")
rm(list = ls())

library(ggplot2)
library(pheatmap)

# Data intake and parsing
ann <- read.table("Sample annotation.txt", sep = "\t", header = TRUE)
expr <- read.table("sample_annotation_final_data.txt", sep = "\t", header = TRUE)

# Keep only data for RRR regimen
expr2 <- expr[, colnames(expr) %in% ann$Array[ann$Group.number..effective. == 2]]
expr <- cbind(expr[, 1], expr2)
rm("expr2")

# For each gene and for each post-vaccination time point run a paired t-test comparing 
# expression of each gene post-vaccination to the pre-vaccination baseline

subj <- unique(ann$Subject)
time <- unique(ann$Visit)

t.out <- data.frame(matrix(nrow = nrow(expr), 
                           ncol = (length(time) - 1)*4))
row.names(t.out) <- expr$`expr[, 1]`
colnames(t.out) <- c(paste(time[2:length(time)], "log2FC", sep = "."), 
                     paste(time[2:length(time)], "p-value", sep = "."), 
                     paste(time[2:length(time)], "FDR", sep = "."), 
                     paste(time[2:length(time)], "neg.log10.FDR", sep = "."))

# Identify subjects with samples at baseline
base.subj <- ann$Subject[ann$Group.number..effective. == 2 &
                           ann$Visit == 2]

### Do not run! Takes a long time!

for (j in 2:length(time)) {
  # Identify subjects with present samples at post-vaccination time points
  post.subj <- ann$Subject[ann$Group.number..effective. == 2 &
                             ann$Visit == time[j]]
  my.subj <- intersect(base.subj, post.subj)
  # Identify matching samples
  base.samples <- ann$Array[ann$Group.number..effective. == 2 & 
                              ann$Visit == 2 & 
                              ann$Subject %in% my.subj]
  post.samples <- ann$Array[ann$Group.number..effective. == 2 &
                              ann$Visit == time[j] & 
                              ann$Subject %in% my.subj]
  # Pull out baseline and post-vacc expression data
  expr.base <- expr[, colnames(expr) %in% base.samples]
  expr.post <- expr[, colnames(expr) %in% post.samples]
  # Sort samples in the same order of subjects
  order.base <- order(ann$Subject[match(colnames(expr.base), ann$Array)])
  order.post <- order(ann$Subject[match(colnames(expr.post), ann$Array)])
  expr.base <- expr.base[, order.base]
  expr.post <- expr.post[, order.post]
  
  # Main loop
  for (m in 1:nrow(expr)) {
    ttest <- t.test(t(expr.base[m, ]), t(expr.post[m, ]), paired = TRUE)
    t.out[m, (j - 1)] <- ttest$estimate
    t.out[m, (j+12)] <- ttest$p.value
  }
  cat("Done with visit ", time[j], "\n")
}

# calculate FDR for each time point
for (i in 27:39) {
  t.out[, i] <- p.adjust(t.out[, (i - 13)], method = "BH")
}

# Calculate -log10(FDR) for plotting
for (i in 40:52) {
  t.out[, i] <- -1*log10(t.out[, (i - 13)])
}

write.table(t.out, file = "t.out.txt", sep = "\t", col.names = NA)

# Plot volcano plots for the first few time points

changes <- read.table("t.out.txt", sep = "\t", header = TRUE)

# Isolate the data for plotting for the first few time points

c4 <- changes[, c(2, 28, 41)] # Day 1 post primary vaccination
c5 <- changes[, c(3, 29, 42)] # Day 2 post primary vaccination
c7 <- changes[, c(4, 30, 43)] # Day 6 post primary vaccination
c8 <- changes[, c(5, 31, 44)] # Day 14 post primary vaccination
c9 <- changes[, c(6, 32, 45)] # Day 28 post primary vaccination

c4$color <- "grey"
c4$color[c4$X4.log2FC < -0.585 & c4$X4.FDR < 0.05] <- "blue"
c4$color[c4$X4.log2FC > 0.585 & c4$X4.FDR < 0.05] <- "red"

length(which(c4$color == "blue")) # 3,173
length(which(c4$color == "red"))  # 3,769


c5$color <- "grey"
c5$color[c5$X5.log2FC < -0.585 & c5$X5.FDR < 0.05] <- "blue"
c5$color[c5$X5.log2FC > 0.585 & c5$X5.FDR < 0.05] <- "red"

length(which(c5$color == "blue")) # 249
length(which(c5$color == "red"))  # 202


c7$color <- "grey"
c7$color[c7$X7.log2FC < -0.585 & c7$X7.FDR < 0.05] <- "blue"
c7$color[c7$X7.log2FC > 0.585 & c7$X7.FDR < 0.05] <- "red"

length(which(c7$color == "blue")) # 2,449
length(which(c7$color == "red"))  # 1,689


c8$color <- "grey"
c8$color[c8$X8.log2FC < -0.585 & c8$X8.FDR < 0.05] <- "blue"
c8$color[c8$X8.log2FC > 0.585 & c8$X8.FDR < 0.05] <- "red"

length(which(c8$color == "blue")) # 564
length(which(c8$color == "red"))  # 510


c9$color <- "grey"
c9$color[c9$X9.log2FC < -0.585 & c9$X9.FDR < 0.05] <- "blue"
c9$color[c9$X9.log2FC > 0.585 & c9$X9.FDR < 0.05] <- "red"

length(which(c9$color == "blue")) # 743
length(which(c9$color == "red"))  # 617

# And make / save the volcano plots:

ggplot(data = c4, aes(x = X4.log2FC, y = X4.neg.log10.FDR)) + 
  geom_point(color = c4$color) + 
  xlim(-3, 3) + 
  ylim(0, 12) +
  geom_vline(xintercept = -0.585, color = "black") + 
  geom_vline(xintercept = 0.585, color = "black") + 
  geom_hline(yintercept = -1*log10(0.05), color = "red", linetype = "dashed") +
  annotate("text", x = -2.5, y = 1.5, label = "3,173") + 
  annotate("text", x = 2.5, y = 1.5, label = "3,769") + 
  labs(title = "Gene expression changes", subtitle = "Day 1 post primary vaccination") +
  xlab("log2 Fold-change") + 
  ylab("-log10(FDR)") + 
  theme_bw()

ggsave("Day.1.volcano.plot.pdf", plot = last_plot())

ggplot(data = c5, aes(x = X5.log2FC, y = X5.neg.log10.FDR)) + 
  geom_point(color = c5$color) + 
  xlim(-3, 3) + 
  ylim(0, 12) +
  geom_vline(xintercept = -0.585, color = "black") + 
  geom_vline(xintercept = 0.585, color = "black") + 
  geom_hline(yintercept = -1*log10(0.05), color = "red", linetype = "dashed") +
  annotate("text", x = -2.5, y = 1.5, label = "249") + 
  annotate("text", x = 2.5, y = 1.5, label = "202") + 
  labs(title = "Gene expression changes", subtitle = "Day 2 post primary vaccination") +
  xlab("log2 Fold-change") + 
  ylab("-log10(FDR)") + 
  theme_bw()

ggsave("Day.2.volcano.plot.pdf", plot = last_plot())

ggplot(data = c7, aes(x = X7.log2FC, y = X7.neg.log10.FDR)) + 
  geom_point(color = c7$color) + 
  xlim(-3, 3) + 
  ylim(0, 12) +
  geom_vline(xintercept = -0.585, color = "black") + 
  geom_vline(xintercept = 0.585, color = "black") + 
  geom_hline(yintercept = -1*log10(0.05), color = "red", linetype = "dashed") +
  annotate("text", x = -2.5, y = 1.5, label = "2,449") + 
  annotate("text", x = 2.5, y = 1.5, label = "1,689") + 
  labs(title = "Gene expression changes", subtitle = "Day 6 post primary vaccination") +
  xlab("log2 Fold-change") + 
  ylab("-log10(FDR)") + 
  theme_bw()

ggsave("Day.6.volcano.plot.pdf", plot = last_plot())

ggplot(data = c8, aes(x = X8.log2FC, y = X8.neg.log10.FDR)) + 
  geom_point(color = c8$color) + 
  xlim(-3, 3) + 
  ylim(0, 12) +
  geom_vline(xintercept = -0.585, color = "black") + 
  geom_vline(xintercept = 0.585, color = "black") + 
  geom_hline(yintercept = -1*log10(0.05), color = "red", linetype = "dashed") +
  annotate("text", x = -2.5, y = 1.5, label = "564") + 
  annotate("text", x = 2.5, y = 1.5, label = "510") + 
  labs(title = "Gene expression changes", subtitle = "Day 14 post primary vaccination") +
  xlab("log2 Fold-change") + 
  ylab("-log10(FDR)") + 
  theme_bw()

ggsave("Day.14.volcano.plot.pdf", plot = last_plot())

ggplot(data = c9, aes(x = X9.log2FC, y = X9.neg.log10.FDR)) + 
  geom_point(color = c9$color) + 
  xlim(-3, 3) + 
  ylim(0, 12) +
  geom_vline(xintercept = -0.585, color = "black") + 
  geom_vline(xintercept = 0.585, color = "black") + 
  geom_hline(yintercept = -1*log10(0.05), color = "red", linetype = "dashed") +
  annotate("text", x = -2.5, y = 1.5, label = "743") + 
  annotate("text", x = 2.5, y = 1.5, label = "617") + 
  labs(title = "Gene expression changes", subtitle = "Day 28 post primary vaccination") +
  xlab("log2 Fold-change") + 
  ylab("-log10(FDR)") + 
  theme_bw()

ggsave("Day.28.volcano.plot.pdf", plot = last_plot())

# Plot a heatmap of all significant genes

# Select genes that come up as significant at at least one time point

# Create an indexing vector
idx <- rep(FALSE, nrow(changes))

colnames(changes)

for (i in 2:14) {
  for (j in 1:nrow(changes)) {
    if (abs(changes[j, i]) > 0.585 & changes[j, i+26] < 0.05) {
      idx[j] <- TRUE
    }
  }
}

length(which(idx))  # 14,801. That's a lot of genes. We need to reduce this number 
# by introducing more stringent criteria

idx <- rep(FALSE, nrow(changes))

for (i in 2:14) {
  for (j in 1:nrow(changes)) {
    if (abs(changes[j, i]) > 1 & changes[j, i+26] < 0.01) {
      idx[j] <- TRUE
    }
  }
}

length(which(idx)) # 5,053. That's a more reasonable number to plot


changes.sig <- changes[idx, ]

pheatmap(changes.sig[, 2:14], 
         show_rownames = FALSE, 
         scale = "row", 
         labels_col = c("D1 post 1st", 
                        "D2 post 1st", 
                        "D6 post 1st", 
                        "D14 post 1st", 
                        "D28 post 1st", 
                        "D6 post 2nd", 
                        "D28 post 2nd", 
                        "DoC", 
                        "D1 post DoC", 
                        "D6 post DoC", 
                        "D1 post 3rd", 
                        "D6 post 3rd", 
                        "D1 post 2nd"))

# From the heatmap we can clearly see the following patterns: 
# 1. D1 post prime vaccination induces the strongest response, which is unique
#    and is not replicated at any other time point
# 2. At other time points there are three major patterns: 
#    a) genes regulated at D2, D14 and D28 post prime, and the Day of Challenge (D28 post 3rd)
#    b) genes regulated at D1 post 2nd and D1 post 3rd. Note that the pattern of regulation of 
#       these genes is different from the pattern seen at D1 post prime vaccination
#    c) genes regulated at D6 post 1st, D6 post 2nd, D6 post 3rd, D6 post DoC, 
#       D1 post DoC and D28 post 2nd. These are expected to be the genes involved in 
#       the adaptive response (accumulation of antibody secreting cells). 
# It is interesting that 
#    a) D1 post boost vaccinations display substantially different patterns of 
#       gene regulation than D1 post prime
#    b) D28 post prime and D28 post 3rd (DoC) display the patterns of gene regulation 
#       different from D28 post 2nd, which groups with the adaptive time points. 
#
# We will look at the functional content of gene level responses in the next class. 


# Homework: 
# 1. Modify the existing code to repeat the t-tests on the ARR cohort
# 2. Make similar heatmap for the ARR cohort and compare it to the 
#    RRR heatmap. Do you see any differences? Please describe any 
#    differences in expression patterns between the two cohorts. 

