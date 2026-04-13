# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying model where location is compared to effect of day before, invariance assumed
PastvsLocationStrict <- '
# Lagged factors
AtrZ =~ eMA*M_Atr_Z + eXA*X_Atr_Z + eFA*F_Atr_Z
RomZ =~ eMF*M_Rom_Z + eXF*X_Rom_Z + eFF*F_Rom_Z
EroZ =~ eML*M_Ero_Z + eXL*X_Ero_Z + eFL*F_Ero_Z

# Contemporaneous factors
Atr0 =~ eMA*M_Atr + eXA*X_Atr + eFA*F_Atr
Rom0 =~ eMF*M_Rom + eXF*X_Rom + eFF*F_Rom
Ero0 =~ eML*M_Ero + eXL*X_Ero + eFL*F_Ero

# Location predicting contemporaneous factors
Atr0 ~ Inactive + Education + Work + Gym + Social 
Rom0 ~ Inactive + Education + Work + Gym + Social 
Ero0 ~ Inactive + Education + Work + Gym + Social 

# Lagged factors predicting contemporaneous factors
Atr0 ~ AtrZ
Rom0 ~ AtrZ + RomZ
Ero0 ~ AtrZ + RomZ + EroZ

# Regressions between contemporaneous factors
Rom0 ~ Atr0
Ero0 ~ Atr0 + Rom0

# Indicator covariances between time
M_Atr ~~ M_Atr_Z
X_Atr ~~ X_Atr_Z
F_Atr ~~ F_Atr_Z
M_Rom ~~ M_Rom_Z
X_Rom ~~ X_Rom_Z
F_Rom ~~ F_Rom_Z
M_Ero ~~ M_Ero_Z
X_Ero ~~ X_Ero_Z
F_Ero ~~ F_Ero_Z

# Covariances among location predictors
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

# Covariances between lagged factors and location
AtrZ ~~ Inactive
AtrZ ~~ Education
AtrZ ~~ Gym
AtrZ ~~ Work
AtrZ ~~ Social
RomZ ~~ Inactive
RomZ ~~ Education
RomZ ~~ Gym
RomZ ~~ Work
RomZ ~~ Social
EroZ ~~ Inactive
EroZ ~~ Education
EroZ ~~ Gym
EroZ ~~ Work
EroZ ~~ Social

# Covariances between lagged factors
AtrZ ~~ RomZ
AtrZ ~~ EroZ
RomZ ~~ EroZ
'

# Fitting the strict model
PastvsLocationStrict_fit <- lavaan(PastvsLocationStrict, data, std.lv = TRUE, ordered = TRUE, estimator = "WLSMV")

summary(PastvsLocationStrict_fit, fit.measures = TRUE, standardized = FALSE)

# Specifying model where location is compared to effect of day before, invariance is not assumed
PastvsLocationRelaxed <- '
# Lagged factors
AtrZ =~ M_Atr_Z + X_Atr_Z + F_Atr_Z
RomZ =~ M_Rom_Z + X_Rom_Z + F_Rom_Z
EroZ =~ M_Ero_Z + X_Ero_Z + F_Ero_Z

# Contemporaneous factors
Atr0 =~ M_Atr + X_Atr + F_Atr
Rom0 =~ M_Rom + X_Rom + F_Rom
Ero0 =~ M_Ero + X_Ero + F_Ero

# Location predicting contemporaneous factors
Atr0 ~ Inactive + Education + Work + Gym + Social 
Rom0 ~ Inactive + Education + Work + Gym + Social 
Ero0 ~ Inactive + Education + Work + Gym + Social 

# Lagged factors predicting contemporaneous factors
Atr0 ~ AtrZ
Rom0 ~ AtrZ + RomZ
Ero0 ~ AtrZ + RomZ + EroZ

# Regressions between contemporaneous factors
Rom0 ~ Atr0
Ero0 ~ Atr0 + Rom0

# Indicator covariances between time
M_Atr ~~ M_Atr_Z
X_Atr ~~ X_Atr_Z
F_Atr ~~ F_Atr_Z
M_Rom ~~ M_Rom_Z
X_Rom ~~ X_Rom_Z
F_Rom ~~ F_Rom_Z
M_Ero ~~ M_Ero_Z
X_Ero ~~ X_Ero_Z
F_Ero ~~ F_Ero_Z

# Covariances among location predictors
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

# Covariances between lagged factors and location
AtrZ ~~ Inactive
AtrZ ~~ Education
AtrZ ~~ Gym
AtrZ ~~ Work
AtrZ ~~ Social
RomZ ~~ Inactive
RomZ ~~ Education
RomZ ~~ Gym
RomZ ~~ Work
RomZ ~~ Social
EroZ ~~ Inactive
EroZ ~~ Education
EroZ ~~ Gym
EroZ ~~ Work
EroZ ~~ Social

# Covariances between lagged factors
AtrZ ~~ RomZ
AtrZ ~~ EroZ
RomZ ~~ EroZ
'

# Fitting the model
PastvsLocationRelaxed_Fit <- lavaan(PastvsLocationRelaxed, data, std.lv = TRUE, ordered = TRUE, estimator = "WLSMV")

summary(PastvsLocationRelaxed_Fit, fit.measures = TRUE, standardized = FALSE)


# Likelihood ratio test
lavTestLRT(PastvsLocationStrict_fit,PastvsLocationRelaxed_Fit,method = "satorra.2000")


# Exporting strict model results
write.csv(parameterestimates(PastvsLocationStrict_fit),"SEM_PastvsLocationStrict_estimates.csv", row.names = TRUE)
write.csv(coef(PastvsLocationStrict_fit),"SEM_PastvsLocationStrict_coef.csv", row.names = TRUE)
write.csv(fitMeasures(PastvsLocationStrict_fit,c("chisq","df","pvalue","cfi","tli","RMSEA","SRMR")),"SEM_PastvsLocationStrict_fitmeasures.csv", row.names = TRUE)
write.csv(resid(PastvsLocationStrict_fit),"SEM_PastvsLocationStrict_residuals.csv", row.names = TRUE)

# Exporting relaxed model results
write.csv(parameterestimates(PastvsLocationRelaxed_Fit),"SEM_PastvsLocationRelaxed_estimates.csv", row.names = TRUE)
write.csv(coef(PastvsLocationRelaxed_Fit),"SEM_PastvsLocationRelaxed_coef.csv", row.names = TRUE)
write.csv(fitMeasures(PastvsLocationRelaxed_Fit,c("chisq","df","pvalue","cfi","tli","RMSEA","SRMR")),"SEM_PastvsLocationRelaxed_fitmeasures.csv", row.names = TRUE)
write.csv(resid(PastvsLocationRelaxed_Fit),"SEM_PastvsLocationRelaxed_residuals.csv", row.names = TRUE)

# Exporting likelihood ratio test results
lrt_result <- lavTestLRT(PastvsLocationStrict_fit,PastvsLocationRelaxed_Fit,method = "satorra.2000")
lrt_df <- as.data.frame(lrt_result)
write.csv(lrt_df, "SEM_Final_Model_lrt_result.csv", row.names = TRUE)
