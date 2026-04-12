# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the model
MIMIC_Ero_model <-'
# measurement model
 Eroticism =~ M_Ero + X_Ero + F_Ero

# regressions 
 Eroticism ~ Inactive + Education + Work + Gym + Social

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
MIMIC_Ero_fit <- lavaan(MIMIC_Ero_model, data, std.lv = TRUE, ordered = TRUE, estimator = "WLSMV")

summary(MIMIC_Ero_fit, fit.measures = TRUE, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(MIMIC_Ero_fit),"MIMIC_Ero_estimates.csv", row.names = TRUE)
write.csv(coef(MIMIC_Ero_fit),"MIMIC_Ero_coef.csv", row.names = TRUE)
write.csv(fitMeasures(MIMIC_Ero_fit,c("chisq","df","pvalue","cfi","tli","RMSEA","SRMR")),"MIMIC_Ero_fitmeasures.csv", row.names = TRUE)
write.csv(resid(MIMIC_Ero_fit),"MIMIC_Ero_residuals.csv", row.names = TRUE)
