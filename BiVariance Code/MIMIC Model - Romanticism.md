# Multiple Indicator Multiple Cause Model of location on Romanticism
# Lavaan syntax
```
MIMIC_Rom_model <-'
# measurement model
 Romanticism =~ M_Rom + X_Rom + F_Rom

 # regressions 
 Romanticism ~ Inactive + Education + Work + Gym + Social

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
Model fits well. Model only suggests that going to work is associated with lower consumption of romantic media or romantic fantasies.
# R Code snippet
![[MIMIC_Rom_model.R]]
# Generated data
![[MIMIC_Rom_coef.csv]]
![[MIMIC_Rom_estimates.csv]]
![[MIMIC_Rom_fitmeasures.csv]]
![[MIMIC_Rom_residuals.csv]]
