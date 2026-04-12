# Loading libraries
library(lavaan)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Specifying the regressions
INTRO_Atr_Social <-'M_Atr ~ Social'
INTRO_Atr_Inactive <-'M_Atr ~ Inactive'
INTRO_Atr_Work <-'M_Atr ~ Work'

# Fitting the regressions
INTRO_Atr_Social_fit <- sem(INTRO_Atr_Social, data)
INTRO_Atr_Inactive_fit <- sem(INTRO_Atr_Inactive, data)
INTRO_Atr_Work_fit <- sem(INTRO_Atr_Work, data)

summary(INTRO_Atr_Social_fit, standardized = FALSE)
summary(INTRO_Atr_Inactive_fit, standardized = FALSE)
summary(INTRO_Atr_Work_fit, standardized = FALSE)

# Table
Intro_Table <- data.frame(
  Estimates =  c(coef(INTRO_Atr_Social_fit)["M_Atr~Social"],coef(INTRO_Atr_Inactive_fit)["M_Atr~Inactive"],coef(INTRO_Atr_Work_fit)["M_Atr~Work"])
)

# Exporting model results
write.csv(Intro_Table,"Path_Intro_Table.csv", row.names = TRUE)

