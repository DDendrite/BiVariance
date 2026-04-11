# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the model
MIMIC_Atr_model <-'
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

# Fitting the model
MIMIC_Atr_fit <- lavaan(MIMIC_Atr_model, data, std.lv = TRUE, ordered = TRUE, estimator = "WLSMV")

summary(MIMIC_Atr_fit, fit.measures = TRUE, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(MIMIC_Atr_fit),"MIMIC_Atr_estimates.csv", row.names = TRUE)
write.csv(coef(MIMIC_Atr_fit),"MIMIC_Atr_coef.csv", row.names = TRUE)
write.csv(fitMeasures(MIMIC_Atr_fit,c("chisq","df","pvalue","cfi","tli","RMSEA","SRMR")),"MIMIC_Atr_fitmeasures.csv", row.names = TRUE)
write.csv(resid(MIMIC_Atr_fit),"MIMIC_Atr_residuals.csv", row.names = TRUE)
