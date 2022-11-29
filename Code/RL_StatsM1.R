
library(glmmTMB)
library(multcomp)
library(plyr)
library(dplyr)
library(brms)
library(bayestestR)
library(rstan)
library(foreach)
library(doParallel)
library(emmeans)


set.seed(1000)

cores=detectCores()
number_of_cores_to_use = 4 # Not to overload the machine
cat(paste('number_of_cores_to_use:',number_of_cores_to_use))
cl <- makeCluster(number_of_cores_to_use)
registerDoParallel(cl)

freq <- c('4', '8', '13', '38','N_4','N_8','N_13','N_38' )
fdf <- expand.grid(a = freq)

for (k in 1:8){
  
  #Read data and add column names
  data <- read.csv(sprintf('intramatrixALL_%s.csv', fdf$a[k]), sep=',', header=F)
  colnames(data) <- c("ISPC","Elec1","Elec2","Subject","Condition","Trial")
  
  #First we joint the two dataframes  
  mdl <- read.csv('prederrorM1_data.csv', sep=',', header=T)
  
  #We add identifying columns
  mdl$Condition <- rep(2:3,times=200)
  mdl$Trial <- rep(1:100,each=2,times=36)
  mdl$Dyad <- rep(1:18, each=400)
  
  #We initialize the distinct pairs dataframe
  distinct_pairs <- 
    data %>% 
    select(Elec1, Elec2) %>%
    distinct()
  
  #We repeat the data to match to the distinct electrodes...
  inds <- seq(nrow(mdl)) #...for this purpose we create an index...
  mdl <- mdl[unlist(tapply(inds, ceiling(inds/2), rep, nrow(distinct_pairs))), ]#...create group of 3 rows and repeat by electrode...
  #...and then redo the indexing...
  rownames(mdl) <- 1:nrow(mdl)
  #...erase Condition 1 from data df...
  data <- data[(data$Condition==2) | (data$Condition==3),]
  #...and merge both dataframes using a common index
  data$index <- seq(nrow(data))
  mdl$index <- seq(nrow(mdl))
  data <- merge(data, mdl, by="index")
  #clean dataframe out of duplicate columns and rename
  data <- data[,-c(1,9,11:12)]
  colnames(data) <- c("ISPC","Elec1","Elec2","Subject","Condition","Trial","PredError","QState","Dyad")  
  #Make sure Condition & Dyad columns are informed as a Factor
  data[, 'Condition'] <- as.factor(data[, 'Condition'])

  
  # First level estimation
  #Initiate first level loop, parallel processing of distinct connections
  output <- foreach (i = 1:nrow(distinct_pairs), .packages=c('glmmTMB','emmeans'), 
                     .combine = rbind,
                     .errorhandling="pass",
                     .verbose = T) %dopar% {
                       #Subset data from ongoing connections         
                       dat1 <- subset(data, distinct_pairs[i,]$Elec1 == data$Elec1 & distinct_pairs[i,]$Elec2 == data$Elec2)
                       #Prepare dataframe for next loop iteration
                       df <- data.frame('Elec1'=rep(distinct_pairs[i,]$Elec1,36),'Elec2'=rep(distinct_pairs[i,]$Elec2,36),'PEest'=rep(NA,36),'PEste'=rep(NA,36),'QSest'=rep(NA,36),'QSste'=rep(NA,36))
                       
                       #By-subject (36 Subjects) loop
                       for (j in 1:36){
                         #Subset
                         dat2 <- subset(dat1, dat1$Subject==j)
                         rownames(dat2) <- 1:nrow(dat2)
                         
                         #Model first level GLM with corresponding covariates
                         model1 <- glmmTMB(ISPC ~ Condition * PredError, family=beta_family('logit'), data=dat2)
                         model2 <- glmmTMB(ISPC ~ Condition * QState, family=beta_family('logit'), data=dat2)
                         
                         
                         #Comparisons between slopes of PredError and QState
                         pht1 <- pairs(lstrends(model1, ~Condition, 'PredError'))
                         pht1 <- as.data.frame(pht1)
                         
                         pht2 <- pairs(lstrends(model2, ~Condition, 'QState'))
                         pht2 <- as.data.frame(pht2)
                         
                         #Extraction of contrast 2-3 from the estimates (est) and the standard deviations (ste).
                         PEest <-  pht1[1,2] #Estimate in contrast 2-3 from PE
                         PEste <-  pht1[1,3] #Std dev in contrast 2-3 from PE
                        
                         QSest <-  pht2[1,2] #Estimate in contrast 2-3 from QS
                         QSste <-  pht2[1,3] #Std dev in contrast 2-3 from QS
                         
                         
                         df[j,c('PEest','PEste','QSest','QSste')] <- c(PEest,PEste,QSest,QSste)
                       }
                       output <- df
                     }
  
  #Recoding for the identification of electrodes and adding a connections (con) column
  output$Elec1ID <- recode(output$Elec1, "1"="Fp1","2"="Fp2","3"="F7","4"="F3","5"="Fz","6"="F4","7"="F8","8"="FC5","9"="FC1","10"="FC2","11"="FC6","12"="M1","13"="C3","14"="Cz","15"="C4","16"="M2","17"="CP5","18"="CP1","19"="CP2","20"="CP6","21"="P7","22"="P3","23"="Pz","24"="P4","25"="P8","26"="POz","27"="Oz")
  output$Elec2ID <- recode(output$Elec2, "1"="Fp1","2"="Fp2","3"="F7","4"="F3","5"="Fz","6"="F4","7"="F8","8"="FC5","9"="FC1","10"="FC2","11"="FC6","12"="M1","13"="C3","14"="Cz","15"="C4","16"="M2","17"="CP5","18"="CP1","19"="CP2","20"="CP6","21"="P7","22"="P3","23"="Pz","24"="P4","25"="P8","26"="POz","27"="Oz")
  output$con <- paste(output$Elec1ID, "-",output$Elec2ID)
  
  output <- transform(output, PEest = as.numeric(PEest), PEste = as.numeric(PEste),
                      QSest = as.numeric(QSest), QSste = as.numeric(QSste))#Make sure they are numeric variables
  
  write.csv(output, sprintf('PredErrM1_Lvl1_%s.csv', fdf$a[k]), row.names = FALSE)
  
  
  #Second Level bayesian estimation wich estimates (est) and standard deviations (ste) of conditions/dyads by connections.
  
  #Set prior
  
  bprior <- set_prior("normal(0,10)", class="Intercept") + 
    set_prior("gamma(1,2)", class="sd")
  
  #Bayesian GLM Modelling
  
  bayesPE <- brm(PEest|se(PEste) ~ 1 + (1||con), family=gaussian, data=output, cores=number_of_cores_to_use,
                 chains = 4, inits='0', iter=10000, warmup=1000,
                 control=list(adapt_delta=0.9, max_treedepth = 10), prior = bprior)
  posPE <- as_draws(bayesPE)
  
  bayesQS <- brm(QSest|se(QSste) ~ 1 + (1||con), family=gaussian, data=output, cores=number_of_cores_to_use, 
                 chains = 4, inits='0', iter=10000, warmup=1000,
                 control=list(adapt_delta=0.9, max_treedepth = 10), prior = bprior)
  posQS <- as_draws(bayesQS)
  


  write.csv(posPE, sprintf('M1_PE_Lvl2_%s.csv', fdf$a[k]), row.names = FALSE)
  write.csv(posQS, sprintf('M1_QS_Lvl2_%s.csv', fdf$a[k]), row.names = FALSE)

}


