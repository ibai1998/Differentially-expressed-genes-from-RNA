library("DESeq2")
library('clusterProfiler')
library('org.Hs.eg.db')
library('enrichplot')
library('ggplot2')

# Import relevant columns from featureCounts output
new_matrix <- featureCounts[,7:18]
counts <- new_matrix[2:60672,]

#Repeat for all columns
counts$V7<-as.numeric(counts$V7)
counts$V8<-as.numeric(counts$V8)
counts$V9<-as.numeric(counts$V9)
counts$V10<-as.numeric(counts$V10)
counts$V11<-as.numeric(counts$V11)
counts$V12<-as.numeric(counts$V12)
counts$V13<-as.numeric(counts$V13)
counts$V14<-as.numeric(counts$V14)
counts$V15<-as.numeric(counts$V15)
counts$V16<-as.numeric(counts$V16)
counts$V17<-as.numeric(counts$V17)
counts$V18<-as.numeric(counts$V18)

# Create new matrix with numerical values
new_counts<-cbind(matrix(counts$V7),matrix(counts$V8),matrix(counts$V9),matrix(counts$V10),matrix(counts$V11),matrix(counts$V12),matrix(counts$V13),matrix(counts$V14),matrix(counts$V15),matrix(counts$V16),matrix(counts$V17),matrix(counts$V18))

######
##PCA (this data set is just used to create a dds object to then conduct a PCA)
#Set column names
colnames(new_counts)<-c('HER21','HER22','HER23','NonTNBC1','NonTNBC2','NonTNBC3','TNBC1','TNBC2','TNBC3','Normal1','Normal2','Normal3')
# Create data frame with one colomn
col_data <- data.frame(group =c('HER21','HER22','HER23','NonTNBC1','NonTNBC2','NonTNBC3','TNBC1','TNBC2','TNBC3','Normal1','Normal2','Normal3') )


#######
# FOR RESULTS FILE

# Modify HER columns with Normal columns (not relevant, shift the columns to see how the software interacts with different data structures)
H1<- new_counts[,1]
H2<- new_counts[,2]
H3<- new_counts[,3]

N1<-new_counts[,10]
N2<-new_counts[,11]
N3<-new_counts[,12]

new_counts[,1]<-N1
new_counts[,2]<-N2
new_counts[,3]<-N3

new_counts[,10]<-H1
new_counts[,11]<-H2
new_counts[,12]<-H3

colnames(new_counts)<-c('Normal','Normal','Normal','NonTNBC','NonTNBC','NonTNBC','TNBC','TNBC','TNBC','HER2','HER2','HER2')

col_data <- data.frame(group =c('Normal','Normal','Normal','NonTNBC','NonTNBC','NonTNBC','TNBC','TNBC','TNBC','HER2','HER2','HER2') )
###################
# Create dds object

dds <- DESeq2::DESeqDataSetFromMatrix(countData = new_counts,
                                      colData = col_data,
                                      design = ~ group )

dds_out<-DESeq2::DESeq(dds)
dds_vst<-DESeq2::vst(dds_out, blind = TRUE)

# Generate PCA plot
DESeq2::plotPCA(dds_vst, intgroup = 'group')

#####################################################
# 6. Differential expression analysis

NonTNBC_Normal<-DESeq2::results(dds_out, contrast = c('group','NonTNBC','Normal'))
TNBC_Normal<-DESeq2::results(dds_out, contrast = c('group','TNBC','Normal'))
HER_Normal<-DESeq2::results(dds_out, contrast = c('group','HER2','Normal'))

# Calculation of differentially expressed genes in the pairwise comparisons, padj<0.05
length(which(NonTNBC_Normal$padj <= 0.05)) 
# 14675

length(which(TNBC_Normal$padj <= 0.05))
# 17714

length(which(HER_Normal$padj <= 0.05))
# 15428

# How many of the DE genes are up-regulated and down-regulated?
DESeq2::resultsNames(dds_out)

summary_HER_Normal <- DESeq2::results(dds_out,contrast = c('group', 'HER2','Normal'))


summary_NonTNBC_Normal <- DESeq2::results(dds_out, c('group','NonTNBC', 'Normal'))

summary_TNBC_Normal <- DESeq2::results(dds_out, c('group','TNBC', 'Normal'))

summary_HER_TNBC <- DESeq2::results(dds_out,contrast = c('group', 'HER2','TNBC'))


summary(summary_HER_Normal, alpha = 0.05)

summary(summary_NonTNBC_Normal)

summary(summary_TNBC_Normal)

summary(summary_HER_TNBC, alpha = 0.05)


# MA plotting
DESeq2::plotMA(summary_HER_Normal)

# Print values below 1.0e-10
padj <- summary_HER_Normal$padj

padj_HER_TNBC <- summary_HER_TNBC$padj

padj_NonTNBC_Normal <- summary_NonTNBC_Normal$padj
# Modify Na-s with 1 
padj[is.na(padj)] = 1

padj_HER_TNBC[is.na(padj_HER_TNBC)] = 1

padj_NonTNBC_Normal[is.na(padj_NonTNBC_Normal)] = 1

# Gene matrix for genes with p value smaller than 1.0e-5
gene_mat <- matrix(data = 0, nrow = 3504, ncol = 2)
m_cell <- 1

for (i in 1:length(padj_HER_TNBC)){
  
  pval <- padj_HER_TNBC[i]
  loc <- i + 1
  
  if(pval<1.0e-5){
    gene_mat[m_cell,1] <- pval
    
    gene_mat[m_cell,2] <- featureCounts[loc,1]
    
    m_cell <- m_cell + 1
    
    
  }
}



