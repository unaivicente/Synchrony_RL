library(glmmTMB)
library(plyr)
library(dplyr)
library(brms)
library(bayestestR)
library(rstan)
library(foreach)
library(doParallel)
library(pushoverr)
library(emmeans)

set.seed(1000)

#Prepare data options
datatype <- c('dyadmatrixALL', 'intramatrixALL')
dty <- expand.grid(a = datatype)

freq <- c('4', '8', '13', '38','N_4','N_8','N_13','N_38' )
fdf <- expand.grid(a = freq)

# Setup parallel backend to use all processor cores except 1
cores=detectCores()
number_of_cores_to_use = cores[1]-1 # Not to overload the machine
cat(paste('number_of_cores_to_use:',number_of_cores_to_use))
cl <- makeCluster(number_of_cores_to_use)
registerDoParallel(cl)


#Iteration loop datatype->frequency->connection->subject
for (h in 1:2){
  for (k in 1:8){
  #Read data and add column names
  data <- read.csv(sprintf('%s_%s.csv', dty$a[h], fdf$a[k]), sep=',', header=F)
  colnames(data) <- c("ISPC","Elec1","Elec2","Suj_Dyad","Condition","Trial")
  #Replace NaN with NA
  data[sapply(data, is.nan)] <- NA
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
      df <- data.frame('Elec1'=rep(distinct_pairs[i,]$Elec1,h*18),'Elec2'=rep(distinct_pairs[i,]$Elec2,h*18),'est'=rep(NA,h*18),'ste'=rep(NA,h*18))
  
      #By-subject/dyad loop
      #h operator comes from first loop (data type: inter/intra) 18 dyads and 36 subjects.
            for (j in 1:(18*h)){
        #Subsetting
            dat2 <- subset(dat1, dat1$Suj_Dyad==j)
        #Modelling
            model <- glmmTMB(ISPC ~ Condition, family=beta_family('logit'), data=dat2)
        
        # comparisons between conditions
            phm <- pairs(lsmeans(model, ~Condition))
            phm <- as.data.frame(phm)
        
        #Extraction of contrast 2-3 from the estimates (est) and the standard deviations (ste).
            est <-  phm[3,2]
            ste <-  phm[3,3]
            df[j,c('est','ste')] <- c(est,ste)
            rm(dat2)
            }
        output <- df
        }
    
  #Recoding for the identification of electrodes and adding a connections (con) column
  output$Elec1ID <- recode(output$Elec1, "1"="Fp1","2"="Fp2","3"="F7","4"="F3","5"="Fz","6"="F4","7"="F8","8"="FC5","9"="FC1","10"="FC2","11"="FC6","12"="M1","13"="C3","14"="Cz","15"="C4","16"="M2","17"="CP5","18"="CP1","19"="CP2","20"="CP6","21"="P7","22"="P3","23"="Pz","24"="P4","25"="P8","26"="POz","27"="Oz")
  output$Elec2ID <- recode(output$Elec2, "1"="Fp1","2"="Fp2","3"="F7","4"="F3","5"="Fz","6"="F4","7"="F8","8"="FC5","9"="FC1","10"="FC2","11"="FC6","12"="M1","13"="C3","14"="Cz","15"="C4","16"="M2","17"="CP5","18"="CP1","19"="CP2","20"="CP6","21"="P7","22"="P3","23"="Pz","24"="P4","25"="P8","26"="POz","27"="Oz")
  output$con <- paste(output$Elec1ID, "-",output$Elec2ID)
  output <- transform(output, est = as.numeric(est), ste = as.numeric(ste))
  
  write.csv(output, sprintf('NEWLvl1_%s_%s.csv', dty$a[h], fdf$a[k]), row.names = FALSE)
  
  #Set prior
  
  bprior <- set_prior("normal(0,10)", class="Intercept") + 
    set_prior("gamma(1,2)", class="sd")
  
  #Second Level bayesian estimation wich estimates (est) and standard deviations (ste) of conditions/dyads by connections.

  bayes <- brm(est|se(ste) ~ 1 + (1|con), family=gaussian, data=output, cores=number_of_cores_to_use, inits='0', iter=6000, 
               warmup=2000, control=list(adapt_delta=0.9), prior = bprior)
  pos <- posterior_samples(bayes)

  write.csv(pos, sprintf('NEWLvl2_%s_%s.csv', dty$a[h], fdf$a[k]), row.names = FALSE)
  rm(distinct_pairs)
  }
}


pushover('Stats Processed 0-500', user = "u2yje7zfuhi3rzs4zwpkrostp6wrdj", app = "a36jriy3tey1gddfh1yzetjjy2bhxy")    