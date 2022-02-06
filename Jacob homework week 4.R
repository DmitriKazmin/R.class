
setwd("/Users/jacob/Downloads/RClub/R.class-Lesson-4")
rm(list = ls())

#1.)
gw <- read.table("genderweight.txt", sep = "\t", header = TRUE)
gender.t <- t.test(gw$weight[gw$group == "M"], gw$weight[gw$group == "F"])
if (gender.t$p.value < 0.05){
  print("The data has a significant difference between averages")
}else {
  print("The data has no significant difference between averages")
}

#2.)
js <- read.table("jobsatisfaction.txt", sep = "\t", header = TRUE)

treat.av <- aov(data = js, formula = score ~ gender*education_level)
summary(treat.av)
boxplot(data = js, score ~ gender*education_level)
