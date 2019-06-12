setwd("/Users/George1/Documents/github/george_murray/r_practice/pasilla/")

#installing Pasilla package
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("pasilla")
BiocManager::install("ggplot")
BiocManager::install("DESeq2")
BiocManager::install("edgeR")
BiocManager::install("reshape")
BiocManager::install("mixOmics")
BiocManager::install("stats")
BiocManager::install("RColorBrewer")
BiocManager::install("HTSFilter_1.4.0")
BiocManager::install("affy")



datafile = system.file("extdata/pasilla_gene_counts.tsv", package = "pasilla")

#read datafile with R
rawCountTable = read.table(datafile, header = TRUE, row.names = 1)

#creating description factor for samples and rename the rawCountTable columns
condition = c("control", "control", "control", "control", "treated", "treated", "treated")
libType = c("single-end", "single-end", "paired-end", "paired-end", "single-end", "paired-end", "paired-end")

colnames(rawCountTable)[1:4] = paste0("control", 1:4)

#visualization without normalization
library(ggplot2)
ggplot(rawCountTable, aes(x = control1)) + geom_histogram(fill = "#525252", binwidth = 2000)

# log base 2 transformation
pseudoCount = log2(rawCountTable +1)

#visualization with normalization
ggplot(pseudoCount, aes(x = control1)) + ylab(expression(log[2](count+1))) +
  geom_histogram(colour = "white", fill = "525252", binwidth = 0.6)

# boxplots to visualize distribution of pseudocounts in each sample
library(reshape)
df = melt(pseudoCount, variable_name = "Samples")
df = data.frame(df, Condition = substr(df$Samples, 1, 7))


ggplot(df, aes(x = Samples, y = value, fill = Condition)) + geom_boxplot() + xlab("") +
  ylab(expression(log[2](count + 1))) + scale_fill_manual(values = c("#619CFF", "#F564E3"))

#visualization of pseudocount distributions by histogram / density plot
ggplot(df, aes(x = value, colour = Samples, fill = Samples)) + ylim(c(0, 0.25)) +
  geom_density(alpha = 0.2, size = 1.25) + facet_wrap(~ Condition) +
  theme(legend.position = "top") + xlab(expression(log[2](count+1)))

# MA Plots
x = pseudoCount[, 6]
y = pseudoCount[, 7]
## M-values
M = x - y
## A-values
A = (x = y)/2

df = data.frame(A, M)

ggplot(df, aes(x = A, y = M)) + geom_point(size = 1.5, alpha = 1/5) +
  geom_hline(yintercept = 0,  color = "blue3") + stat_smooth(se = FALSE, method = "loess", color = "red3")

# clustering image from pseudocounts data
library(mixOmics)
library(RColorBrewer)
library(DESeq2)
mat.dist = pseudoCount
colnames(mat.dist) = paste(colnames(mat.dist), libType, sep = " : ")
mat.dist = as.matrix(dist(t(mat.dist)))
mat.dist = mat.dist/max(mat.dist)


hmcol = colorRampPalette(brewer.pal(9, "GnBu"))(16)
cim(mat.dist, color = rev(hmcol), symkey = FALSE, margins = c(9, 9))


# Principle Component Analysis #
##### NOT WORKING ######
'''require(limma)
pseudoCount2 <- as.matrix(pseudoCount)

# defining f(x) coerce pseudoCount2 to integer matrix
#test matrix
a <- matrix(c(0,1,0,1,0,1,0,0,1,0,1,0,1,0), ncol=7)
#testing f(x)
forceMatrixToInteger <- function(m){
  apply (m, c(1:7), function (x) {
    (as.integer(x))
  })
}
a <- forceMatrixToInteger(a)
class(a[1,])
# successful, trying with pseudoCount2

forceMatrixToInteger(pseudoCount2)


# end coerce f(x)
rv = rowVars(pseudoCount2)
select = order(rv, decreasing = TRUE)[1:1000]
pseudoCount3 <- rlog(pseudoCount2)
pca = prcomp(t(pseudoCount2[select, ]))

annot = AnnotatedDataFrame(data = data.frame(condition, libType,
                                             row.names = colnames(pseudoCount2)))
expSet = new("ExpressionSet", exprs = as.matrix(pseudoCount2), phenoData = annot)
plotPCA("Expressionset")'''
##### NOT WORKING ######
rv = rowVars(pseudoCount2)
select = order(rv, decreasing = TRUE)[1:1000]
pca = prcomp(t(pseudoCount2[select, ]))

annot = AnnotatedDataFrame(data = data.frame(condition, libType,
                                             row.names = colnames(pseudoCount2)))
expSet = new("ExpressionSet", exprs = as.matrix(pseudoCount2), phenoData = annot)
plotPCA(expSet, intgroup = c("condition", "libType"))
##MDS
x = pseudoCount
s = rowMeans((x - rowMeans(x))^2)
o = order(x, decreasing = TRUE)
x = x[o, ]
x = x[1:top, ]
D[i, j] = sqrt(colMeans((x[, i] - x[, j])^2))

fac = factor(paste(condition, libType, sep = " : "))
colours = brewer.pal(nlevels(fac), "Paired")
limma::plotMDS(pseudoCount, col = colours[as.numeric(fac)], labels = fac)
