# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the model
Path_Gender_Location2 <-'
# Regressions
M ~ Inactive + Education + Work + Gym + Social + M_Z
X ~ Inactive + Education + Work + Gym + Social + X_Z
F ~ Inactive + Education + Work + Gym + Social + F_Z

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
 
 M_Z ~~ Inactive
 M_Z ~~ Education
 M_Z ~~ Gym
 M_Z ~~ Work
 M_Z ~~ Social
 
 X_Z ~~ Inactive
 X_Z ~~ Education
 X_Z ~~ Gym
 X_Z ~~ Work
 X_Z ~~ Social
 
 F_Z ~~ Inactive
 F_Z ~~ Education
 F_Z ~~ Gym
 F_Z ~~ Work
 F_Z ~~ Social
 
 M_Z ~~ X_Z
 M_Z ~~ F_Z
 X_Z ~~ F_Z
'

# Fitting the model
Path_Gender_Location_fit2 <- sem(Path_Gender_Location2, data)

summary(Path_Gender_Location_fit2, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(Path_Gender_Location_fit2),"Path_Gender_Location_Estimates2.csv", row.names = TRUE)
