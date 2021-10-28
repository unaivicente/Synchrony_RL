

library(plyr)
library(dplyr)
library(stringr)
library(bayestestR)

#Prepare data options
datatype <- c('dyadmatrixALL', 'intramatrixALL')
dty <- expand.grid(a = datatype)

freq <- c('4', '8', '13', '38','N_4','N_8','N_13','N_38' )
fdf <- expand.grid(a = freq)


for (h in 1:2){
  for (k in 1:8){
    postsamp <- read.csv(sprintf('NEWLvl2_%s_%s.csv', dty$a[h], fdf$a[k]), sep=',', header=TRUE)
    firstlev <- read.csv(sprintf('NEWLvl1_%s_%s.csv', dty$a[h], fdf$a[k]), sep=',', header=TRUE)
    

    
    #Generate a dataframe with all connection combinations
    con <- as.data.frame(names(postsamp))
    con <- as.data.frame(gsub("^r_con.([^,]+).Intercept.", "\\1", con$`names(postsamp)`))#leaves electrode connections in the string
    con <- con[-c(1:3,nrow(con)),] #remove all that isn't a connection
    con <- as.data.frame(con)
    colnames(con) <- c("Connections")
    con$Connections <- as.character(con$Connections)
    
    #Subset General Effects

    b0_geff <- postsamp[,1] #Main intercept posterior
    
    output <- data.frame('HDI_low'=rep(NA,nrow(con)),'HDI_high'=rep(NA,nrow(con)),'Hypothesis'=rep(NA,nrow(con)),'Connection'=rep(NA,nrow(con)))
    
    for(i in 1:(nrow(con))){
      subdf_con <- postsamp[grepl(con[i,], names(postsamp))]
      b0_con <- subdf_con[,1] #Cond1 (Intercept)
      var_hyp1 <- b0_geff + b0_con
      
      hyp1test <- equivalence_test(var_hyp1, ci=(.95), range=c(-.01,.01*sd(firstlev$est)))

      hyp1test$Hypothesys <- "Change among conditions"
      hyp1test$Connection <- sprintf('%s',con[i,])
      
      dat <- rbind(hyp1test)
      dat <- dat[,6:9]
      output[i,c('HDI_low','HDI_high','Hypothesis','Connection')] <- dat
    }
    output <- output %>% mutate(Null_Hyp = 0 >= HDI_low & 0 <= HDI_high)
    output$Frequency <- sprintf('%s_%s', dty$a[h], fdf$a[k])
    
    write.csv(output, sprintf('NEW_Results_%s_%s.csv', dty$a[h], fdf$a[k]), row.names = FALSE)
  }
}






