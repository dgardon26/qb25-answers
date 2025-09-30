library(tidyverse)

items <- read.table("~/qb25-answers/week3/BYxRM_bam/AF.txt")

ggplot(data = items, aes(x = V1)) + 
         geom_histogram(bins=11) +
         labs(
           x = "Allele Frequency",
           y = "Count")
        
  # Question 2.1: This seems to be roughly what you'd expect. Most alleles are at 50% frequency
  # or around that ballpark, as in this system you'd expect 50% of the final haploid bud
  # to contain one parent's DNA and 50% the other. Therefore, absent any fitness benefits or
  # downsides you'd expect each allele to have 50% frequency. This fits a binomial distribution.

other_items <- read.table("~/qb25-answers/week3/BYxRM_bam/DP.txt")
other_items$V1 <- as.numeric(as.character(other_items$V1))

ggplot(data = other_items, aes(x = V1)) + 
  geom_histogram(bins = 21) +
  labs(
    x = "Read Depth",
    y = "Count") + 
  xlim(0, 200)

# Question 2.2: This suggests that most of the read depths are around 50, which represents
# the number of times any given site was read during the sequencing process. This experiment
# utilized short read sequencing, so it makes sense that there would be a lot of reads (30-70)
# at most sites. There are very few outliers with significantly higher read depth, and these might be sites
# with high repetition that are getting flagged many more times than an average, more recognizable
# sequence (example: something with 1000 reads might be the same sequence from different places). This is a
# right tailed/positively skewed distribution. 

