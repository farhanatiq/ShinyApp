data <- read.csv(file='GDP.csv', header=TRUE)
data$Region <- as.factor(data$Region)