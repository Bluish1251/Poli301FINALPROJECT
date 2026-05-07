library(tidyverse)

# load final merged dataset
final_data <- read.csv("final_dataset.csv")

# --- bivariate analysis ---

# correlation test: ethnic fractionalization vs unga alignment
cor_result <- cor.test(final_data$al_ethnic2000, final_data$unga_alignment)
print(cor_result)

# scatterplot with regression line
plot(final_data$al_ethnic2000, final_data$unga_alignment,
    xlab = "Ethnic Fractionalization (al_ethnic2000)",
    ylab = "UNGA Alignment with Western Bloc",
    main = "Ethnic Fractionalization vs. UNGA Voting Alignment",
    pch = 16, col = "steelblue")
abline(lm(unga_alignment ~ al_ethnic2000, data = final_data), col = "red")

# --- OLS regression ---

# full model with controls
model <- lm(unga_alignment ~ al_ethnic2000 + p_polity2 + log_gdp + log_pop, data = final_data)
summary(model)
