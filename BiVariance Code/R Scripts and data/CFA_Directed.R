# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying SEM model based on aspect CFA with directed effects
CFA_Directed_model <-'
 # measurement model
 Attraction =~ M_Atr + X_Atr + F_Atr
 Romanticism =~ M_Rom + X_Rom + F_Rom
 Eroticism =~ M_Ero + X_Ero + F_Ero
 
 # regressions
 Romanticism ~ Attraction
 Eroticism ~ Attraction
 Eroticism ~ Romanticism
 '

# Fitting the model
CFA_Directed_fit <- lavaan(CFA_Directed_model, data, std.lv = TRUE, ordered = TRUE, estimator = "WLSMV")

summary(CFA_Directed_fit, fit.measures = TRUE, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(CFA_Directed_fit),"CFA_Directed_estimates.csv", row.names = TRUE)
write.csv(coef(CFA_Directed_fit),"CFA_Directed_coef.csv", row.names = TRUE)
write.csv(fitMeasures(CFA_Directed_fit,c("chisq","df","pvalue","cfi","tli","RMSEA","SRMR")),"CFA_Directed_fitmeasures.csv", row.names = TRUE)
write.csv(resid(CFA_Directed_fit),"CFA_Directed_residuals.csv", row.names = TRUE)
