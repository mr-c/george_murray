library(edgeR)
library(gplots)

# Last updated on June 12, 2019

# Read in annotation as a tab-delimited file from BioMart
annotation <- read.table("annotation.txt",sep="\t",header=TRUE,fill=TRUE,quote="\"")

# Read in count data as a comma-separated text file
rawdata <- read.csv(file = "counts_all_samples.csv")

# Report column labels to make sure they are correct
names(rawdata)

# Report first row of data to make sure it looks okay
rawdata[1,]

# Construct a new matrix so that geneIDs are used as row labels
data <- rawdata[, 2:17]
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

# Boxplots - Added 1 to all filtered counts to avoid log2(0)
png("boxplots_after_filtering.png")
boxplot(log2(cpm(DGE)+1),ylab="log2(cpm)",main="Filtered RNA-Seq Counts")
dev.off()

# Scatterplot
png("scatterplot_after_filtering.png")
pairs(cpm(DGE),pch='.')
dev.off()


# Take paired design of experiment into account by having a cell line (donor) factor
# along with treatment factor

donor <- factor(c(1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4))
treatment <- factor(c("ALBDEX","ALBDEX","ALBDEX","ALBDEX",
"ALB","ALB","ALB","ALB",
"DEX","DEX","DEX","DEX",
"CTRL", "CTRL", "CTRL", "CTRL"))

sample_names <- factor(c("ALBDEX_1","ALBDEX_2","ALBDEX_3","ALBDEX_4",
                      "ALB_1","ALB_2","ALB_3","ALB_4",
                      "DEX_1","DEX_2","DEX_3","DEX_4",
                      "CTRL_1", "CTRL_2", "CTRL_3", "CTRL_4"))

# Visualize how factors can be combined into a "design matrix"
data.frame(sample = colnames(DGE), donor, treatment)

# Make design matrix
design <- model.matrix(~ 0 + donor + treatment)
rownames(design) <- colnames(DGE)


# Multidimensional scaling plot to check samples
pdf("MDS_plot.pdf")
plotMDS(DGE, labels = sample_names)
dev.off()

# Estimate dispersion
DGE <- estimateGLMCommonDisp(DGE, design, verbose = TRUE)

DGE <- estimateGLMTrendedDisp(DGE, design)

DGE <- estimateGLMTagwiseDisp(DGE, design)

# Obtain summary of DGEList
DGE

# Plot biological coefficient of variation
png("biological_coefficient_of_variation.png")
plotBCV(DGE)
dev.off()

# Fit model using design matrix
fit <- glmQLFit(DGE, design)

##################################
# Compare ALBDEX to CTRL
##################################
albdex.ctrl <- glmQLFTest(fit, contrast=c(0,0,0,0,1,-1,0))

# Report how many are up- or down-regulated
albdex.DE <- decideTestsDGE(albdex.ctrl, adjust.method = "none",p.value=0.01,lfc=1)
summary(albdex.DE)
albdex.detags <- rownames(DGE)[as.logical(albdex.DE)]

# Extra highlight
png("albdex_MAplot.png",width=1024,height=1024)
smearde <- as.logical(albdex.DE)
plotsymbols <- rep(20, nrow(albdex.ctrl))
plotsymbols[smearde] <- 19
plotSmear(albdex.ctrl, de.tags = albdex.detags, cex=1.5, main= "ALB + DEX", pch=plotsymbols,cex.main=2,cex.axis=1.5,cex.lab=1.5)
abline(h = c(-1,1), col="dodgerblue", lwd = 2)
abline(h = c(0), col="black", lwd = 2)
dev.off()

# Report topTags
results <- topTags(albdex.ctrl,n=Inf)
results.annot <- merge(results,annotation,by.x="genes",by.y=1)
write.table(results.annot,"albdex_compared_to_control.txt",sep="\t",row.names=FALSE)

##################################
# Compare DEX to CTRL
##################################
dex.ctrl <- glmQLFTest(fit, contrast=c(0,0,0,0,0,-1,1))

