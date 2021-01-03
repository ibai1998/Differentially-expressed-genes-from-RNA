library(ggplot2)

m_alignment <- as.matrix(alignment_rate)

rates <- m_alignment[1,]
groups <- c('HER2','HER2','HER2','NonTNBC','NonTNBC','NonTNBC','TNBC','TNBC','TNBC','Normal','Normal','Normal')
df <- data.frame(rates,groups)
# Statistics 

mean(rates)
summary(rates)
# [1] 91.09833

# Plot dot-plot

gg <- ggplot(data = df, aes(x = groups, y = rates))

gg <- gg +
  theme_bw() +
  
  geom_dotplot(binaxis='y', 
               stackdir='center', 
               dotsize = .5, 
               fill="red") +
  ylim(0,100) + 
  
  labs(y="Overall alignment rate ( % )", x = 'Groups')

gg








