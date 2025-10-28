library(tidyr)
library(dplyr)
library(matrixStats)
library(ggplot2)
library(readr)

read_data = as.matrix(read.table("~/qb25-answers/week6/read_matrix.tsv"))
# read_data = as.matrix(read_data)

sd <- rowSds(read_data, na.rm = TRUE)
t(sd)
read_data_with_sd <- cbind(read_data, sd)
sorted_read_data_with_sd <- read_data_with_sd[order(-read_data_with_sd[,22]), ]
filtered_read_data_with_sd <- head(sorted_read_data_with_sd, n = 500)
flipped_filtered <- t(filtered_read_data_with_sd)

#standardized_flipped_filtered <- scale(flipped_filtered)
#print(standardized_flipped_filtered)

pca_results = prcomp(flipped_filtered)
pca_results$sdev


pca_tibble_PC1_2 <- as_tibble(pca_results$x[,1:2], rownames = "Samples")
split_sample_column <- pca_tibble_PC1_2 %>% tidyr::separate(Samples, into = c("Sample", "Replicate"), sep = "_")
split_sample_column_without_sd <- filter(split_sample_column, Sample != "sd")

fixed_data <- mutate(split_sample_column_without_sd, Sample = c(Sample[1:11], Sample[13], Sample[12], Sample[14:21]))
fixed_data <- mutate(fixed_data, Sample = c(Sample[1:11], Sample[13], Sample[12], Sample[14:21]), Replicate = c(Replicate[1:11], Replicate[13], Replicate[12], Replicate[14:21]))

ggplot(data = fixed_data, aes(x = PC1, y = PC2, color = Sample, shape = Replicate)) +
  geom_point(size = 2)

pca_dimensions = dim(pca_results$x)
pca_summary = tibble(PC=seq(1,pca_dimensions[2],1), sd=pca_results$sdev) %>%
  mutate(var=sd^2) %>% 
  mutate(norm_var=var/sum(var))

pca_summary %>% ggplot(aes(PC, sd)) +
  geom_col()
