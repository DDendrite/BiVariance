# Loading packages
library(psych)

# Loading data file
data <- read.csv("Bi-cycle_data.csv")

# Data structure
str(data)

# Summary
Summary_Table <- psych::describe(data)

# Exporting results
write.csv(Summary_Table,"Summary_Table.csv", row.names = TRUE)
