# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the model
MIMIC_Rom_model <-'
# measurement model
 Romanticism =~ M_Rom + X_Rom + F_Rom

 # regressions 
 Romanticism ~ Inactive + Education + Work + Gym + Social

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
MIMIC_Rom_fit <- lavaan(MIMIC_Rom_model, data, std.lv = TRUE, ordered = TRUE, estimator = "WLSMV")

summary(MIMIC_Rom_fit, fit.measures = TRUE, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(MIMIC_Rom_fit),"MIMIC_Rom_estimates.csv", row.names = TRUE)
write.csv(coef(MIMIC_Rom_fit),"MIMIC_Rom_coef.csv", row.names = TRUE)
write.csv(fitMeasures(MIMIC_Rom_fit,c("chisq","df","pvalue","cfi","tli","RMSEA","SRMR")),"MIMIC_Rom_fitmeasures.csv", row.names = TRUE)
write.csv(resid(MIMIC_Rom_fit),"MIMIC_Rom_residuals.csv", row.names = TRUE)
