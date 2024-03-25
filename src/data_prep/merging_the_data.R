#let's merge some datasets! 
#Please take a close look at all the data sets. Do you see how they all have a label 'tconst"? that is awesome because it allows us to merge the data sets.
# however, as you look even more closely you see that in the data frame akas, where the label is titleId
#let's fix that label name. Note that there are alternative (shorter!) ways to do this.
library(tidyverse)

load("data/movie_data.RData")

akas <- akas %>%
  mutate(tconst = titleId) %>%
  select(-titleId)

episode <- episode %>%
  mutate(across(episodeNumber, as.numeric)) %>% 
  mutate(across(seasonNumber, as.numeric))

#For example, let's merge rating (our dv) with basics (one of our iv's)
#Data_set <- left_join(ratings, basics, by = "tconst")
#while this was nice, we need a larger scale operationalization.

data_sets <- list(ratings, basics, episode, akas)
join_column <- "tconst"
movie_data <- Reduce(function(x, y) left_join(x, y, by = join_column), data_sets)

#Awesome! Now we have running code that builds an entire data frame from separate ones.

#now let's store the data
write_csv(movie_data, "data/movie_data.csv")