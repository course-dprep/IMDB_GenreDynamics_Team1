#In this file perform the analysis on the cleaned data from SRC/Data_Prep/Data_prep.R

install.packages("tidyverse")
install.packages("fixest")
install.packages("tidyr")
install.packages("skimr")
install.packages("infer")
install.packages("modelsummary")
install.packages("broom")
install.packages("purrr")
install.packages("estmatr")

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
mdc <- read_csv("movie_data_cleaned.csv")



#let's start with the most basic skeleton

simple_model <- feols(averageRating ~ drama + romance + war + crime + thriller+ history + comedy + fantasy + adventure + mystery + biography + action + scifi + western + horror + sport + documentary + musical + filmnoir + animation + adult + gameshow + realitytv + talkshow + short + news,
                      data = movie_data_test,
                      split = ~ slide_window_5)
etable(simple_model)



#let's add some fixed effects for type movie vs. series
fixed_type_model <- feols(averageRating ~ drama + romance + war + crime + thriller+ history + comedy + fantasy + adventure + mystery + biography + action + scifi + western + horror + sport + documentary + musical + filmnoir + animation + adult + gameshow + realitytv + talkshow + short + news | titleType,
                                data = movie_data_test,
                                split = ~ slide_window_5)

etable(fixed_type_model)

#now we add some title specific effects that capture inherent information we may not know changes
fixed_type_model <- feols(averageRating ~ numVotes + drama + romance + war + crime + thriller+ history + comedy + fantasy + adventure + mystery + biography + action + scifi + western + horror + sport + documentary + musical + filmnoir + animation + adult + gameshow + realitytv + talkshow + short + news | titleType,
                          cluster = ~ titleType,
                          data = movie_data_test,
                          split = ~ slide_window_5)

summary(fixed_type_model)


