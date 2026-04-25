#Loading libraries
library(lavaan)
library(simsem)
library(dplyr)

# Making this analysis reproducible
set.seed(2429252)

# Variables
nRep <- 1000
samplesize <- 1095

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the analysis model:  
popmodel1 <-'
# measurement model
 Attraction =~ M_Atr + X_Atr + F_Atr

# regressions 
 Attraction ~ Inactive + Education + Work + Gym + Social

# (residual) (co)variances 
 Inactive ~~ Education
 Inactive ~~ Gym
 Inactive ~~ Work
 Inactive ~~ Social
 Education ~~ Gym
 Education ~~ Work
 Education ~~ Social
 Gym ~~ Work
 Gym ~~ Social
 Work ~~ Social
'
#####
popmodel2 <- '
  # Measurement model
  Atr_Z =~ L1*M_Atr_Z + L2*X_Atr_Z + L3*F_Atr_Z
  Atr_0 =~ L1*M_Atr   + L2*X_Atr   + L3*F_Atr
  Atr_B =~ L1*M_Atr_B + L2*X_Atr_B + L3*F_Atr_B
  Atr_C =~ L1*M_Atr_C + L2*X_Atr_C + L3*F_Atr_C

  # Autoregressive paths 
  Atr_0 ~ AR*Atr_Z
  Atr_B ~ AR*Atr_0
  Atr_C ~ AR*Atr_B

  # Correlated residuals across lags for each indicator
  M_Atr_Z ~~ ar1*M_Atr
  M_Atr_Z ~~ ar1*M_Atr_B
  M_Atr_Z ~~ ar1*M_Atr_C
  M_Atr   ~~ ar1*M_Atr_B
  M_Atr   ~~ ar1*M_Atr_C
  M_Atr_B ~~ ar1*M_Atr_C
  
  X_Atr_Z ~~ ar2*X_Atr
  X_Atr_Z ~~ ar2*X_Atr_B
  X_Atr_Z ~~ ar2*X_Atr_C
  X_Atr   ~~ ar2*X_Atr_B
  X_Atr   ~~ ar2*X_Atr_C
  X_Atr_B ~~ ar2*X_Atr_C
 
  F_Atr_Z ~~ ar3*F_Atr
  F_Atr_Z ~~ ar3*F_Atr_B
  F_Atr_Z ~~ ar3*F_Atr_C
  F_Atr   ~~ ar3*F_Atr_B
  F_Atr   ~~ ar3*F_Atr_C
  F_Atr_B ~~ ar3*F_Atr_C
'
#####
popmodel3 <- '
 Attraction =~ M_Atr + X_Atr + F_Atr
 Romanticism =~ M_Rom + X_Rom + F_Rom
 Eroticism =~ M_Ero + X_Ero + F_Ero
 
 Romanticism ~~ Attraction
 Eroticism ~~ Attraction
 Eroticism ~~ Romanticism
'
#####
popmodel4 <- '
# measurement model
 Attraction =~ M_Atr + X_Atr + F_Atr
 Romanticism =~ M_Rom + X_Rom + F_Rom
 Eroticism =~ M_Ero + X_Ero + F_Ero

 # regressions 
 Romanticism ~ Inactive + Education + Work + Gym + Social 
 Eroticism ~ Inactive + Education + Work + Gym + Social
 Attraction ~ Inactive + Education + Work + Gym + Social
 
 Romanticism ~ Attraction
 Eroticism ~ Attraction
 Eroticism ~ Romanticism

# (residual) (co)variances 
 Inactive ~~ Education
 Inactive ~~ Gym
 Inactive ~~ Work
 Inactive ~~ Social
 Education ~~ Gym
 Education ~~ Work
 Education ~~ Social
 Gym ~~ Work
 Gym ~~ Social
 Work ~~ Social
 Romanticism ~ Attraction
 Eroticism ~ Attraction
 Eroticism ~ Romanticism
