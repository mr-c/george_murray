if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("edgeR")
install.packages("statmod")
BiocManager::install("GO.db")
BiocManager::install("DESeq2")

library(edgeR)
library(statmod)
library(GO.db)
library(DESeq2)
library(ggplot2)

rawdata <- read.delim("gen_matrix.gene_id.expected_count.txt", header = TRUE, check.names = FALSE, stringsAsFactors = FALSE)
head(rawdata)
y <- DGEList(counts=rawdata[,2:7], genes = rawdata[,1])

o <- order(rowSums(y$counts), decreasing = TRUE)
y <- y[o,]
d <- duplicated(y$genes)
y <- y[!d,]
nrow(y)
y$samples$lib.size <- colSums(y$counts)
rownames(y$counts) <- rownames(y$genes)
#y$genes <- NULL

y <- calcNormFactors(y)
y$samples

plotMDS(y)

# design matrix
sample_number <- factor(c(1, 2, 3, 4, 5, 6))
group <- factor(c("control", "control", "treated", "treated", "treated", "control"))
data.frame(Sample=colnames(y),sample_number,group)
# here, I initially tried constructing the design matrix as model.matrix(~rep+gropu), but rep and group represent the same experimental variable
# there, matrix was confounded ... removed rep and dispersion calculations worked fine. This makes sense, only variable in experiment is treatment condition 
design
design <- model.matrix(~group)
rownames(design) <- colnames(y)

# estimate dispersions
y <- estimateDisp(y, design, robust = TRUE)
y$common.dispersion

# dispersion estimates can ve viewed in a BCV plot
plotBCV(y)

# determining differential expression
fit <- glmFit(y, design)
# conduct likelihood ratio tests for cortisol vs control differences and show top genes
lrt <- glmLRT(fit)
topTags(lrt)
colnames(design)

o <-  order(lrt$table$PValue)
cpm(y)[o[1:10],]

# total number of differentially expressed genes at 5% FDR given by:
summary(decideTests(lrt))

plotMD(lrt)
abline(h=c(-1, 1), col="blue")


# Export DGE List
out <- topTags(lrt, n=Inf)
out <- as.data.frame(out)
write.csv(out, file="dge_export.csv", row.names = FALSE)

# Export PCA
cts <- rawdata[, 2:7]
rownames(cts) <- rawdata[,1]
anno <- read.csv(file = "anno.csv")
cts <- as.matrix(cts, row.names="gene_id")
names(anno)
anno[1,]
coldata <- anno[, 2:3]
rownames(coldata) <- anno[,1]
#expected counts rounded to nearest integer to work with DESeq
cts <- round(cts, digits = 0)
all(row.names(coldata) == colnames(cts))
dds <- DESeqDataSetFromMatrix (countData = cts,
                               colData = coldata,
                               design = ~ condition)
##DESeq Dataset Created, Moving on to Differential Expression Analysis
dds <- DESeq(dds)
res <- results(dds)
#extracting transformed values
rld <- rlog(dds, blind = FALSE)
pdf("jcoffman_001_1559678964_rlog_pca")
pca_output <- plotPCA(rld, intgroup=c("condition", "type"))
pca_output + ggtitle("jcoffman_001_1559678964_rlog_pca")
dev.off()


