# Multiple Indicator Multiple Cause Model of location on Eroticism
# Lavaan syntax
```
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
```
# Path diagram

# Remarks
Model fits well. Eroticism has noticeably low loadings across genders. The model suggests staying at home is associated with an increase in eroticism. The same applies to going to the gym but in a lower extent. Attending college shows a decrease in eroticism.
# R Code snippet
![[MIMIC_Ero_model.R]]
# Generated data
![[MIMIC_Ero_coef.csv]]
![[MIMIC_Ero_estimates.csv]]
![[MIMIC_Ero_fitmeasures.csv]]
![[MIMIC_Ero_residuals.csv]]
