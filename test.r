qog <- read.csv("poli301dataset.csv")

qog_clean <- qog[qog$year >= 1990 & qog$year <= 2025, ]
qog_clean <- qog_clean[complete.cases(qog_clean[, c("al_ethnic2000", "p_polity2", "wdi_gdpcapcon2015", "wdi_pop")]), ]
                                                     

qog_clean$log_gdp <- log(qog_clean$wdi_gdpcapcon2015)
qog_clean$log_pop <- log(qog_clean$wdi_pop)

cat("Rows after cleaning:", nrow(qog_clean), "\n")
summary(qog_clean)

write.csv(qog_clean, "qog_cleaned.csv", row.names = FALSE)