#The retrival of this data set sometimes runs into some trouble with varification.
#So, remember to turn on your university VPN !

library(tidyverse)

Data_Source <- list(
  "https://datasets.imdbws.com/title.ratings.tsv.gz",
  "https://datasets.imdbws.com/title.episode.tsv.gz",
  "https://datasets.imdbws.com/title.akas.tsv.gz",
  "https://datasets.imdbws.com/title.basics.tsv.gz"
)

# Loop through each URL in the list
for (url in Data_Source) {
        file_name <- gsub('.*/title\\.(.*).tsv.gz', '\\1', url) # Extract the file name from the URL
        download.file(url, destfile = file_name, mode = "wb") # Download the file
        assign(file_name, read_tsv(file_name)) # Read the downloaded file into R
        file.remove(file_name) # Remove the downloaded file
}

#let's merge some datasets! 
#Please take a close look at all the data sets. Do you see how they all have a label 'tconst"? that is awesome because it allows us to merge the data sets.
# however, as you look even more closely you see that in the data frame akas, where the label is titleId
#let's fix that label name. Note that there are alterenative (shorter!) ways to do this.
akas <- akas %>%
  mutate(tconst = titleId) %>%
  select(-titleId)

episodes <- episodes %>%
  mutate(across(episodeNumber, as.numeric)) %>% 
  mutate(across(seasonNumber, as.numeric))

#For example, let's merge rating (our dv) with basics (one of our iv's)
#Data_set <- left_join(ratings, basics, by = "tconst")
#while this was nice, we need a larger scale operalization.

data_sets <- list(ratings, basics, episode, akas)
join_column <- "tconst"
movie_data <- Reduce(function(x, y) left_join(x, y, by = join_column), data_sets)

#Awesome! Now we have running code that builds an entire dataframe from seperate ones.

#now let's store the data
write_csv(movie_data, "src/data_prep/movie_data.csv")
