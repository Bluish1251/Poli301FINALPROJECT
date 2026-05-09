library(tidyverse)
qog <- read.csv("qog_cleaned.csv")
unga <- read.csv("2026_02_06_ga_voting.csv")

# pull year out of date col and drop absent/non-voting rows
unga <- mutate(unga, year = as.integer(substr(date, 1, 4)))
unga_votes <- filter(unga, ms_vote %in% c("Y", "N", "A"))
# %in% - is it equal/true to (wtvr is after)

# get western bloc votes per resolution, find majority position
western_bloc <- c("USA", "GBR", "FRA", "DEU")
western_votes <- filter(unga_votes, ms_code %in% western_bloc)
unga_votes <- filter(unga_votes, !(ms_code %in% western_bloc))

#aggregate aligned votes, grouped by resolution, etc
western_position <- aggregate(ms_vote ~ resolution, data = western_votes, FUN = function(x) names(which.max(table(x))))

#for each unique combination of country code + year, computing the mean of alignment 
colnames(western_position) <- c("resolution", "western_pos")

# score each vote aligned (1) or not (0) with western majority
unga_votes <- merge(unga_votes, western_position, by = "resolution")
unga_votes <- mutate(unga_votes, aligned = as.integer(ms_vote == western_pos))
# average alignment per country per year (this is the dv)
alignment <- aggregate(aligned ~ ms_code + year, data = unga_votes, FUN = mean)
colnames(alignment) <- c("ccodealp", "year", "unga_alignment")

final_data <- merge(qog, alignment, by = c("ccodealp", "year"))
#merged uncleaned data on accident

write.csv(final_data, "final_dataset.csv", row.names = FALSE)
# analysis on file 'finalscript.r'