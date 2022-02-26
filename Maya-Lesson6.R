library(pheatmap)

ann <- read.table("Sample annotation.txt", sep = "\t", header = TRUE)
expr <- read.table("sample_annotation_final_data.txt", sep = "\t", header = TRUE)

expr2 <- expr[, colnames(expr) %in% ann$Array[ann$Group.number..effective. == 1]]
expr <- cbind(expr[, 1], expr2)
rm("expr2")

subj <- unique(ann$Subject)
time <- unique(ann$Visit)

tvisits = length(time) - 1
t.out <- data.frame(matrix(nrow = nrow(expr), 
                           ncol = tvisits * 4))
row.names(t.out) <- expr$`expr[, 1]`
colnames(t.out) <- c(paste(time[2:length(time)], "log2FC", sep = "."), 
                     paste(time[2:length(time)], "p-value", sep = "."), 
                     paste(time[2:length(time)], "FDR", sep = "."), 
                     paste(time[2:length(time)], "neg.log10.FDR", sep = "."))

base.subj <- ann$Subject[ann$Group.number..effective. == 1 &
                           ann$Visit == 2]
for (j in 1:tvisits) {
  post.subj <- ann$Subject[ann$Group.number..effective. == 1 &
                             ann$Visit == time[j + 1]]
  my.subj <- intersect(base.subj, post.subj)
  base.samples <- ann$Array[ann$Group.number..effective. == 1 & 
                              ann$Visit == 2 & 
                              ann$Subject %in% my.subj]
  post.samples <- ann$Array[ann$Group.number..effective. == 1 &
                              ann$Visit == time[j + 1] & 
                              ann$Subject %in% my.subj]
  expr.base <- expr[, colnames(expr) %in% base.samples]
  expr.post <- expr[, colnames(expr) %in% post.samples]
  order.base <- order(ann$Subject[match(colnames(expr.base), ann$Array)])
  order.post <- order(ann$Subject[match(colnames(expr.post), ann$Array)])
  expr.base <- expr.base[, order.base]
  expr.post <- expr.post[, order.post]
  
  for (m in 1:nrow(expr)) {
    ttest <- t.test(t(expr.base[m, ]), t(expr.post[m, ]), paired = TRUE)
    t.out[m, j] <- ttest$estimate
    t.out[m, j + tvisits] <- ttest$p.value
  }
  cat("Done with visit ", time[j + 1], "\n")
}

for (i in (tvisits * 2 + 1):(tvisits * 3)){
  t.out[, i] <- p.adjust(t.out[, i - tvisits], method = "BH")
}

for (i in (tvisits * 3 + 1):(tvisits * 4)) {
  t.out[, i] <- -1*log10(t.out[, i - tvisits])
}

idx <- rep(FALSE, nrow(t.out))

for (v in 1:tvisits) {
  for (g in 1:nrow(t.out)) {
    if (abs(t.out[g, v]) > 1 & t.out[g, v + tvisits * 2] < 0.01) {
      idx[g] <- TRUE
    }
  }
}
changes.sig <- t.out[idx, ]

pheatmap(changes.sig[, 1:tvisits], 
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
# 1. D1 and D2 post prime vaccination both induce a strong response that is not matched by any 
#    other days.
# 2. At other time points there are three major patterns: 
#    a) genes regulated at DoC, DoC + 1, D14 and D28 post first
#    b) genes regulated at D1 post 2nd and 3rd show a significant response compared to the days 
#       that follow
#    c) genes regulated at D6 post 1, 2nd, 3rd, and DoC and D28 post 2nd 
# The first two days after Ad35 had significant response compared to only one day for the 
# initial RTS,S. The boosters also appeared to have affected the genes that had a mild response from the prime,
# but for ARR the 3rd booster showed more significant results.