
library(tidyverse)


hypothesys <- c('NEW1','NEW','NEWBhv1','NEWBhv','NEWAdjH','NEWAdjL')
datatype <- c('dyadmatrixALL', 'intramatrixALL')
freq <- c('4', '8', '13', '38','N_4','N_8','N_13','N_38' )

hyp <- expand.grid(a = hypothesys)
dty <- expand.grid(a = datatype)
fdf <- expand.grid(a = freq)

for (h in 1:nrow(hyp)){
  for (d in 1:nrow(dty)){
    for (f in 1:nrow(fdf)){
    
      net <- read.csv(sprintf('%s_Results_%s_%s.csv', hyp$a[h], dty$a[d], fdf$a[f]), sep=',', header=TRUE)
      ord <- read.csv("~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/NEW/order.csv", sep = ';', header= FALSE)
      colnames(ord) <- c('Elec1','Elec2','Order','Connection')
  
      net$Connection <- str_replace(net$Connection, "[[:punct:][:blank:]]+", ":")
      net$Elec1 <- gsub('(.*):.*','\\1',net$Connection)#Extract Elec1
      net$Elec2 <- gsub('.*:(.*)','\\1',net$Connection)#EXtract Elec2
  
      #Extract mastoids M1-M2
      net <- net[!(net$Elec1 == 'M1'|net$Elec2 == 'M1'),]
      net <- net[!(net$Elec1 == 'M2'|net$Elec2 == 'M2'),]
  
      net <- merge(net, ord)
      net <- net[order(net$Order),]
      rownames(net) <- 1:nrow(net)
      net <- net[net$Null_Hyp==FALSE,]
  
      final_net <- net[,c(2:3)]
      final_net$Elec1 <- recode(final_net$Elec1, "Fp1"=1, "Fp2"=2, "F7"=3, "F3"=4, "Fz"=5, "F4"=6, "F8"=7,"FC5"=8, "FC1"=9, "FC2"=10, "FC6"=11, "C3"=12, 
                                "Cz"=13, "C4"=14, "CP5"=15, "CP1"=16, "CP2"=17, "CP6"=18, "P7"=19, "P3"=20, "Pz"=21, "P4"=22, "P8"=23, "POz"=24, "Oz"=25)
      final_net$Elec2 <- recode(final_net$Elec2, "Fp1"=1, "Fp2"=2, "F7"=3, "F3"=4, "Fz"=5, "F4"=6, "F8"=7,"FC5"=8, "FC1"=9, "FC2"=10, "FC6"=11, "C3"=12, 
                                "Cz"=13, "C4"=14, "CP5"=15, "CP1"=16, "CP2"=17, "CP6"=18, "P7"=19, "P3"=20, "Pz"=21, "P4"=22, "P8"=23, "POz"=24, "Oz"=25)
  
        if (nrow(final_net) > 0){
          write.csv(final_net, sprintf('lines_%s_%s_%s.csv', hyp$a[h], dty$a[d], fdf$a[f]), row.names=FALSE)
        }else{
          next
        }
    }
  }
}