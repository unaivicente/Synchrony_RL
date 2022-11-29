

library(plyr)
library(dplyr)
library(stringr)
library(bayestestR)


#Prepare data options
freq <- c('4', '8', '13', '38')
fdf <- expand.grid(a = freq)
typ <- c('PE','QS')

for (k in 1:4){
  for (j in 1:2){
      postsamp <- read.csv(sprintf('M1_%s_Lvl2_%s.csv', typ[j], fdf$a[k]), sep=',', header=TRUE)
      firstlev <- read.csv(sprintf('PredErrM1_Lvl1_%s.csv', fdf$a[k]), sep=',', header=TRUE)
      
      #Prepare a condition identifier z
      if (j==1) {z=4} else {z=6}
      
      
      #Generate a dataframe with all connection combinations
      con <- as.data.frame(names(postsamp))
      con <- con[4:354,]
      con <- as.data.frame(gsub("^X1.r_con.([^,]+).Intercept.", "\\1", con))#leaves electrode connections in the string
      colnames(con) <- c("Connections")
      con$Connections <- as.character(con$Connections)
      
      #Subset General Effects
      
      b0_int1 <- postsamp[,1] #Main intercept posterior
      b0_int2 <- postsamp[,356]
      b0_int3 <- postsamp[,711]
      b0_int4 <- postsamp[,1066]
      b0_meff <- c(b0_int1,b0_int2,b0_int3,b0_int4)
      
      
      output <- data.frame('ROPE_Percentage'=rep(NA,nrow(con)),'ROPE_Equivalence'=rep(NA,nrow(con)),'HDI_low'=rep(NA,nrow(con)),'HDI_high'=rep(NA,nrow(con)),'Hypothesis'=rep(NA,nrow(con)),'Connection'=rep(NA,nrow(con)))
                           
      
      for (i in 1:nrow(con)){
        
        subdf_con <- postsamp[grepl(con[i,], names(postsamp))]#Because the Markov process had 4 chains, there are 4 posteriors, so we put them all together
        subdf_con <- data.frame(y=unlist(subdf_con))
        rownames(subdf_con) <- 1:nrow(subdf_con)
        b0_con <- subdf_con
        #We add the main intercept with the connection intercept for the hypothesis
        var_hyp1 <- b0_meff + b0_con
        var_hyp1 <- -var_hyp1 #Permute results (FB2-FB1)
        
        hyp1test <- equivalence_test(var_hyp1, ci=(.95), range=c(-.01,.01)*sd(firstlev[,z]))#we bring the identifier z here to chose the std deviation column
        hyp1test <- as.data.frame(hyp1test)
        
        hyp1test$Hypothesys <- sprintf('%s: Freq %s', typ[j], fdf$a[k])
        hyp1test$Connection <- sprintf('%s',con[i,])
        
        dat <- hyp1test[,5:10]
        output[i,c('ROPE_Percentage','ROPE_Equivalence','HDI_low','HDI_high','Hypothesis','Connection')] <- dat
      }
      write.csv(output, sprintf('M1_PredErr_Results_%s_%s.csv', typ[j], fdf$a[k]), row.names = FALSE)
      
    
  }
}


