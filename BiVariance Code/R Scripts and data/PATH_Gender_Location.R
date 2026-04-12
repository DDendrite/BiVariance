# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the model
Path_Gender_Location <-'
# Regressions
M ~ Inactive + Education + Work + Gym + Social
X ~ Inactive + Education + Work + Gym + Social
F ~ Inactive + Education + Work + Gym + Social

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
Path_Gender_Location_fit <- sem(Path_Gender_Location, data)

summary(Path_Gender_Location_fit, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(Path_Gender_Location_fit),"Path_Gender_Location_Estimates.csv", row.names = TRUE)
