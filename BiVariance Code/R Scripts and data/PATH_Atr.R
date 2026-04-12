# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the model
Path_Atr <-'
# Regressions
M_Atr ~ Inactive + Education + Work + Gym + Social
X_Atr ~ Inactive + Education + Work + Gym + Social
F_Atr ~ Inactive + Education + Work + Gym + Social

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

# Fitting the model
Path_Atr_fit <- sem(Path_Atr, data)

summary(Path_Atr_fit, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(Path_Atr_fit),"Path_Atr_Estimates.csv", row.names = TRUE)

