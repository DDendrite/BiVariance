Tags: #Analysis 
# Estimating the effect of location on attractions across genders based on location
# Lavaan syntax
```
Path_Atr <-'
# Regressions
M_Atr ~ Inactive + Education + Work + Gym + Social
X_Atr ~ Inactive + Education + Work + Gym + Social
F_Atr ~ Inactive + Education + Work + Gym + Social

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

# R Code snippet
![[PATH_Atr.R]]
# Generated data
![[Path_Atr_Estimates.csv]]
