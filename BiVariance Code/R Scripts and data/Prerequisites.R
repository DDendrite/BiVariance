# This scripts which enable the other scripts in this package to be run.
# Depending on whether you want to do, you might not need all of them.
# Below are several options.

# REQUIRED: Packages for multivariate and latent variable analysis:
install.packages("psych")
install.packages("lavaan")
install.packages("semPlot")
install.packages("semTools")

# OPTIONAL: Shiny app to analyse tracked data:
install.packages("shiny")
install.packages("DT")
install.packages("shinythemes")

# OPTIONAL: Packages for Monte Carlo simulation of latent variable models:
install.packages("simsem")