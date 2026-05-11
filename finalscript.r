library(tidyverse)
final_data <- read.csv("final_dataset.csv")

# bivariate analysis/correlation test
cor_result <- cor.test(~ al_ethnic2000 + unga_alignment, data = final_data)
#print(cor_result)
sink("correlation_output.txt")
print(cor_result)
sink()

# scatterplot with regression line
png("scatterplot.png", width = 900, height = 600, res = 100)

plot(unga_alignment ~ al_ethnic2000, data = final_data,
    xlab = "Ethnic Fractionalization (0 = homogeneous, 1 = very diverse)",
    ylab = "Voting Alignment with West (0 = never, 1 = always)",
    main = "Ethnic Fractionalization and UNGA Voting Alignment",
    pch  = 16,
    col  = adjustcolor("steelblue", alpha = 0.6)) # gradient/transparency for better visibility

abline(lm(unga_alignment ~ al_ethnic2000, data = final_data), col = "red", lwd = 2) # regression line
dev.off()

# inclusion of all variables in the model
model <- lm(unga_alignment ~ al_ethnic2000 + p_polity2 + log_gdp + log_pop, data = final_data)
summary(model)

# saving regression as text and printing to console (for prototyping)
sink("regression_output.txt")
print(summary(model))
sink()

# case study (Japan and Nigeria)
nigeria <- filter(final_data, ccodealp == "NGA")
japan <- filter(final_data, ccodealp == "JPN")

sink("case_study_output.txt")
print(summary(nigeria))
print(summary(japan))
sink()
