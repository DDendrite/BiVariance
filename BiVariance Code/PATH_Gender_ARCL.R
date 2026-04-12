# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying AR1 effects of gender
Path_Gender_ARCL <- '
# Regression
M ~ M_Z + X_Z + F_Z
X ~ M_Z + X_Z + F_Z
F ~ M_Z + X_Z + F_Z

M_B ~ M + X + F
X_B ~ M + X + F
F_B ~ M + X + F

M_C ~ M_B + X_B + F_B
X_C ~ M_B + X_B + F_B
F_C ~ M_B + X_B + F_B

# (residual) (co)variances 
M_Z ~~ X_Z
M_Z ~~ F_Z
X_Z ~~ F_Z

M ~~ X
M ~~ F
X ~~ F

M_B ~~ X_B
M_B ~~ F_B
X_B ~~ F_B

M_C ~~ X_C
M_C ~~ F_C
X_C ~~ F_C
'

# Fitting the model
Path_Gender_ARCL_fit <- sem(Path_Gender_ARCL, data)

summary(Path_Gender_ARCL_fit, standardized = FALSE)

# Exporting model results
write.csv(parameterestimates(Path_Gender_ARCL_fit),"Path_Gender_ARCL_Estimates.csv", row.names = TRUE)
