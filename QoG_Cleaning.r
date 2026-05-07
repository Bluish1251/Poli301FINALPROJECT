library(tidyverse)
qog <- read.csv("poli301dataset.csv")

qog_clean <- qog %>%
  filter(year >= 1990 & year <= 2025) %>% # only keeps rows with year cond met & dropping blank column
  drop_na(al_ethnic2000, p_polity2, wdi_gdpcapcon2015, wdi_pop)

qog_clean <- qog_clean %>%
  mutate( # adding new columns with log transformed values (for scewed values)
    log_gdp = log(wdi_gdpcapcon2015),
    log_pop = log(wdi_pop)  
  )

nrow(qog_clean)
summary(qog_clean) #testing R functions

#write.csv(qog_clean, "qog_cleaned2.csv", row.names = FALSE)

# dv on file 'qog_unga.r'