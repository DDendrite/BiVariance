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
write.csv(parameterestimates(Gender_Correl_fit),"Gender_Correl_estimates.csv", row.names = TRUE)
write.csv(coef(Gender_Correl_fit),"Gender_Correl_coef.csv", row.names = TRUE)
write.csv(fitMeasures(Gender_Correl_fit,c("chisq","df","pvalue","cfi","tli","RMSEA","SRMR")),"Gender_Correl_fitmeasures.csv", row.names = TRUE)
write.csv(resid(Gender_Correl_fit),"Gender_Correl_residuals.csv", row.names = TRUE)
