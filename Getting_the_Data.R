#Retrieving the data for analysis

create
url_rating <- "https://datasets.imdbws.com/title.ratings.tsv.gz"
url_episodes <- "https://datasets.imdbws.com/title.episode.tsv.gz"
url_akas <-"https://datasets.imdbws.com/title.akas.tsv.gz"
url_crew <- "https://datasets.imdbws.com/title.crew.tsv.gz"
url_basic <- "https://datasets.imdbws.com/title.basics.tsv.gz"

# Download the dataset from the URL
download.file(url_rating, destfile = "Ratings.csv", method = "auto")
download.file(url_episodes, destfile = "Episodes.csv", method = "auto" )
download.file(url_episodes, destfile = "Akas.csv", method = "auto" )
download.file(url_episodes, destfile = "Crew.csv", method = "auto" )
download.file(url_episodes, destfile = "Episodes.csv", method = "auto" )


# Load the dataset into RStudio
ratings <- read.csv("Ratings.csv", header = TRUE, sep = "", skip = 0)
episodes <- read.csv("Episodes.csv", header = TRUE, sep = "", skip = 0)
akas <- read.csv("Akas.csv", header = TRUE, sep = "", skip = 0)
crew <- read.csv("Crew.csv", header = TRUE, sep = "", skip = 0)
basic <- read.csv("Basic.csv", header = TRUE, sep = "", skip = 0)


