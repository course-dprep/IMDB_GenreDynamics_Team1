install.packages("tidyverse")
install.packages("tidyr")
install.packages("dplyr")
install.packages("stringr")
library(tidyverse)
library(tidyr)
library(dplyr)
library(stringr)

#input
movie_data <- read_csv("movie_data.csv")

#clean raw 
movie_data <- movie_data %>%
  mutate(across(c(tconst, directors, writers, titleType, isAdult,genres, parentTconst,isOriginalTitle, types, originalTitle), as.factor)) %>%
  mutate(across(c(averageRating,numVotes,runtimeMinutes, title, seasonNumber, episodeNumber), as.numeric)) 

movie_data <- movie_data %>% filter(numVotes> 100) %>%
  filter(isOriginalTitle== 1) %>%
  distinct(primaryTitle, .keep_all = TRUE) 

movie_data<- movie_data %>% 
  filter(titleType %in% c("movie", "tvMovie", "tvMiniSeries", "tvSeries"))

movie_data <- movie_data %>%
  mutate(movie_dummy = ifelse(str_detect(titleType, regex("movie", ignore_case = TRUE)), 1, 0),
         newfilm_dummy = ifelse(startYear > 1999, 1, 0),
         above_avg = ifelse(averageRating > mean(averageRating), 1, 0),
         drama_dummy = ifelse(str_detect(genres, regex("drama", ignore_case = TRUE)), 1, 0)) %>%
  filter(drama_dummy == 1) %>%
  select(-attributes, -ordering, -region, -language, -isOriginalTitle, -parentTconst, -episodeNumber, -seasonNumber, -title, -originalTitle)

#make a beter targetted data file
movie_data <- movie_data %>%
  select(tconst, averageRating,numVotes, titleType, startYear, runtimeMinutes, genres)
  
#make a window for analysis
slide_window <- movie_data %>%
  group_by(startYear) %>%
  count()

movie_data <- movie_data %>%
  filter(startYear >= 1925) %>%
  mutate(slide_window_5 = cut(startYear, breaks = seq(1925, 2025, by = 5), labels = paste(seq(1925, 2020, by = 5), "-", seq(1929, 2024, by = 5)), include.lowest = TRUE))

slide_window <- movie_data %>%
  group_by(slide_window_5) %>%
  count()

#pivor the data wide for a more smooth analysis
movie_data_test <- movie_data %>%
  mutate(genres = tolower(genres)) %>%
  separate_rows(genres, sep = ",") %>%
  mutate(genre_dummy = 1) %>%
  pivot_wider(names_from = genres, values_from = genre_dummy, values_fill = list(genre_dummy = 0)) %>%
  rename(scifi = `sci-fi`) %>%
  rename(filmnoir = `film-noir`) %>%
  rename(gameshow = `game-show`) %>%
  rename(realitytv = `reality-tv`) %>%
  rename(talkshow = `talk-show`)

#output save
write_csv(movie_data, "movie_data_cleaned.csv")
