library(tidyverse)

my_coverage <- read.table("~/qb25-answers/week11/coverage10_file.txt")
poisson_distribbution <- read.csv("~/qb25-answers/week11/poisson_coverage10.csv", header = FALSE)
normal_distribution <- read.csv("~/qb25-answers/week11/normal_coverage3.csv", header = FALSE)
range <- read.csv("~/qb25-answers/week11/coverage10_range_file.csv", header = FALSE, sep = "\n")

range <- mutate(range, probability = poisson_distribbution$V1)
range$probability <- range$probability * 1000000
range <- mutate(range, normal_expected = normal_distribution$V1)
range$normal_expected <- range$normal_expected * 1000000
frequency_count <- my_coverage %>% count(V1)

my_vector <- seq(from = 1, to = 1000000, by = 1)
ggplot(data = my_coverage, aes(x = my_vector, y = V1)) +
  geom_histogram(stat = "identity") + 
  labs(
    x = "Position in Genome",
    y = "Number of reads"
  )


ggplot(data = frequency_count, aes(x = V1, y = n)) +
  geom_bar(stat = "identity") +
  geom_line(data = range, aes(x = V1, y = probability, color = "Poisson Distribution")) +
  geom_line(data = range, aes(x = V1, y = normal_expected, color = "Normal Distribution")) +
  labs(
    title = "Results of Simulated Reads",
    x = "Number of Reads",
    y = "Probability"
  ) +
  scale_color_manual(name = "Distribution", values = c("Poisson Distribution" = "blue", "Normal Distribution" = "red"))


no_coverage <- filter(my_coverage, V1 == 0)
nrow(no_coverage)

