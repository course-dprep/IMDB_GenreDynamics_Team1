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
    df <- read_csv(file_name)
    
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

