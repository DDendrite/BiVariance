# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the model
Path_Rom <-'
# Regressions
M_Rom ~ Inactive + Education + Work + Gym + Social
X_Rom ~ Inactive + Education + Work + Gym + Social
F_Rom ~ Inactive + Education + Work + Gym + Social

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
Path_Rom_fit <- sem(Path_Rom, data)

summary(Path_Rom_fit, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(Path_Rom_fit),"Path_Rom_Estimates.csv", row.names = TRUE)
