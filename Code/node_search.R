#All in ALLDATA

#setwd("~~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/0-500ms")
#freq <- read.csv("HDI_dyadmatrixALL_N_13.csv", header = TRUE, sep = ",") #BETA
#setwd("~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/0-500ms")
#freq <- read.csv("HDI_dyadmatrixALL_13.csv", header = TRUE, sep = ",") #BETA NO ERP

#setwd("~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/500-1000ms")
#freq <- read.csv("HDI_dyadmatrixALL_N_38.csv", header = TRUE, sep = ",") #GAMMA
#setwd("~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/500-1000ms")
#freq <- read.csv("HDI_dyadmatrixALL_38.csv", header = TRUE, sep = ",") #GAMMA NO ERP

setwd("~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/0-500ms")
freq <- read.csv("HDI_dyadmatrixALL_N_4.csv", header = TRUE, sep = ",") #THETA ALL DATA



library(dplyr)

freq$Elec1 <- gsub('(.*):.*','\\1',freq$Connections)
freq$Elec2 <- gsub('.*:(.*)','\\1',freq$Connections)

freq <- freq[freq$Null_Hypothesis == 'Rejected',]
#Extract mastoids M1-M2
freq <- freq[!(freq$Elec1 == 'M1'|freq$Elec2 == 'M1'),]
freq <- freq[!(freq$Elec1 == 'M2'|freq$Elec2 == 'M2'),]

el1 <- as.data.frame(table(freq$Elec1))
el1$Var <- recode(el1$Var1, "Fp1"=1, "Fp2"=2, "F7"=3, "F3"=4, "Fz"=5, "F4"=6, "F8"=7,"FC5"=8, "FC1"=9, "FC2"=10, "FC6"=11, "C3"=12, "Cz"=13, "C4"=14, "CP5"=15, "CP1"=16, "CP2"=17, "CP6"=18, "P7"=19, "P3"=20, "Pz"=21, "P4"=22, "P8"=23, "POz"=24, "Oz"=25)
colnames(el1) <- c("Var1","Freq1","Var")
el2 <- as.data.frame(table(freq$Elec2))
el2$Var <- recode(el1$Var1, "Fp1"=1, "Fp2"=2, "F7"=3, "F3"=4, "Fz"=5, "F4"=6, "F8"=7,"FC5"=8, "FC1"=9, "FC2"=10, "FC6"=11, "C3"=12, "Cz"=13, "C4"=14, "CP5"=15, "CP1"=16, "CP2"=17, "CP6"=18, "P7"=19, "P3"=20, "Pz"=21, "P4"=22, "P8"=23, "POz"=24, "Oz"=25)
colnames(el2) <- c("Var1","Freq2","Var")


eltest <- merge(el1,el2)
eltest$Sum <- eltest$Freq1+eltest$Freq2
eltest$Avg <- (eltest$Freq1+eltest$Freq2)/2
eltest <- eltest[,c("Var", "Var1", "Freq1", "Freq2", "Sum", "Avg")]
eltest <- eltest[order(eltest$Var),c(1:6)]










#write.csv(eltest, "~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/beta.csv",row.names=FALSE)
#write.csv(eltest, "~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/beta_NOERP.csv",row.names=FALSE)
#write.csv(eltest, "~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/gamma.csv",row.names=FALSE)
#write.csv(eltest, "~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/gamma_NOERP.csv",row.names=FALSE)

write.csv(eltest, "~/Google Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/Synch March2021/theta_NOERP.csv",row.names=FALSE)