# Report how many are up- or down-regulated
dex.DE <- decideTestsDGE(dex.ctrl, adjust.method = "fdr",lfc=1)
summary(dex.DE)
dex.detags <- rownames(DGE)[as.logical(dex.DE)]

# Extra highlight
png("dex_MAplot.png",width=1024,height=1024)
smearde <- as.logical(decideTestsDGE(dex.ctrl))
plotsymbols <- rep(20, nrow(albdex.ctrl))
plotsymbols[smearde] <- 19
plotSmear(dex.ctrl, de.tags = dex.detags, cex=1.5, main= "DEX", pch=plotsymbols,cex.main=2,cex.axis=1.5,cex.lab=1.5)
abline(h = c(-1,1), col="dodgerblue", lwd = 2)
abline(h = c(0), col="black", lwd = 2)
dev.off()

##################################
# Report topTags
##################################

results <- topTags(dex.ctrl,n=Inf)
results.annot <- merge(results,annotation,by.x="genes",by.y=1)
write.table(results.annot,"dex_compared_to_control.txt",sep="\t",row.names=FALSE)

##################################
# Compare ALB to CTRL
##################################
alb.ctrl <- glmQLFTest(fit, contrast=c(0,0,0,0,0,-1,0))

# Report how many are up- or down-regulated
alb.DE <- decideTestsDGE(alb.ctrl, adjust.method = "none",p.value=0.05,lfc=1)
summary(alb.DE)
alb.detags <- rownames(DGE)[as.logical(alb.DE)]

# Extra highlight
png("alb_MAplot.png",width=1024,height=1024)
smearde <- as.logical(decideTestsDGE(alb.ctrl))
plotsymbols <- rep(20, nrow(alb.ctrl))
plotsymbols[smearde] <- 19
plotSmear(alb.ctrl, de.tags = alb.detags, cex=1.5, main= "ALB", pch=plotsymbols,cex.main=2,cex.axis=1.5,cex.lab=1.5)
abline(h = c(-1,1), col="dodgerblue", lwd = 2)
abline(h = c(0), col="black", lwd = 2)
dev.off()

# Report topTags
results <- topTags(alb.ctrl,n=Inf)
results.annot <- merge(results,annotation,by.x="genes",by.y=1)
write.table(results.annot,"alb_compared_to_control.txt",sep="\t",row.names=FALSE)


# Read in list of hits of interest
hits <-read.table("hits.txt",sep="\t",header=FALSE,fill=TRUE,quote="\"")

# Export cpm for heatmap
logcpm <- data.frame(cpm(DGE, prior.count=2, log=TRUE))
colnames(logcpm) <- c(
"ALBDEX_1","ALBDEX_2","ALBDEX_3","ALBDEX_4",
"ALB_1","ALB_2","ALB_3","ALB_4",
"DEX_1","DEX_2","DEX_3","DEX_4",
"CTRL_1", "CTRL_2", "CTRL_3", "CTRL_4")

# Select subset of cpm for heatmap
select_logcpm <- merge(hits,logcpm,by.x=1,by.y=0)
gene_symbols <- merge(hits,annotation,by.x=1,by.y=1)
rownames(select_logcpm) <- gene_symbols[,2]
select_logcpm <- select_logcpm[,c(2:17)]

select_logcpm_matrix <- as.matrix(select_logcpm)
rownames(select_logcpm_matrix) <- gene_symbols[,2]

# Heatmap

#  Set colors
my_palette <- colorRampPalette(c("green", "black", "red"))(n = 100)

png("heatmap.png",width=1024,height=1024)
heatmap.2(select_logcpm_matrix, 
          col = my_palette,
          density.info = "none",
          trace = "none",
          scale = "row",
          lhei=c(1,4), lwid=c(1,3.5), keysize=1.0,
          cexRow=0.8, cexCol=0.8, margin=c(12,12))
dev.off()

# Correlation analysis
cor_matrix <- cor(t(logcpm))

