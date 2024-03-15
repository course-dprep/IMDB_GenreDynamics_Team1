install.packages("tidyverse")
library(tidyverse)

movie_data <- read_csv("movie_data.csv")

movie_data <- movie_data %>%
  mutate(across(c(tconst, directors, writers, titleType, isAdult,genres, parentTconst,isOriginalTitle), as.factor)) %>%
  mutate(across(c(averageRating,numVotes,runtimeMinutes, title,seasonNumber, episodeNumber), as.numeric)) %>%
  mutate(across(c(primaryTitle, originalTitle,types, attributes),as.string))

movie_data <- movie_data %>% filter(numVotes> 100) %>%
  filter(isOriginalTitle== 1) %>%
  distinct(primaryTitle, .keep_all = TRUE) 

movie_data<- movie_data %>% filter(titleType %in% c("movie", "tvMovie", "tvMiniSeries", "tvSeries"))

movie_data <- movie_data %>% mutate(movie_dummy= ifelse(str_detect(titleType,regex("movie", ignore_case = TRUE)), 1, 0))
movie_data <- movie_data %>% mutate(newfilm_dummy= ifelse(startYear> 1999, 1, 0))
movie_data <- movie_data %>% mutate(above_avg= ifelse(averageRating> mean(averageRating), 1, 0))
movie_data <- movie_data %>% mutate(drama_dummy= ifelse(str_detect(genres,regex("drama", ignore_case = TRUE)), 1, 0))
sum(movie_data$drama_dummy)
movie_data <- subset(movie_data, select = c( -attributes, -ordering, -region, -language, -isOriginalTitle, -parentTconst, -episodeNumber, -seasonNumber, -title, -originalTitle))
movie_data <- select(movie_data, tconst, primaryTitle, everything())




#do you see how tha average movie only has 106 votes? Or even 5! that will defiantely influence the average 
ggplot(movie_data, aes(x = numVotes)) +
  geom_dotplot(fill = "darkorange", color = "black", binwidth = 500) +
  labs(title = "Distribution of numVotes",
       x = "Number of Votes", y = "Frequency") + 
  theme_minimal()

movie_data$numVotes_group <- cut(movie_data$numVotes, breaks = c(-Inf, 50, Inf), labels = c("Below 50", "Above 50"))
print(table(movie_data$numVotes_group))


below_100 <- movie_data %>%
  select(numVotes) %>%
  filter(numVotes < 100)

ggplot(below_100, aes(x = numVotes)) +
  geom_histogram() +
  labs(title = "Distribution of numVotes Below 100",
       x = "Group (Interval of 10)", y = "Number of Votes") +
  theme_minimal()

