# Loading population parameters
popmodel1 <- read.csv("SIM_pop_model1_coef.csv")
popmodel2 <- read.csv("SIM_pop_model2_coef.csv")
popmodel3 <- read.csv("SIM_pop_model3_coef.csv")
popmodel4 <- read.csv("SIM_pop_model4_coef.csv")
popmodel5 <- read.csv("SIM_pop_model5_coef.csv")

# Setting up results dataframe
results <- c("Models","Observations","ConvPer","Chi.Sq","sd_Chi.Sq","Chi.P","sd_Chi.P","CFI","sd_CFI","TLI","sd_TLI","RMSEA","sd_RMSEA","SRMR","sd_SRMR","Coverage")

# Setting for loop conditions
Modeln <- c("model1", "model2", "model3", "model4", "model5")
samplesize <- c(20, 50, 100, 250, 500, 1000)

# Simulation for loop
for (Models in Modeln) {
  for(Observations in samplesize) {

# Loading data       
try(Converge        <- read.csv(paste(Models,sep = "_",Observations,"_PercentConverge.csv")) , silent = TRUE) 
try(Coef            <- read.csv(paste(Models,sep = "_",Observations,"_coef.csv"))            , silent = TRUE)
try(StErr           <- read.csv(paste(Models,sep = "_",Observations,"_se.csv"))              , silent = TRUE) 
try(ModelFit        <- read.csv(paste(Models,sep = "_",Observations,"_fit.csv"))             , silent = TRUE) 


if(Converge[1,2]==0){
  ConvPer   <- 0 
  Chi.Sq    <- 0
  sd_Chi.Sq <- 0
  Chi.P     <- 0
  sd_Chi.P  <- 0
  CFI       <- 0
  sd_CFI    <- 0
  TLI       <- 0
  sd_TLI    <- 0
  RMSEA     <- 0
  sd_RMSEA  <- 0
  SRMR      <- 0
  sd_SRMR   <- 0
  Coverage  <- 0
  

  result <- c(Models,Observations,ConvPer,Chi.Sq,sd_Chi.Sq,Chi.P,sd_Chi.P,CFI,sd_CFI,TLI,sd_TLI,RMSEA,sd_RMSEA,SRMR,sd_SRMR,Coverage)  
}
    else{    
# Loading model specfic population data    
PopCoef <-  read.csv(paste("SIM_pop",sep = "_",Models,"coef.csv")) 
     
# Percentage of converged replications
try(ConvPer       <- Converge[1,2]  , silent = TRUE)      
        
# Fit measures
Chi.Sq        <- mean(ModelFit$chisq.scaled,na.rm = TRUE)
sd_Chi.Sq     <- sd(ModelFit$chisq.scaled,na.rm = TRUE)
Chi.P         <- mean(ModelFit$pvalue.scaled,na.rm = TRUE)
sd_Chi.P      <- sd(ModelFit$pvalue.scaled,na.rm = TRUE)
CFI           <- mean(ModelFit$cfi.scaled,na.rm = TRUE) 
sd_CFI        <- sd(ModelFit$cfi.scaled,na.rm = TRUE)
TLI           <- mean(ModelFit$tli.scaled,na.rm = TRUE)
sd_TLI        <- sd(ModelFit$tli.scaled,na.rm = TRUE)
RMSEA         <- mean(ModelFit$rmsea.scaled,na.rm = TRUE)
sd_RMSEA      <- sd(ModelFit$rmsea.scaled,na.rm = TRUE)
SRMR          <- mean(ModelFit$srmr_bentler,na.rm = TRUE)
sd_SRMR       <- sd(ModelFit$srmr_bentler,na.rm = TRUE)

# Coverage
LCL               <- Coef-StErr 
UCL               <- Coef+StErr
MeanPopCoef       <- colMeans(PopCoef, na.rm = TRUE)
lower_mat         <- as.matrix(LCL)
upper_mat         <- as.matrix(UCL)
covered           <- sweep(lower_mat, 2, MeanPopCoef, "<=") & sweep(upper_mat, 2, MeanPopCoef, ">=")
Coverage          <- mean(colMeans(covered,na.rm = TRUE)*100)
    
result <- c(Models,Observations,ConvPer,Chi.Sq,sd_Chi.Sq,Chi.P,sd_Chi.P,CFI,sd_CFI,TLI,sd_TLI,RMSEA,sd_RMSEA,SRMR,sd_SRMR,Coverage)
        
results <- rbind(results, result)   
    }
  }
}

write.csv(results,"SIM_results.csv")
