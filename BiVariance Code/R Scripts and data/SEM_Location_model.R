# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the model
SEM_Location <-'
# measurement model
 Attraction =~ M_Atr + X_Atr + F_Atr
 Romanticism =~ M_Rom + X_Rom + F_Rom
 Eroticism =~ M_Ero + X_Ero + F_Ero

 # regressions 
 Romanticism ~ Inactive + Education + Work + Gym + Social 
 Eroticism ~ Inactive + Education + Work + Gym + Social
 Attraction ~ Inactive + Education + Work + Gym + Social
 
 Romanticism ~ Attraction
 Eroticism ~ Attraction
 Eroticism ~ Romanticism

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
 Romanticism ~ Attraction
 Eroticism ~ Attraction
 Eroticism ~ Romanticism
'

# Fitting the model
Location_fit <- lavaan(SEM_Location, data, std.lv = TRUE, ordered = TRUE, estimator = "WLSMV")

summary(Location_fit, fit.measures = TRUE, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(Location_fit),"SEM_Location_estimates.csv", row.names = TRUE)
write.csv(coef(Location_fit),"SEM_Location_coef.csv", row.names = TRUE)
write.csv(fitMeasures(Location_fit,c("chisq","df","pvalue","cfi","tli","RMSEA","SRMR")),"SEM_Location_fitmeasures.csv", row.names = TRUE)
write.csv(resid(Location_fit),"SEM_Location_residuals.csv", row.names = TRUE)