# Gene expression profile plots
groups <- c("4.ALBDEX","4.ALBDEX","4.ALBDEX","4.ALBDEX",
            "3.ALB","3.ALB","3.ALB","3.ALB",
            "2.DEX","2.DEX","2.DEX","2.DEX",
            "1.CTRL", "1.CTRL", "1.CTRL", "1.CTRL")


# PER1
focus_gene <- c("ENSG00000179094")

focus_gene_cor <- cor_matrix[focus_gene,]
write.table(focus_gene_cor,"PER1_correlation.txt",sep="\t")

geneA <- c(subset(logcpm,rownames(logcpm) %in% focus_gene))
exp_values <- c(geneA$ALBDEX_1,geneA$ALBDEX_2,geneA$ALBDEX_3,geneA$ALBDEX_4,
                geneA$ALB_1,geneA$ALB_2,geneA$ALB_3,geneA$ALB_4,
                geneA$DEX_1,geneA$DEX_2,geneA$DEX_3,geneA$DEX_4,
                geneA$CTRL_1,geneA$CTRL_2,geneA$CTRL_3,geneA$CTRL_4)

png("PER1_boxplot.png",width=1024,height=1024)
boxplot(exp_values ~ groups,main="PER1")
dev.off()


# Yet another nice boxplot
plotdata=data.frame(groups,exp_values)

png("PER1_boxplot_nicer.png")
boxplot(exp_values ~ groups , col=terrain.colors(4) )

# Add data points
mylevels<-levels(plotdata$groups)
levelProportions<-summary(plotdata$groups)/nrow(plotdata)

for(i in 1:length(mylevels)){
  thislevel<-mylevels[i]
  thisvalues<-plotdata[plotdata$groups==thislevel, "exp_values"]
  
  # take the x-axis indices and add a jitter, proportional to the N in each level
  myjitter<-jitter(rep(i, length(thisvalues)), amount=levelProportions[i]/2)
  points(myjitter, thisvalues, pch=20, col=rgb(0,0,0,.2)) 
  
}
dev.off()

# ALOX15B
focus_gene <- c("ENSG00000179593")

focus_gene_cor <- cor_matrix[focus_gene,]
write.table(focus_gene_cor,"ALOX15B_correlation.txt",sep="\t")

# Gene expression profile plots
groups <- c("4.ALBDEX","4.ALBDEX","4.ALBDEX","4.ALBDEX",
            "3.ALB","3.ALB","3.ALB","3.ALB",
            "2.DEX","2.DEX","2.DEX","2.DEX",
            "1.CTRL", "1.CTRL", "1.CTRL", "1.CTRL")

focus_gene <- c("ENSG00000179593")

geneA <- c(subset(logcpm,rownames(logcpm) %in% focus_gene))
exp_values <- c(geneA$ALBDEX_1,geneA$ALBDEX_2,geneA$ALBDEX_3,geneA$ALBDEX_4,
                geneA$ALB_1,geneA$ALB_2,geneA$ALB_3,geneA$ALB_4,
                geneA$DEX_1,geneA$DEX_2,geneA$DEX_3,geneA$DEX_4,
                geneA$CTRL_1,geneA$CTRL_2,geneA$CTRL_3,geneA$CTRL_4)

png("ALOX15B_boxplot.png",width=1024,height=1024)
boxplot(exp_values ~ groups,main="ALOX15B")
dev.off()

# Yet another nice boxplot
plotdata=data.frame(groups,exp_values)

png("ALOX15B_boxplot_nicer.png")
boxplot(exp_values ~ groups , col=terrain.colors(4) )

# Add data points
mylevels<-levels(plotdata$groups)
levelProportions<-summary(plotdata$groups)/nrow(plotdata)

for(i in 1:length(mylevels)){
  thislevel<-mylevels[i]
  thisvalues<-plotdata[plotdata$groups==thislevel, "exp_values"]
  
  # take the x-axis indices and add a jitter, proportional to the N in each level
  myjitter<-jitter(rep(i, length(thisvalues)), amount=levelProportions[i]/2)
  points(myjitter, thisvalues, pch=20, col=rgb(0,0,0,.2)) 
  
}
dev.off()


