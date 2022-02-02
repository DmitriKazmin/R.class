# 1. Read file genderweight.txt. 
#    Perform a two-sample t-test comparing the weight of males vs. the weight of female subjects
#    Is there a significant difference? 
gw <- read.table("genderweight.txt", sep = "\t", header = TRUE)
gw.t <- t.test(gw$weight[gw$group == "M"], gw$weight[gw$group == "F"])
if (gw.t$p.value < 0.05) {
  print("The data has a significant difference between the means")
}
# 2. Read file jobsatisfaction.txt. 
#    Perform a two-way ANOVA to establish whether there is any effect of either 
#    sex or education level on job satisfaction score. 
js <- read.table("jobsatisfaction.txt", sep = "\t", header = TRUE)
js.anv <- aov(data = js, formula = score ~ gender*education_level)
boxplot(data = js, score ~ gender*education_level)
sum <- summary(js.anv)
paste(row.names(subset(sum[[1]],`Pr(>F)` < 0.05)), "has significant effect on satisfaction score")