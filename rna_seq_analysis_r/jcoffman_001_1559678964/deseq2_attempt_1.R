setwd("/Users/George1/Documents/github/george_murray/rna_seq_analysis_r/jcoffman_001_1559678964/")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

library("RColorBrewer")
library("ggplot2")
library("pheatmap")
library("DESeq2")
library("vsn")



# Read in annotation as a tab-delimited file from BioMart
annotation <- read.table("mart_export.txt",sep="\t",header=TRUE,fill=TRUE,quote="\"")

# Read in count data as a comma-separated text file
rawdata <- read.csv(file = "csv_gen_matrix.gene_id.expected_count.csv")

# Report column labels to make sure they are correct
names(rawdata)

# Report first row of data to make sure it looks okay
rawdata[1,]

# Construct a new matrix so that geneIDs are used as row labels
cts <- rawdata[, 2:7]
rownames(cts) <- rawdata[,1]

anno <- read.csv(file = "anno.csv")
cts <- as.matrix(cts, row.names="gene_id")

names(anno)
anno[1,]
coldata <- anno[, 2:3]
rownames(coldata) <- anno[,1]

coldata
head(cts)

#expected counts rounded to nearest integer to work with DESeq

cts <- round(cts, digits = 0)

all(row.names(coldata) == colnames(cts))

dds <- DESeqDataSetFromMatrix (countData = cts,
                              colData = coldata,
                              design = ~ condition)
dds

##DESeq Dataset Created, Moving on to Differential Expression Analysis

dds <- DESeq(dds)
res <- results(dds)
res
plotMA(res, ylim=c(-5,5))

#extracting transformed values
vsd <- vst(dds, blind = FALSE)
rld <- rlog(dds, blind = FALSE)
head(assay(vsd), 3)

#heatmap
select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing = TRUE)[1:20]
df <- as.data.frame(colData(dds)[,c("condition","type")])

sampleDists <- dist(t(assay(vsd)))
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd$condition, vsd$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette(rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows = sampleDists,
         clustering_distance_cols = sampleDists,
         col = colors)

#pca
pca_output <- plotPCA(vsd, intgroup=c("condition", "type"))
pca_output + ggtitle("jcoffman_001_1559678964")

