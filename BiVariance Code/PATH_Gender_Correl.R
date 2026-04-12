# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying same day correlations
Gender_Correl <- '
M ~ X
M ~ F
X ~ F
'

# Fitting the models
Gender_Correl_fit <- sem(Gender_Correl, data)

summary(Gender_Correl_fit, standardized = TRUE)

# Exporting model results
write.csv(parameterestimates(Gender_Correl_fit),"PATH_Gender_Correl_Estimates.csv", row.names = TRUE)
