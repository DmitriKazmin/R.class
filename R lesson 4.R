# Lesson 4, statistical tests, working with built-in data sets

setwd("~/Work/Python.club/Lesson.4/")
rm(list = ls())


# t-tests -------------------------------------------------------------------

hd <- read.table("headache.txt", sep = "\t", header = TRUE)

# First, let's look at 
# 1. Whether males and females have different pain scores
# 2. Whether subjects at high and low risk have different pain scores

sex.t <- t.test(hd$pain_score[hd$gender == "male"], hd$pain_score[hd$gender == "female"])
sex.t
# It appears that males have a slightly higher pain scores than females
boxplot(data = hd, pain_score ~ gender)

risk.t <- t.test(hd$pain_score[hd$risk == "low"], hd$pain_score[hd$risk == "high"])
risk.t
# Clearly, subjects at high risk suffer from significantly more severe headaches 
boxplot(data = hd, pain_score ~ risk)


# Multiple testing --------------------------------------------------------

# Let's create a fake dataset of gene expression values for a thousand genes
# and fill it with random values sampled from a normal distribution
# with mean = 0 and SD = 1:
gene.expr <- data.frame(matrix(nrow = 1000, ncol = 20, rnorm(20000)))
row.names(gene.expr) <- paste("Gene.", seq(1:1000), sep = "")
colnames(gene.expr)[1:10] <- paste("Treatment.", seq(1:10), sep = "")
colnames(gene.expr)[11:20] <- paste("Control.", seq(1:10), sep = "")

# And now let's select the genes whose expression is significantly different 
# between treatment and control groups. 
# There shouldn't be any, right? 

signif.genes <- data.frame("Gene" = character(1000), 
                           "p-value" = numeric(1000))

for (i in 1:nrow(gene.expr)) {
  p <- t.test(gene.expr[i, c(1:10)], gene.expr[i, c(11:20)])$p.value
  signif.genes[i, 1] <- row.names(gene.expr)[i]
  signif.genes[i, 2] <- p
}

# How many p-values less than 0.05 we got? 
length(which(signif.genes$p.value < 0.05))

# In my example I got 42 genes, but this number will fluctuate somewhere 
# around 50 (or 5% of all genes), depending on the random sample 

# A p-value of 0.05 just means that 5% of ALL tests will be false positives!!

# Does it mean that these "genes" are truly significant? 
# Of course not, the numbers are completely random. It's just a statistical fluke. 
# To lower our chance of making a type I error (falsely rejecting the null hypothesis)
# we use the adjustment for multiple testing. The most common way in gene expression 
# analysis is a Benjamini-Hotchberg False Discovery Rate (FDR) procedure: 

signif.genes$FDR <- p.adjust(signif.genes$p.value, method = "BH")

# Now how many significant genes we got? 
length(which(signif.genes$FDR < 0.05))

# I have zero, as expected. We may see one or two, since FDR procedure ensures that 
# we have a chance of making a type I error with a probability equal to the FDR value. 

# A q-value of 0.05 means that 5% of all SIGNIFICANT tests will be false positives!!

# Let's look at an example where there is a real difference between the two samples: 
ge <- data.frame(matrix(nrow = 1000, ncol = 20))
ge[, c(1:10)] <- rnorm(10000, mean = 0)
ge[, c(11:20)] <- rnorm(10000, mean = 0.75)
row.names(ge) <- paste("Gene.", seq(1:1000), sep = "")
colnames(ge)[1:10] <- paste("Treatment.", seq(1:10), sep = "")
colnames(ge)[11:20] <- paste("Control.", seq(1:10), sep = "")

sg <- data.frame("Gene" = character(1000), 
                           "p-value" = numeric(1000))

for (i in 1:nrow(ge)) {
  p <- t.test(ge[i, c(1:10)], ge[i, c(11:20)])$p.value
  sg[i, 1] <- row.names(ge)[i]
  sg[i, 2] <- p
}

length(which(sg$p.value < 0.05))  # In my case, 359, which means that 5%, or 18, are false positives
sg$FDR <- p.adjust(sg$p.value, method = "BH")
length(which(sg$FDR < 0.05))  # 73, or < 4 false positives

plot(x = sg$p.value, y = sg$FDR, xlab = "Raw p-value", ylab = "FDR")


# Hands on practice 1 -----------------------------------------------------

# Read file Gene.expression.txt
# For each gene, run a t-test, comparing treated (first 10 columns) and control 
# (columns 11 - 20) samples. 
# Adjust the p-values for multiple comparisons using the Benjamini-Hotchberg FDR procedure
# How many significant genes did you get? 
# How many of these do you expect to be false positive? 


# ANOVA -------------------------------------------------------------------


# Now, what about treatments? Is there a difference in pain score among the three treatment groups? 
# Clearly, since there are more than two groups, we cannot use t-test. For this, we 
# use ANOVA (Analysis of Variance)

hd <- read.table("headache.txt", sep = "\t", header = TRUE)

treat.av <- aov(data = hd, formula = pain_score ~ treatment)
summary(treat.av)

# We can also calculate pairwise differences using Tukey Honest Significant Differences
tukey.treat.av <- TukeyHSD(treat.av)
tukey.treat.av

boxplot(data = hd, pain_score ~ treatment)

# But maybe males and females respond to treatments differently? 
# Let's check this, by including the interaction term between sex and treatment: 

sex.treeat.av <- aov(data = hd, formula = pain_score ~ gender*treatment)
summary(sex.treeat.av)
# Still no significant effect for gender*treatment interaction
tukey.sex.treat.av <- TukeyHSD(sex.treeat.av)
tukey.sex.treat.av
# It appears that females respond to treatments Y and Z differently than males 
# respond to treatment X: 
boxplot(data = hd, pain_score ~ gender*treatment)

# Maybe people in different risk groups respond to treatments differently? 

risk.treat.av <- aov(data = hd, formula = pain_score ~ risk*treatment)
summary(risk.treat.av)
TukeyHSD(risk.treat.av)
# It appears that for both low and high risk groups treatment X is the least 
# efficient compared to Y and Z, although the p-values do not reach significance:
boxplot(data = hd, pain_score ~ risk*treatment)


# Hands on practice 2 -----------------------------------------------------

# Read the file anxiety.txt
# For each one of the three time points, run ANOVA test, testing whether there is
# a difference in anxiety scores among the three groups. 
# What is your conclusion? 
# Optional: run Tukey HSD to see which group is doing better than others


# Cheat sheet -------------------------------------------------------------

anxiety <- read.table("anxiety.txt", sep = "\t", header = TRUE)

a <- aov(data = anxiety, t1 ~ group)
summary(a)
TukeyHSD(a)
boxplot(data = anxiety, t1 ~ group)

a <- aov(data = anxiety, t2 ~ group)
summary(a)
TukeyHSD(a)
boxplot(data = anxiety, t2 ~ group)

a <- aov(data = anxiety, t3 ~ group)
summary(a)
TukeyHSD(a)
boxplot(data = anxiety, t3 ~ group)



# HOMEWORK ----------------------------------------------------------------

# 1. Read file genderweight.txt. 
#    Perform a two-sample t-test comparing the weight of males vs. the weight of female subjects
#    Is there a significant difference? 

# 2. Read file jobsatisfaction.txt. 
#    Perform a two-way ANOVA to establish whether there is any effect of either 
#    sex or education level on job satisfaction score. 



