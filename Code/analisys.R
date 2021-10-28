

library(plyr)
library(dplyr)
library(stringr)
library(bayestestR)

#Prepare data options
datatype <- c('dyadmatrixALL', 'intramatrixALL')
dty <- expand.grid(a = datatype)

freq <- c('4', '8', '13', '38','N_4','N_8','N_13','N_38' )
fdf <- expand.grid(a = freq)


datadyad <- list()
dataintra <- list()
data <- list()

for (h in 1:2){
  for (k in 1:8){
    data[[k]] <- read.csv(sprintf('NEW1_Results_%s_%s.csv', dty$a[h], fdf$a[k]), sep=',', header=TRUE)
    if (h==1){
      output <- data[[k]]
      output$Frequency <- freq[k]
      datadyad[[k]] <- output
    }else{
      output <- data[[k]]
      output$Frequency <- freq[k]
      dataintra[[k]] <- output
    }
  }
}



dyad <- rbind(datadyad[[1]],datadyad[[2]],datadyad[[3]],datadyad[[4]],datadyad[[5]],datadyad[[6]],datadyad[[7]],datadyad[[8]])
intra <- rbind(dataintra[[1]],dataintra[[2]],dataintra[[3]],dataintra[[4]],dataintra[[5]],dataintra[[6]],dataintra[[7]],dataintra[[8]])

dyad$Connection <- str_replace(dyad$Connection, "[[:punct:][:blank:]]+", ":")
dyad$Elec1 <- gsub('(.*):.*','\\1',dyad$Connection)#Extract Elec1
dyad$Elec2 <- gsub('.*:(.*)','\\1',dyad$Connection)#EXtract Elec2
intra$Connection <- str_replace(intra$Connection, "[[:punct:][:blank:]]+", ":")
intra$Elec1 <- gsub('(.*):.*','\\1',intra$Connection)#Extract Elec1
intra$Elec2 <- gsub('.*:(.*)','\\1',intra$Connection)#EXtract Elec2

#Extract mastoids M1-M2
dyad <- dyad[!(dyad$Elec1 == 'M1'|dyad$Elec2 == 'M1'),]
dyad <- dyad[!(dyad$Elec1 == 'M2'|dyad$Elec2 == 'M2'),]
intra <- intra[!(intra$Elec1 == 'M1'|intra$Elec2 == 'M1'),]
intra <- intra[!(intra$Elec1 == 'M2'|intra$Elec2 == 'M2'),]


#for HDI global effects
#Dfalse <- dyad[!(dyad$Null_Hypothesis=='Accepted'),]
#Ifalse <- intra[!(intra$Null_Hypothesis=='Accepted'),]

#for the rest of contrast analysis
Dfalse <- dyad[!(dyad$Null_Hyp==TRUE),]
Ifalse <- intra[!(intra$Null_Hyp==TRUE),]

Dfalse <- Dfalse[!(Dfalse$Frequency=='N_4'),]
Dfalse <- Dfalse[!(Dfalse$Frequency=='N_8'),]
Dfalse <- Dfalse[!(Dfalse$Frequency=='N_38'),]
Dfalse <- Dfalse[!(Dfalse$Frequency=='N_13'),]
Ifalse <- Ifalse[!(Ifalse$Frequency=='N_4'),]
Ifalse <- Ifalse[!(Ifalse$Frequency=='N_8'),]
Ifalse <- Ifalse[!(Ifalse$Frequency=='N_38'),]
Ifalse <- Ifalse[!(Ifalse$Frequency=='N_13'),]