# Gene matrix for genes with p value smaller than 1.0e-10
gene_mat1 <- matrix(data = 0, nrow = 919, ncol = 2)
m_cell <- 1
for (i in 1:length(padj_HER_TNBC)){
  
  pval <- padj[i]
  loc <- i + 1
  
  if(pval<1.0e-10){
    gene_mat1[m_cell,1] <- pval
    
    gene_mat1[m_cell,2] <- featureCounts[loc,1]
    
    m_cell <- m_cell + 1
    
  }
}

# Gene matrix for genes with p value smaller than 1.0e-50

gene_mat_2 <- matrix(data = 0, nrow = 100, ncol = 2)

m_cell <- 1

for (i in 1:length(padj_HER_TNBC)){
  
  pval <- padj_HER_TNBC[i]
  loc <- i + 1      # +1 because in featureCounts the firs row is the header
  
  if(pval<1.0e-5){
    gene_mat_2[m_cell,1] <- pval
    
    gene_mat_2[m_cell,2] <- featureCounts[loc,1]
    
    m_cell <- m_cell + 1
    
  }
}
####
# Interesting genes from the paper
# Gene1
RAB21 <- 'ENSG00000080371'

which(featureCounts[,1] == RAB21)
# [1] 39332 
### Adjusted p-value in different sample comparisons
summary_HER_Normal$padj[(39332-1)]
summary_TNBC_Normal$padj[(39332-1)]
summary_NonTNBC_Normal$padj[(39332-1)]

### Log 2 fold change in different sample comparisons

summary_HER_Normal$log2FoldChange[(39332-1)]
summary_TNBC_Normal$log2FoldChange[(39332-1)]
summary_NonTNBC_Normal$log2FoldChange[(39332-1)]

# Gene2
TMEM219 <-  'ENSG00000149932'

which(featureCounts[,1] == TMEM219)
# [1] 47534
summary_HER_Normal$padj[(47534-1)]
summary_TNBC_Normal$padj[(47534-1)]
summary_NonTNBC_Normal$padj[(47534-1)]


# Gene3
SPARC <- 'ENSG00000113140'

which(featureCounts[,1] == SPARC)
#[1] 17952
summary_HER_Normal$padj[(17952-1)]
summary_TNBC_Normal$padj[(17952-1)]
summary_NonTNBC_Normal$padj[(17952-1)]

# Gene ontology of relevant genes in the paper

paper_genes <- c(featureCounts[39332,1],featureCounts[47534,1],featureCounts[17952,1])

gene_list <- featureCounts[(2:len_gene),1]

ego_p <- enrichGO(gene = paper_genes,
                universe = gene_list,
                OrgDb = org.Hs.eg.db,
                ont = "ALL",
                keyType = 'ENSEMBL')
###
# Plot Log 2 fold change in selected genes
# First with DESeq2::plotMA
# The with ggplot to highlight genes of our interest
###

DESeq2::plotMA(summary_HER_Normal)

# Create appropriate data frame, we need a column with the fold change
# a column with the mean_base, and a column with the information regarding our interest in the gene

# First comparison based in summary_HER_Normal
folcha <- summary_HER_Normal$log2FoldChange
folcha[is.na(folcha)] = 0

fold_change <- summary_HER_Normal$log2FoldChange

mean_base <- summary_HER_Normal$baseMean

# Characterize the lenght of the vectors used

length(fold_change)
# [1] 60671
# All the genes besides the ones of our interest will be set to 0
interest <- rep(0.5, times=60671)

# Set our genes of interest to 1
positions_of_interest <- c(39332,47534,17952)

interes_fold <- rep(NA, times = 60671)

for(i in 1:(length(positions_of_interest))){
  position <- positions_of_interest[i]
  interes_fold[position]<- summary_HER_Normal$log2FoldChange[position]
}

for(i in 1:(length(positions_of_interest))){
  position <- positions_of_interest[i]
  fold_change[position]<- NA
}

# Create data frame

df <- data.frame(fold_change,mean_base,interes_fold)
  
gg <- ggplot()

gg <- gg +
  geom_point(df, colour = 'cyan3', mapping = aes(x = mean_base, y = fold_change)) + 
  geom_point(df,colour = 'firebrick', mapping = aes(x = mean_base, y = interes_fold)) + 
  xlim(0,1e+05) +
  labs(x = 'Average of the normalized count values', y = 'Log2 fold change')


gg

##########
# 7- Overrepresentation analysis
# List of genes with p values above 1.0e-5, 1.0e-10 and 1.0e-50 respectively
geneDE <- gene_mat[,2]
geneDE1 <-gene_mat1[,2]
geneDE2 <- gene_mat_2[,2]

len_gene <- length(featureCounts[,1]) 

gene_list <- featureCounts[(2:len_gene),1]

#Enriched elements below 1e-5
ego <- enrichGO(gene = geneDE,
                  universe = gene_list,
                  OrgDb = org.Hs.eg.db,
                  ont = "ALL",
                  keyType = 'ENSEMBL')
head(ego)
#Enriched elements below 1e-10
ego1 <- enrichGO(gene = geneDE1,
                universe = gene_list,
                OrgDb = org.Hs.eg.db,
                ont = "ALL",
                keyType = 'ENSEMBL')
head(ego1)

#Enriched element over 1e-50
ego2 <- enrichGO(gene = geneDE2,
                universe = gene_list,
                OrgDb = org.Hs.eg.db,
                ont = "ALL",
                keyType = 'ENSEMBL')
head(ego2)


# Plotting with enrichplot

barplot(ego, x = 'Count', color = 'p.adjust',showCategory=10)
# ?enrichplot::barplot.enrichResult
# ?enrichplot::dotplot

dotplot(ego,showCategory=30)

