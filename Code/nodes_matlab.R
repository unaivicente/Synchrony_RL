library(igraph)
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
      
      netw <- read.csv(sprintf('%s_Results_%s_%s.csv', hyp$a[h], dty$a[d], fdf$a[f]), sep=',', header=TRUE)
      ord <- read.csv("~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/NEW/order.csv", sep = ';', header= FALSE)
      colnames(ord) <- c('Elec1','Elec2','Order','Connection')
      
      netw$Connection <- str_replace(netw$Connection, "[[:punct:][:blank:]]+", ":")
      netw$Elec1 <- gsub('(.*):.*','\\1',netw$Connection)#Extract Elec1
      netw$Elec2 <- gsub('.*:(.*)','\\1',netw$Connection)#EXtract Elec2
      
      #Extract mastoids M1-M2
      netw <- netw[!(netw$Elec1 == 'M1'|netw$Elec2 == 'M1'),]
      netw <- netw[!(netw$Elec1 == 'M2'|netw$Elec2 == 'M2'),]
      
      netw <- merge(netw, ord)
      netw <- netw[order(netw$Order),]
      rownames(netw) <- 1:nrow(netw)
      
      netw$Elec1 <- factor(netw$Elec1, levels = unique(netw$Elec1))
      netw$Elec2 <- factor(netw$Elec2, levels = unique(netw$Elec2))
      
      netw <- netw[,c(2:3,7)]
      netw$Null_Hyp <- !netw$Null_Hyp
      
      # Build the incidence matrix in which the graph will be based
      inc_mat <- xtabs(Null_Hyp ~ ., netw)
      
      # Build graph network
      net <- graph_from_incidence_matrix(inc_mat)
      
      # get vertex labels
      label <- get.vertex.attribute(net, "name")
      degrees <- degree(net)
      nodes <- data.frame(label, degrees)
      
      
      nodes$label <- recode(nodes$label, "Fp1"=1, "Fp2"=2, "F7"=3, "F3"=4, "Fz"=5, "F4"=6, "F8"=7,"FC5"=8, "FC1"=9, "FC2"=10, "FC6"=11, "C3"=12, 
                            "Cz"=13, "C4"=14, "CP5"=15, "CP1"=16, "CP2"=17, "CP6"=18, "P7"=19, "P3"=20, "Pz"=21, "P4"=22, "P8"=23, "POz"=24, "Oz"=25)
      
      if (sum(nodes$degrees) > 0){
        write.csv(nodes, sprintf('nodes_%s_%s_%s.csv', hyp$a[h], dty$a[d], fdf$a[f]), row.names=FALSE)
      }else{
        next
      }
    }
  }
}