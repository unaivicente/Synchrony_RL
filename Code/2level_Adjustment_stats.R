
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


#Prepare data options
datatype <- c('dyadmatrixALL', 'intramatrixALL')
dty <- expand.grid(a = datatype)

freq <- c('4', '8', '13', '38')
fdf <- expand.grid(a = freq)

# Setup parallel backend to use all processor cores except 1
cores=detectCores()
number_of_cores_to_use = 4 # Not to overload the machine
cat(paste('number_of_cores_to_use:',number_of_cores_to_use))
cl <- makeCluster(number_of_cores_to_use)
registerDoParallel(cl)


#Iteration loop datatype->frequency->connection->subject
for (h in 1:2){
  for (k in 1:4){
    #Read data and add column names
    data <- read.csv(sprintf('Adj_%s_%s.csv', dty$a[h], fdf$a[k]), sep=',', header=T)
    #Replace NaN with NA
    is.nan.data.frame <- function(x)
      do.call(cbind, lapply(x, is.nan))
    data[is.nan(data)] <- NA
    #Make sure Condition is a Factor
    data[, 'Condition'] <- as.factor(data[, 'Condition'])
    # Make a dataframe with all the distinct connection combinations
    distinct_pairs <- 
      data %>% 
      select(Elec1, Elec2) %>%
      distinct()
    
    
    # First level estimation
    
    #Initiate first level loop, parallelize connections
    output <- foreach (i = 1:nrow(distinct_pairs), .packages=c('glmmTMB','emmeans'), 
                       .combine = rbind,
                       .errorhandling="pass",
                       .verbose = T) %dopar% {
                         #Subset data from ongoing connections         
                         dat1 <- subset(data, distinct_pairs[i,]$Elec1 == data$Elec1 & distinct_pairs[i,]$Elec2 == data$Elec2)
                         #Prepare dataframe for next loop
                         df <- data.frame('Elec1'=rep(distinct_pairs[i,]$Elec1,h*18),'Elec2'=rep(distinct_pairs[i,]$Elec2,h*18),'estH'=rep(NA,h*18),'steH'=rep(NA,h*18),'estL'=rep(NA,h*18),'steL'=rep(NA,h*18))
                         #By-subject/dyad loop
                         #h operator comes from first loop (data type: inter/intra) 18 dyads and 36 subjects.
                         for (j in 1:(18*h)){
                           #Subsetting
                           dat2 <- subset(dat1, dat1$Suj_Dyad==j)
                           #Modelling
                           model <- glmmTMB(ISPC ~ Condition*Adjustment, family=beta_family('logit'), data=dat2)
                           
                           # comparisons between slopes
                           phm <- pairs(lsmeans(model, ~Condition*Adjustment))
                           phm <- as.data.frame(phm)
                           
                           #Extraction of contrast 2-3 from the estimates (est) and the standard deviations (ste).
                           estH <-  phm[6,2]
                           steH <-  phm[6,3]
                           estL <-  phm[15,2]
                           steL <-  phm[15,3]
                           
                           df[j,c('estH','steH','estL','steL')] <- c(estH,steH,estL,steL)
                           
                           rm(dat2)
                         }
                         output <- df
                       }
    
    
    
    #Recoding for the identification of electrodes and adding a connections (con) column
    output$Elec1ID <- recode(output$Elec1, "1"="Fp1","2"="Fp2","3"="F7","4"="F3","5"="Fz","6"="F4","7"="F8","8"="FC5","9"="FC1","10"="FC2","11"="FC6","12"="M1","13"="C3","14"="Cz","15"="C4","16"="M2","17"="CP5","18"="CP1","19"="CP2","20"="CP6","21"="P7","22"="P3","23"="Pz","24"="P4","25"="P8","26"="POz","27"="Oz")
    output$Elec2ID <- recode(output$Elec2, "1"="Fp1","2"="Fp2","3"="F7","4"="F3","5"="Fz","6"="F4","7"="F8","8"="FC5","9"="FC1","10"="FC2","11"="FC6","12"="M1","13"="C3","14"="Cz","15"="C4","16"="M2","17"="CP5","18"="CP1","19"="CP2","20"="CP6","21"="P7","22"="P3","23"="Pz","24"="P4","25"="P8","26"="POz","27"="Oz")
    
    output$con <- paste(output$Elec1ID, "-",output$Elec2ID)
    
    output <- transform(output, estH = as.numeric(estH), steH = as.numeric(steH), estL = as.numeric(estL), steL = as.numeric(steL))
    
    write.csv(output, sprintf('NEWAdj_Lvl1_%s_%s.csv', dty$a[h], fdf$a[k]), row.names = FALSE)
    
    #Second Level bayesian estimation wich estimates (est) and standard deviations (ste) of conditions/dyads by connections.
    
    #Set prior
    
    bprior <- set_prior("normal(0,10)", class="Intercept") + 
      set_prior("gamma(1,2)", class="sd")
    
    #Modelling
    
    
    bayesH <- brm(estH|se(steH) ~ 1 + (1||con), family=gaussian, data=output, cores=4,chains=4, 
                  inits='0', iter=10000, warmup=1000, control=list(adapt_delta=0.9), prior = bprior)
    posH <- as_draws(bayesH)
    
    bayesL <- brm(estL|se(steL) ~ 1 + (1||con), family=gaussian, data=output, cores=4, chains=4,
                  inits='0', iter=10000, warmup=1000, control=list(adapt_delta=0.9), prior = bprior)
    posL <- as_draws(bayesL)
    
    write.csv(posH, sprintf('NEWAdjH_Lvl2_%s_%s.csv', dty$a[h], fdf$a[k]), row.names = FALSE)
    write.csv(posL, sprintf('NEWAdjL_Lvl2_%s_%s.csv', dty$a[h], fdf$a[k]), row.names = FALSE)
    
    rm(distinct_pairs)
  }
}



