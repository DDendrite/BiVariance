# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying CFA model with aspect based factors
CFA_Aspect_model <-'
 Attraction =~ M_Atr + X_Atr + F_Atr
 Romanticism =~ M_Rom + X_Rom + F_Rom
 Eroticism =~ M_Ero + X_Ero + F_Ero
 
 Romanticism ~~ Attraction
 Eroticism ~~ Attraction
 Eroticism ~~ Romanticism
 '

# Fitting the model
CFA_Aspect_fit <- lavaan(CFA_Aspect_model, data, std.lv = TRUE, ordered = TRUE, estimator = "WLSMV")

summary(CFA_Aspect_fit, fit.measures = TRUE, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(CFA_Aspect_fit),"CFA_Aspect_estimates.csv", row.names = TRUE)
write.csv(coef(CFA_Aspect_fit),"CFA_Aspect_coef.csv", row.names = TRUE)
write.csv(fitMeasures(CFA_Aspect_fit,c("chisq","df","pvalue","cfi","tli","RMSEA","SRMR")),"CFA_Aspect_fitmeasures.csv", row.names = TRUE)
write.csv(resid(CFA_Aspect_fit),"CFA_Aspect_residuals.csv", row.names = TRUE)
