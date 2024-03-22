#In this file perform the analysis on the cleaned data from SRC/Data_Prep/Data_prep.R

# Loading packages
library(tidyverse)
library(fixest)
library(tidyr)
library(skimr)
library(infer)
library(modelsummary)
library(broom)
library(purrr)
library(viridis)
library(estimatr)
library(stargazer)

#input
mdc <- read_csv("src/data_prep/movie_data_cleaned.csv")


#let's start with the most basic skeleton
fixed_type_model <- feols(averageRating ~ drama + romance + war + crime + thriller+ history + comedy + fantasy + adventure + mystery + biography + action + scifi + western + horror + sport + documentary + musical + filmnoir + animation + adult + gameshow + realitytv + talkshow + short + news | titleType,
                          data = mdc,
                          split = ~ slide_window_5)

summary(fixed_type_model)


#now we add some fixed effects that capture inherent information we may not know changes
fixed_tt_model <- feols(averageRating ~ drama + romance + war + crime + thriller+ history + comedy + fantasy + adventure + mystery + biography + action + scifi + western + horror + sport + documentary + musical + filmnoir + animation + adult + gameshow + realitytv + talkshow + short + news | titleType,
                        data = mdc,
                        split = ~ slide_window_5)

summary(fixed_tt_model)

#adjust model to the current assumptions
fixed_tth_model <- feols(averageRating ~ drama + romance + war + crime + thriller+ history + comedy + fantasy + adventure + mystery + biography + action + scifi + western + horror + sport + documentary + musical + filmnoir + animation + adult + gameshow + realitytv + talkshow + short + news | titleType ,
                        vcov = "hetero",
                        data = mdc,
                        split = ~ slide_window_5)

etable(fixed_tth_model)
#################################################################################

# Create a list named "genres"
genres <- list(
  "drama", "romance", "war", "crime", "thriller",
  "history", "comedy", "fantasy", "adventure", "mystery",
  "biography", "action", "scifi", "western", "horror",
  "sport", "documentary", "musical", "filmnoir", "animation",
  "adult", "gameshow", "realitytv", "talkshow", "short", "news"
)


coefplot(fixed_tth_model)




