#Now let's think about some operalization basics. Or more specifically, the operalization of our variables.

#starting with out DV: ratings
print(summary(movie_data$averageRating))

#Okay. So the scale is okay BUT remember that these are AVERAGE ratings, and that on average ratings 1 and 10 are quite extreem and frankly, unrealistic.
#let's visualize how ratings are distributed

ggplot(movie_data), aes(x = averageRating)) +
  geom_histogram(binwidth = 1, fill = "darkorange", color = "black") +
  labs(title = "Distribution of averageRating",
       x = "Average Rating",y = "Frequency") +
  scale_x_continuous(breaks = seq(0, 10, by = 1)) +  
  theme_minimal()

ggplot(movie_data, aes(x = averageRating)) +
  geom_histogram(binwidth = 0.1, fill = "orange", color = "black") +
  scale_x_continuous(breaks = seq(0, 10, by = 0.5), limits = c(0, 10), labels = scales::number_format(accuracy = 0.1)) +
  labs(x = "averageRating", y = "Frequency") +
  theme_minimal()

#as you can see there appears to be a normal distribution that is slightly skewed to the left.
#If you think logically about this this may be a result from the number of reviews given as opposed to the actual rating

print(summary(movie_data$numVotes))

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
