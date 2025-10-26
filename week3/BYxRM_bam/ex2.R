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
  xlim(0, 20)

# Question 2.2: This suggests that most of the read depths are around 5, with most being between 5-10, which represents
# the number of times any given site was read during the sequencing process. It seems like in this case because each variant site
# was read for each sample, the number of read depths for any specific sample is not super high, but collectively across the genome you are 
# getting many of these reads for each variant site you're checking. This surprised me a little bit,
# as I would have expected slightly higher read depth per sample, but given the numbers being tested here shallower 
# reads does make sense since that should be sensitive enough to identify which allele a given site might be
# (and thus which parent it came from). This is a right tailed/positively skewed distribution. 

