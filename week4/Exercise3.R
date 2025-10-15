library(tidyverse)

pokemon_tibble <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-01/pokemon_df.csv')

ggplot(data = pokemon_tibble, aes(x = height, y = weight, color = type_1)) +
  geom_point()

ggplot(data = pokemon_tibble, aes(x = attack, y = speed, color = type_1)) +
  geom_point()

ggplot(data = pokemon_tibble, aes(x = special_attack, y = speed, color = type_1)) +
  geom_point()

ggplot(data = pokemon_tibble, aes(x = weight, y = hp, color = type_1)) +
  geom_point()

ggplot(data = pokemon_tibble, aes(x = species_id, y = base_experience)) +
  geom_point()

weight_vs_hp_fit <- lm(data = pokemon_tibble, formula = hp ~ weight + 1)
summary(weight_vs_hp_fit)
