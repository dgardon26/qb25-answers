# Step 1.1

library(DESeq2)
library(tidyverse)
library(broom)

setwd("~/qb25-answers/week8")

GTEx_data <- read_delim("gtex_whole_blood_counts_downsample.txt")
metadata_df <- read_delim("gtex_metadata_downsample.txt")
chromosomes_df <- read_delim("gene_locations.txt")

GTEx_data <- column_to_rownames(GTEx_data, var = "GENE_NAME")
metadata_df <- column_to_rownames(metadata_df, var = "SUBJECT_ID")

# Step 1.2

colnames(GTEx_data) == rownames(metadata_df)
dds <- DESeqDataSetFromMatrix(countData = GTEx_data, colData = metadata_df,
                              design = ~ SEX + AGE + DTHHRDY)
dds2 <- DESeqDataSetFromMatrix(countData = GTEx_data, colData = metadata_df,
                               design = ~ SEX + AGE + DTHHRDY)

# Step 1.3

vsd <- vst(dds)
plotPCA(vsd, intgroup = "SEX")
plotPCA(vsd, intgroup = "AGE")
plotPCA(vsd, intgroup = "DTHHRDY")

# The percentage of variance explained by the first two PCs in total is about 55%, which
# is a pretty good total proportion. In terms of how the subject-level variables are mapping
# onto the PC plot, "DTHHRDY" or a death variable, seems to be very strongly associated with 
# PC1, as there is pretty strong grouping for a fast death vs ventilator case along PC1. For the other
# two, I would say the relationship is not as obvious, but there seems to be some less strong but
# still apparent grouping by age on PC1. Sex is a pretty loose grouping, but seems to roughly be 
# associating with PC2.

# Step 2.1

vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()
vsd_df <- bind_cols(metadata_df, vsd_df)

m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
print(m1)

# For WASH7, the coefficient for sex is positive but the p value is only 0.279, which suggests
# to me that this gene does not have significant evidence for sex differential expression.

m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
print(m2)

# For SLC25A47, the coefficient is again positive, at 0.518, but this time the p value is 0.0257.
# By a standard of p = 0.05, this does meet statistical significance and thus this gene does show evidence
# of sex differential expression, being more highly expressed in males.

# Step 2.2

dds <- DESeq(dds)

# Step 2.3

results_sex <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")

filtered_results_for_na_sex <- results_sex %>% filter(!(is.na(padj)))


filtered_for_value_sex <- filtered_results_for_na_sex %>% filter(padj < 0.1)
nrow(filtered_for_value_sex)

# 262 genes show differential expression between males and females in the dataset at 10% FDR.

joined_sex_results <- left_join(x = filtered_for_value_sex, y = chromosomes_df, by = "GENE_NAME")
joined_sex_results <- joined_sex_results %>% arrange(padj)

# Glancing at the merged dataframe in R, since it's not very large, I see a few differentially expressed genes
# on every other chromosome, but it seems like the most differentially expressed genes are on the Y chromosome, with a couple on the X. Given 
# it's the Y chromosome, these would be male-upregulated genes and thus more male-upregulated genes
# seem to be at the top of the list. Given this is the sex chromosome, and females do not have a Y chromosome, it would make sense
# a lot of the hits are located on the Y chromosome.

wash7p_results <- results_sex %>% filter(GENE_NAME == "WASH7P")
slc25A47_results <- results_sex %>% filter(GENE_NAME == "SLC25A47")
print(wash7p_results)
print(slc25A47_results)

# Extracting the rows from the original results tibble and then printing, this seems consistent with the original
# linear model. lm for WASH7P did not show a p value that met statistical significance, and this is shared when doing differential
# analysis by sex in DESeq2, as the p value here is also not meeting significance (adjusted p = 0.899). There is a positive log2FoldChange
# so there was a difference in expression, but not a statistically significant one. On the other hand, 
# SLC25A47 is also showing a log2FoldChange, being a positive one in this case of 3.06, and this is statistically significant
# as the p value meets threshold, just like in the lm regression. Thus, both are broadly consistent with the "homemade" regression.

# The relationship between false positives and false negatives has to do with your FDR. Setting your false discovery rate to be strict means
# you will see a much lower level of false positives since you are being very stringent, but will conversely increase your false negatives since
# you will end up missing relationships that might be significant but don't quite meet a threshold of say, 1%, and vice versa if your false discovery rate is
# lenient, like around 20% - your false positive rate would be higher in this scenario but false negatives a lot lower. A higher sample size will give you more
# statistical power and help you resolve false negatives better, and a higher effect size will reduce the amount of false positives - lower sample size
# and low effect size both will make it more difficult to detect truly differential expression.

# Step 2.4

results_death <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes")  %>%
  as_tibble(rownames = "GENE_NAME")

filtered_results_for_na_death <- results_death %>% filter(!(is.na(padj)))
filtered_for_value_death <- filtered_results_for_na_death %>% filter(padj < 0.1)
nrow(filtered_for_value_death)

# At 10% FDR (p < 0.1), there are 16,069 genes that are differentially expressed based on death classification.

# Step 2.5

metadata_df$SEX <- sample(metadata_df$SEX, replace = FALSE)
dds2 <- DESeq(dds2)

results_sex_2 <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")

filtered_results_for_na_sex2 <- results_sex %>% filter(!(is.na(padj)))
filtered_for_value_sex2 <- filtered_results_for_na_sex %>% filter(padj < 0.1)
print(filtered_for_value_sex2)

# This is showing that using a "null distribution" (reshuffled sex column) and running DEA for sex at an FDR of 10%,
# you get 262 results, which matches the number of hits seen in my initial, "real", experiment. This suggests that in large scale
# experiments, the FDR is never going to perfectly be able to control the false positive discovery rate - at the scale of the analysis we are doing
# (thousands and thousands of genes), there will always be false positives in your results by happenstance. This means that you will 
# always get some hits, but past a certain threshold set by your FDR, there will be real hits. For example, the death hits are likely to contain many "real hits"
# based on this result, since the FDR will limit the false discovery rate to a certain point.

# Step 3

results_sex <- results_sex %>% mutate(significant_and_positive = case_when(padj < 0.1 & log2FoldChange > 0 ~ TRUE,
                                                         TRUE ~ FALSE)) # got this idea from Google AI search
ggplot(data = results_sex, aes(x = log2FoldChange, y = -log10(pvalue), color = significant_and_positive)) +
  geom_point()

