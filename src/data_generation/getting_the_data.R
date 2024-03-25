#The retrieval of this data set sometimes runs into some trouble with verification.
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

dir.create("data") # Create a directory to save the data
save.image("data/movie_data.RData")