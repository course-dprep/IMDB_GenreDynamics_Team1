#The retrieval of this data set sometimes runs into some trouble with verification.
#So, remember to turn on your university VPN !

library(tidyverse)
dir.create("data")
dir.create("data/temp", recursive = T)
path = "data/temp/"

Data_Source <- list(
  "https://datasets.imdbws.com/title.ratings.tsv.gz",
  "https://datasets.imdbws.com/title.episode.tsv.gz",
  "https://datasets.imdbws.com/title.akas.tsv.gz",
  "https://datasets.imdbws.com/title.basics.tsv.gz"
)

# Loop through each URL in the list
for (url in Data_Source) {
        file_name <- gsub('.*/title\\.(.*).tsv.gz', '\\1', url) # Extract the file name from the URL
        download.file(url, destfile = paste0(path, file_name), mode = "wb") # Download the file
        assign(file_name, read_tsv(paste0(path, file_name))) # Read the downloaded file into R
        file.remove(paste0(path, file_name)) # Remove the downloaded file
}

save.image("data/movie_data.RData")