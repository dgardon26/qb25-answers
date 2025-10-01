library(tidyverse)

genotype <- read.table("~/qb25-answers/week3/BYxRM_bam/gt_long.txt")

filtered_genotype <- filter(genotype, V1 == "A01_62" & V2 == "chrII")
genotypes <- as.factor(filtered_genotype$V4)

ggplot(filtered_genotype, aes(x = V3, y = V1, color = genotypes)) + 
  geom_point() +
  scale_color_manual(labels = c("1", "0"), values = c("blue", "red")) +
  theme(axis.title.y = element_blank(),  # Remove y-axis title
        axis.text.y = element_blank(),   # Remove y-axis labels
        axis.ticks.y = element_blank(),  # Remove y-axis ticks
        axis.line.y = element_blank()    # Remove y-axis line
  ) + 
  labs(
    x = "Position"
  )

# Question 3.2: Looking at this broad scale view, there seems to be a very well defined set of areas
# where 0 (the reference genome) is versus 1 (the alternative genome), or in other words, where
# the parental lab strain is versus the wine strain. Specifically on chromosome II in this sample,
# there is a short section at the start and a longer section at the end that seem to be from
# the reference genome and a large section between those two that is from the alternative genome.
# The transitions are areas where the gene exchange actually occurred. 

A01_62 <- filter(genotype, V1 == "A01_62")
genotypes_62 <- as.factor(A01_62$V4)

ggplot(A01_62, aes(x = V3, y = V1, color = genotypes_62)) +
  geom_point() +
  scale_color_manual(labels = c("1", "0"), values = c("green", "orange")) +
  theme(axis.title.y = element_blank(),  # Remove y-axis title
        axis.text.y = element_blank(),   # Remove y-axis labels
        axis.ticks.y = element_blank(),  # Remove y-axis ticks
        axis.line.y = element_blank()    # Remove y-axis line
  ) + 
  labs(
    x = "Position"
  ) +
  facet_grid(A01_62$V2 ~ ., scales = "free_x", space = "free_x")



