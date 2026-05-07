library(tidyverse)

qog <- read.csv("poli301dataset.csv")

qog_clean <- qog %>%
  filter(year >= 1990 & year <= 2025) %>% # timeline span
  drop_na(al_ethnic2000, p_polity2, wdi_gdpcapcon2015, wdi_pop)

qog_clean <- qog_clean %>%
  mutate(
    log_gdp = log(wdi_gdpcapcon2015),
    log_pop = log(wdi_pop) #log transformation 
  )

nrow(qog_clean)
summary(qog_clean)

write.csv(qog_clean, "qog_cleaned2.csv", row.names = FALSE)

# still need to do work for dv