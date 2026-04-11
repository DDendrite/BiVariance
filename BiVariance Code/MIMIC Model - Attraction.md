Tags: #MIMIC
# Multiple Indicator Multiple Cause Model of location on Attraction
# Lavaan syntax
```
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
```
# Path diagram

# Remarks
The model fits well. The model suggests staying at home or going to work is associated with a decrease in attraction, while suggesting that going to social spaces increases attraction. Attraction to people of non-binary people or androgyny loads poorly on attraction, this might due to overall lower frequency compared to attraction to men and women.
# Model output

# R Code snippet
![[MIMIC_Atr_model.R]]
# Generated data
![[MIMIC_Atr_coef.csv]]
![[MIMIC_Atr_estimates.csv]]
![[MIMIC_Atr_fitmeasures.csv]]
![[MIMIC_Atr_residuals.csv]]
