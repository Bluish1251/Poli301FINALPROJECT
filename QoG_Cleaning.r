library(tidyverse)
qog <- read.csv("qog_std_ts_jan26.csv") #qog dataset 

qog_clean <- filter(qog, year >= 1990 & year <= 2025) # only keeps rows with year cond met & dropping blank column
qog_clean <- drop_na(qog_clean, al_ethnic2000, p_polity2, wdi_gdpcapcon2015, wdi_pop)

# adding new columns with log transformed values (for scewed values)
qog_clean <- mutate(qog_clean,
    log_gdp = log(wdi_gdpcapcon2015),
    log_pop = log(wdi_pop)
  )

# nrow(qog_clean)
# summary(qog_clean) #testing R functions

write.csv(qog_clean, "qog_cleaned.csv", row.names = FALSE)

# dv on file 'qog_unga.r'