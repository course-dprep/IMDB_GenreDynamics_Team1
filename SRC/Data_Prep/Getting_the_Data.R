#The retrival of this data set sometimes runs into some trouble with varification.
#So, remember to turn on your university VPN !

library(tidyverse)

Data_Source <- list(
  "https://datasets.imdbws.com/title.ratings.tsv.gz",
  "https://datasets.imdbws.com/title.episode.tsv.gz",
  "https://datasets.imdbws.com/title.akas.tsv.gz",
  "https://datasets.imdbws.com/title.crew.tsv.gz",
  "https://datasets.imdbws.com/title.basics.tsv.gz"
)

Download_data <- function(Data) {
  # Create an empty list to store the data frames
  dfs <- list()
  
  # Loop through each URL in the list
  for (url in Data) {
    # Extract the file name from the URL
    file_name <- basename(url)
    
    # Download the file
    download.file(url, destfile = file_name, mode = "wb")
    
    # Read the downloaded file into R
    df <- read_tsv(file_name) #I am sorry but read_csv cannot deal with whitespaces so I am over that
    
    # Append the data frame to the list
    dfs[[file_name]] <- df
    
    # Remove the downloaded file
    file.remove(file_name)
  }
  
  # Return the list of data frames
  return(dfs)
}


# Call the function
downloaded_data <- Download_data(Data_Source)

# Access each data frame using its file name
ratings <- downloaded_data[["title.ratings.tsv.gz"]]
episodes <- downloaded_data[["title.episode.tsv.gz"]]
akas <- downloaded_data[["title.akas.tsv.gz"]]
crew <- downloaded_data[["title.crew.tsv.gz"]]
basics <- downloaded_data[["title.basics.tsv.gz"]]

#let's merge some datasets! 
#Please take a close look at all the data sets. Do you see how they all have a label 'tconst"? that is awesome because it allows us to merge the data sets.
# however, as you look even more closely you see that in the data frame akas, where the label is titleId
#let's fix that label name. Note that there are alterenative (shorter!) ways to do this.
akas <- akas %>%
  mutate(tconst = titleId) %>%
  select(-titleId)

#For example, let's merge rating (our dv) with basics (one of our iv's)
#Data_set <- left_join(ratings, basics, by = "tconst")
#while this was nice, we need a larger scale operalization.

data_sets <- list(ratings, crew, basics, episodes, akas)
join_column <- "tconst"
movie_data <- Reduce(function(x, y) left_join(x, y, by = join_column), data_sets)

#Awesome! Now we have running code that builds an entire dataframe from seperate ones.

#now let's store the data
write_csv(movie_data, "movie_data.csv")
