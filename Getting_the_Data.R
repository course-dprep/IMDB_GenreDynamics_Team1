#remember to turn on your university VPN. Without it the server blocks you.

library(tidyverse)
library(stringr)

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



#source background job
write_csv(movie_data, "movie_data.csv")
print("The merged data set is saved succesfully")

movie_data <- read_csv("movie_data.csv") %>% filter(numVotes> 100) %>%
  filter(isOriginalTitle== 1) %>%
  distinct(primaryTitle, .keep_all = TRUE) 
  

movie_data <- subset(movie_data, select = -numVotes_group)
movie_data<- movie_data %>% filter(titleType %in% c("movie", "tvMovie", "tvMiniSeries", "tvSeries"))
#adding dummy variable of movie vs series
movie_data <- movie_data %>% mutate(movie_dummy= ifelse(str_detect(titleType,regex("movie", ignore_case = TRUE)), 1, 0))
movie_data <- movie_data %>% mutate(newfilm_dummy= ifelse(startYear> 1999, 1, 0))



#starting with out DV: ratings
summary(movie_data$averageRating)

#Okay. So the scale is okay BUT remember that these are AVERAGE ratings, and that on average ratings 1 and 10 are quite extreem and frankly, unrealistic.
#let's visualize how ratings are distributed

#ggplot(movie_data), aes(x = averageRating)) +
  #geom_histogram(binwidth = 1, fill = "darkorange", color = "black") +
  #labs(title = "Distribution of averageRating",
   #    x = "Average Rating",y = "Frequency") +
#  scale_x_continuous(breaks = seq(0, 10, by = 1)) +  
#  theme_minimal()

#ggplot(movie_data, aes(x = averageRating)) +
#  geom_histogram(binwidth = 0.1, fill = "orange", color = "black") +
#  scale_x_continuous(breaks = seq(0, 10, by = 0.5), limits = c(0, 10), labels = scales::number_format(accuracy = 0.1)) +
#  labs(x = "averageRating", y = "Frequency") +
#  theme_minimal()

#as you can see there appears to be a normal distribution that is slightly skewed to the left.
#If you think logically about this this may be a result from the number of reviews given as opposed to the actual rating

print(summary(movie_data$numVotes))

#do you see how tha average movie only has 106 votes? Or even 5! that will defiantely influence the average 
#ggplot(movie_data, aes(x = numVotes)) +
#  geom_dotplot(fill = "darkorange", color = "black", binwidth = 500) +
 # labs(title = "Distribution of numVotes",
  #     x = "Number of Votes", y = "Frequency") + 
#  theme_minimal()

print(table(movie_data$numVotes_group))
table(movie_data$titleType)



library(ggplot2)
ggplot(movie_data,aes(x= startYear))+ geom_histogram()
#  geom_histogram() +
#  labs(title = "Distribution of numVotes Below 100",
#       x = "Group (Interval of 10)", y = "Number of Votes") +
#  theme_minimal()


