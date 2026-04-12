# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the model
Path_Ero <-'
# Regressions
M_Ero ~ Inactive + Education + Work + Gym + Social
X_Ero ~ Inactive + Education + Work + Gym + Social
F_Ero ~ Inactive + Education + Work + Gym + Social

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
Path_Ero_fit <- sem(Path_Ero, data)

summary(Path_Ero_fit, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(Path_Ero_fit),"Path_Ero_Estimates.csv", row.names = TRUE)
