library(tidyverse)
library(broom)
library(patchwork)

DNA_tibble <- read_csv("~/qb25-answers/week4/aau1043_dnm.csv")
per_proband_summary <- DNA_tibble %>% filter(!is.na(Phase_combined))



table(per_proband_summary$Phase_combined)


parental_tibble <- read_csv("~/qb25-answers/week4/aau1043_parental_age.csv")


final_tibble <- inner_join(DNA_tibble, parental_tibble, by = "Proband_id")
grouped_by_proband <- final_tibble %>% group_by(Proband_id, Phase_combined, Mother_age, Father_age) %>% 
  summarize(proband_counts = n())
filtered_grouped_by_proband <- filter(grouped_by_proband, Phase_combined != "NA")


ggplot(data = filter(filtered_grouped_by_proband, Phase_combined == "mother"), aes(x = Mother_age, y = proband_counts)) +
  geom_point()

ggplot(data = filter(filtered_grouped_by_proband, Phase_combined == "father"), aes(x = Father_age, y = proband_counts)) +
  geom_point()

maternal_age_model <- lm(data = filter(filtered_grouped_by_proband, Phase_combined == "mother"), formula = proband_counts ~ 1 + Mother_age)
summary(maternal_age_model)

paternal_age_model <- lm(data = filter(filtered_grouped_by_proband, Phase_combined == "father"), formula = proband_counts ~ 1 + Father_age)
summary(paternal_age_model)

predicted_father505 = 1.35385 * 50.5 + 10.32632

ggplot() +
 geom_histogram(aes(x = filtered_for_paternal_DNM$proband_counts), fill = "blue", alpha = 0.5) +
  geom_histogram(aes(x = filtered_for_maternal_DNM$proband_counts), fill = "pink", alpha = 0.5) +
  xlab("DNM counts")

filtered_for_paternal_DNM <- filter(filtered_grouped_by_proband, Phase_combined == "father")
filtered_for_maternal_DNM <- filter(filtered_grouped_by_proband, Phase_combined == "mother")



mother_vector <- filtered_grouped_by_proband %>% filter(Phase_combined == "mother") %>% pull(proband_counts)
father_vector <- filtered_grouped_by_proband %>% filter(Phase_combined == "father") %>% pull(proband_counts)

t_test_results <- t.test(mother_vector, father_vector, paired = TRUE)
print(t_test_results)

comparison_dataframe <- data.frame(Proband = filtered_grouped_by_proband$Proband_id, Maternal_DNM = filtered_for_maternal_DNM$proband_counts, Paternal_DNM = filtered_for_paternal_DNM$proband_counts)
comparison_dataframe$difference <- comparison_dataframe$Paternal_DNM - comparison_dataframe$Maternal_DNM

comparison_to_t <- lm(data = comparison_dataframe, formula = comparison_dataframe$difference ~ 1)
print(comparison_to_t)

lm(data = comparison_dataframe, formula = comparison_dataframe$difference ~ 1)