'
#####
popmodel5 <- '
# Lagged factors
AtrZ =~ M_Atr_Z + X_Atr_Z + F_Atr_Z
RomZ =~ M_Rom_Z + X_Rom_Z + F_Rom_Z
EroZ =~ M_Ero_Z + X_Ero_Z + F_Ero_Z

# Contemporaneous factors
Atr0 =~ M_Atr + X_Atr + F_Atr
Rom0 =~ M_Rom + X_Rom + F_Rom
Ero0 =~ M_Ero + X_Ero + F_Ero

# Location predicting contemporaneous factors
Atr0 ~ Inactive + Education + Work + Gym + Social 
Rom0 ~ Inactive + Education + Work + Gym + Social 
Ero0 ~ Inactive + Education + Work + Gym + Social 

# Lagged factors predicting contemporaneous factors
Atr0 ~ AtrZ
Rom0 ~ AtrZ + RomZ
Ero0 ~ AtrZ + RomZ + EroZ

# Regressions between contemporaneous factors
Rom0 ~ Atr0
Ero0 ~ Atr0 + Rom0

# Indicator covariances between time
M_Atr ~~ M_Atr_Z
X_Atr ~~ X_Atr_Z
F_Atr ~~ F_Atr_Z
M_Rom ~~ M_Rom_Z
X_Rom ~~ X_Rom_Z
F_Rom ~~ F_Rom_Z
M_Ero ~~ M_Ero_Z
X_Ero ~~ X_Ero_Z
F_Ero ~~ F_Ero_Z

# Covariances among location predictors
Inactive ~~ Education
Inactive ~~ Gym
Inactive ~~ Work
Inactive ~~ Social
Education ~~ Gym
Education ~~ Work
Education ~~ Social
Gym ~~ Work
Gym ~~ Social
Work ~~ Social

# Covariances between lagged factors and location
AtrZ ~~ Inactive
AtrZ ~~ Education
AtrZ ~~ Gym
AtrZ ~~ Work
AtrZ ~~ Social
RomZ ~~ Inactive
RomZ ~~ Education
RomZ ~~ Gym
RomZ ~~ Work
RomZ ~~ Social
EroZ ~~ Inactive
EroZ ~~ Education
EroZ ~~ Gym
EroZ ~~ Work
EroZ ~~ Social

# Covariances between lagged factors
AtrZ ~~ RomZ
AtrZ ~~ EroZ
RomZ ~~ EroZ
'

# Use simsem to simulate and analyze multiple data sets
pop1_data <- sim(nRep = nRep, popmodel1, n = samplesize, rawData = data, lavaanfun = "lavaan", std.lv = TRUE,ordered = TRUE , estimator = "WLSMV")
pop2_data <- sim(nRep = nRep, popmodel2, n = samplesize, rawData = data, lavaanfun = "lavaan", std.lv = TRUE,ordered = TRUE , estimator = "WLSMV")
pop3_data <- sim(nRep = nRep, popmodel3, n = samplesize, rawData = data, lavaanfun = "lavaan", std.lv = TRUE,ordered = TRUE , estimator = "WLSMV")
pop4_data <- sim(nRep = nRep, popmodel4, n = samplesize, rawData = data, lavaanfun = "lavaan", std.lv = TRUE,ordered = TRUE , estimator = "WLSMV")
pop5_data <- sim(nRep = nRep, popmodel5, n = samplesize, rawData = data, lavaanfun = "lavaan", std.lv = TRUE,ordered = TRUE , estimator = "WLSMV")

# Write fit data to CSV file
write.csv(pop1_data@coef,"SIM_pop_model1_coef.csv")
write.csv(pop2_data@coef,"SIM_pop_model2_coef.csv")
write.csv(pop3_data@coef,"SIM_pop_model3_coef.csv")
write.csv(pop4_data@coef,"SIM_pop_model4_coef.csv")
write.csv(pop5_data@coef,"SIM_pop_model5_coef.csv")

