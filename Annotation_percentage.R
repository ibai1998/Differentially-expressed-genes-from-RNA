library('ggplot2')

Groups <- c('HER21', 'HER22', 'HER23', 'NonTNBC1','NonTNBC2','NonTNBC3','TNBC1','TNBC2','TNBC3','Normal1','Normal2','Normal3','HER21', 'HER22', 'HER23', 'NonTNBC1','NonTNBC2','NonTNBC3','TNBC1','TNBC2','TNBC3','Normal1','Normal2','Normal3')

pre_counts <- as.matrix(featureCounts.txt)

assigned <- as.numeric(pre_counts[2,2:13])
unmapped <- as.numeric(pre_counts[3,2:13])
multimmaped <-  as.numeric(pre_counts[10,2:13])
no_features <- as.numeric(pre_counts[13,2:13])
ambiguity <- as.numeric(pre_counts[15,2:13])

counts_ <-data.frame(assigned,unmapped,multimmaped,no_features,ambiguity)
 
total <- rep(0,12)

for(i in 1:12){
  total[i] <- sum(counts_[i,])
}

# calculate the percentage of annotated reads per sample

Percenteges <- rep(0,12)

for(i in 1:12){
  Percenteges[i]<- (assigned[i] * 100) / total[i]
}

Definitive_percentage <- append(Percenteges, Percenteges_ambi)
Percenteges_ambi <- rep(0,12)

for(i in 1:12){
  Percenteges_ambi[i]<- (ambiguity[i] * 100) / total[i]
}


# Create vector with assigned and non assigned with ambiguity

Status <- c('Assigned','Assigned','Assigned','Assigned','Assigned','Assigned','Assigned','Assigned','Assigned','Assigned','Assigned','Assigned','Unassigned_Ambiguity','Unassigned_Ambiguity','Unassigned_Ambiguity','Unassigned_Ambiguity','Unassigned_Ambiguity','Unassigned_Ambiguity','Unassigned_Ambiguity','Unassigned_Ambiguity','Unassigned_Ambiguity','Unassigned_Ambiguity','Unassigned_Ambiguity','Unassigned_Ambiguity')

df <- data.frame(Groups,Definitive_percentage , status)

## Plot the percentages ##
gg <- ggplot()

gg <- gg +
  theme_bw() +
  geom_bar(data=df, aes(x = Groups, y = Definitive_percentage,fill = Status), stat='identity')+
  ylim(0,100) +
  ylab('Annotated reads (%)')


gg

mean_HER<-mean(df[13:15,2])
mean_NonTNBC<-mean(df[16:18,2])
mean_TNBC<-mean(df[19:21,2])
mean_Normal<-mean(df[22:24,2])

