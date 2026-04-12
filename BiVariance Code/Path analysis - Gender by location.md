Tags: #Analysis 
# Estimating the effect of location on gender Attraction, Romanticism and Eroticism
# Lavaan syntax
```
Path_Gender_Location <-'
# Regressions
M ~ Inactive + Education + Work + Gym + Social
X ~ Inactive + Education + Work + Gym + Social
F ~ Inactive + Education + Work + Gym + Social

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
![[PATH_Gender_Location.R]]
# Generated data
![[Path_Gender_Location_Estimates.csv]]
