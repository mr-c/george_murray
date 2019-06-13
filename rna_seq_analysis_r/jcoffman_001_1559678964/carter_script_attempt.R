## Code for gene expression analysis
## Original 1 by G Carter, The Jackson Laboratory, Dec 2018
## Original 2 by B King, The University of Maine, ND
## Assembled and Updated by G Murray, MDIBL Biocore, Jun 2019

require(DESeq2)

setwd("/Users/George1/Documents/github/george_murray/rna_seq_analysis_r/jcoffman_001_1559678964/")

# Read in annotation as a tab-delimited file from BioMart
annotation <- read.table("mart_export.txt",sep="\t",header=TRUE,fill=TRUE,quote="\"")

# Read in count data as a comma-separated text file
rawdata <- read.csv(file = "csv_gen_matrix.gene_id.expected_count.csv")

# Report column labels to make sure they are correct
names(rawdata)

# Report first row of data to make sure it looks okay
rawdata[1,]

# Construct a new matrix so that geneIDs are used as row labels
data <- rawdata[, 2:7]
rownames(data) <- rawdata[,1]

# Report first row of data to make sure it looks okay
data[1,]

# Boxplots - Added 1 to all filtered counts to avoid log2(0)
png("boxplots.png")
boxplot(log2(data+1),ylab="log2(Counts)",main="Filtered RNA-Seq Counts")
dev.off()

# Scatterplot
png("scatterplot.png")
pairs(log2(data+1),pch='.')
dev.off()

# Create DGEList using filtered counts
DGE <- DGEList(counts = data, genes = row.names(data))

# Filter out lowly expressed genes
keep <-rowSums(cpm(DGE)>=1) >=4
DGE<-DGE[keep,]

# Normalize data by read depth per sample
DGE <- calcNormFactors(DGE)

# Obtain summary of DGEList
DGE

## Look at the dimensions of the data matrix
dim(data)

# SVD analysis without mean centering
allsvd <- svd( data )
# Compute the weights without mean centering
uncenteredweights <- allsvd$d^2 / sum(allsvd$d^2)
plot(uncenteredweights)


# SVD analysis with mean centering
# center each transcript at its mean
ph <- t(apply( data, 1, function(x) {as.numeric(x) - mean(as.numeric(x))} ))
# label the column names
colnames(ph) <- colnames(data)
# SVD it
allsvd <- svd( ph )
# Compute the weights with mean centering
allweights <- allsvd$d^2 / sum(allsvd$d^2)
# plot the weights
plot(allweights)
# plot the first two PCs
plot( allsvd$v[,1],allsvd$v[,2])

### Differentially Expressed Genes ###
# mean-center the differentially-expressed genes only and SVD
ph <- t(apply( DGE, 1, function(x) {as.numeric(x) - mean(as.numeric(x))} ))
colnames(ph) <- colnames(data)
diffsvd <- svd( ph )
diffweights <- diffsvd$d^2 / sum(diffsvd$d^2)
# plot the weights
plot(diffweights)
# plot the first two PCs
plot( diffsvd$v[,1], diffsvd$v[,2], col=c( rep("black",6), rep("red",6), rep("blue",6) ) )

# rank-order all genes and export the list for Gene Set Enrichment Analysis
# order by mean(ApoeKO) - mean(B6), the difference between ApoE knockout mutant and WT
diffexpr <- apply( alltpm, 1, function(x) {mean(x[13:18] - mean(x[1:6]))} )
rankorder <- order(diffexpr)
# which gene has the most-reduced expression?
alltpm[rankorder[1],]
# which gene has the most-increased expression?
alltpm[tail(rankorder,1),]
# export the ranked list
write.table( rownames(alltpm)[rankorder], file="rank_order_all_KO-B6.txt", quote=F, row.names=F, col.names=F)

# export a list of differentially expressed genes with increased transcript abundance
posdiffgenes <- diffgenes[which( diffexpr[diffgenes] > 0 )]
write.table( posdiffgenes, file="pos_de_genes.txt", quote=F, row.names=F, col.names=F )
# export a list of differentially expressed genes with increased transcript abundance
negdiffgenes <- diffgenes[which( diffexpr[diffgenes] < 0 )]
write.table( negdiffgenes, file="neg_de_genes.txt", quote=F, row.names=F, col.names=F )

