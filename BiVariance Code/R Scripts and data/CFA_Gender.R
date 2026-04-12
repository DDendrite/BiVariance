# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying CFA model with gender based factors
CFA_Gender_model <-'
# measurement model
 Masculine =~ M_Atr + M_Rom + M_Ero
 Androgynous =~ X_Atr + X_Rom + F_Ero
 Feminine =~ F_Atr + X_Rom + F_Ero
 
# (residual) (co)variances 
Masculine ~~ Androgynous
Masculine ~~ Feminine
Androgynous ~~ Feminine
'

# Fitting the model
CFA_Gender_fit <- lavaan(CFA_Gender_model, data, std.lv = TRUE, ordered = TRUE, estimator = "WLSMV")

summary(CFA_Gender_fit, fit.measures = TRUE, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(CFA_Gender_fit),"CFA_Gender_estimates.csv", row.names = TRUE)
write.csv(coef(CFA_Gender_fit),"CFA_Gender_coef.csv", row.names = TRUE)
write.csv(fitMeasures(CFA_Gender_fit,c("chisq","df","pvalue","cfi","tli","RMSEA","SRMR")),"CFA_Gender_fitmeasures.csv", row.names = TRUE)
write.csv(resid(CFA_Gender_fit),"CFA_Gender_residuals.csv", row.names = TRUE)
