

library(plyr)
library(dplyr)
library(stringr)
library(bayestestR)

#Prepare data options
datatype <- c('dyadmatrixALL', 'intramatrixALL')
dty <- expand.grid(a = datatype)

freq <- c('4', '8', '13', '38')
fdf <- expand.grid(a = freq)


for (h in 1:2){
  for (k in 1:4){
    postsamp <- read.csv(sprintf('NEW2Lvl2_%s_%s.csv', dty$a[h], fdf$a[k]), sep=',', header=TRUE)
    firstlev <- read.csv(sprintf('NEW2Lvl1_%s_%s.csv', dty$a[h], fdf$a[k]), sep=',', header=TRUE)
    
    
    
    #Generate a dataframe with all connection combinations
    con <- as.data.frame(names(postsamp))
    ifelse(h==1, con<-con[4:732,], con<-con[4:354,])
    con <- as.data.frame(gsub("^X1.r_con.([^,]+).Intercept.", "\\1", con))#leaves electrode connections in the string
    colnames(con) <- c("Connections")
    con$Connections <- as.character(con$Connections)
    
    #Subset General Effects
    if (h==1){
    b0_int1 <- postsamp[,1] #Main intercept posterior
    b0_int2 <- postsamp[,734]
    b0_int3 <- postsamp[,1467]
    b0_int4 <- postsamp[,2200]
    b0_meff <- c(b0_int1,b0_int2,b0_int3,b0_int4)
    
    }else{
    
    b0_int1 <- postsamp[,1] #Main intercept posterior
    b0_int2 <- postsamp[,356]
    b0_int3 <- postsamp[,711]
    b0_int4 <- postsamp[,1066]
    b0_meff <- c(b0_int1,b0_int2,b0_int3,b0_int4)
    
    }
    
    output <- data.frame('ROPE_Equivalence'=rep(NA,nrow(con)),'HDI_low'=rep(NA,nrow(con)),'HDI_high'=rep(NA,nrow(con)),'Hypothesis'=rep(NA,nrow(con)),'Connection'=rep(NA,nrow(con)))
    

    for(i in 1:(nrow(con))){
      subdf_con <- postsamp[grepl(con[i,], names(postsamp))]#Because the Markov process had 4 chains, there are 4 posteriors, so we put them all together
      subdf_con <- data.frame(y=unlist(subdf_con))
      rownames(subdf_con) <- 1:nrow(subdf_con)
      b0_con <- subdf_con
      #We add the main intercept with the connection intercept for the hypothesis
      var_hyp1 <- b0_meff + b0_con
      
      hyp1test <- equivalence_test(var_hyp1, ci=(.95), range=c(-.01,.01)*sd(firstlev$est))
      
      hyp1test$Hypothesys <- sprintf('%s: Freq %s',  dty$a[h], fdf$a[k])
      hyp1test$Connection <- sprintf('%s',con[i,])
      
      dat <- hyp1test[,6:10]
      output[i,c('ROPE_Equivalence','HDI_low','HDI_high','Hypothesis','Connection')] <- dat
    }
    output <- output %>% mutate(Null_Hyp = 0 >= HDI_low & 0 <= HDI_high)
    output$Frequency <- sprintf('%s_%s', dty$a[h], fdf$a[k])
    
    write.csv(output, sprintf('NEW2_Results_%s_%s.csv', dty$a[h], fdf$a[k]), row.names = FALSE)
  }
}






