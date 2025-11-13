# should have fixed the first issue - removed sd from PCA analysis
# I think I have the right idea in terms of what I'm running the kmeans clustering on, but
# I need to be starting that from using the fixed dataset.

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
data_for_pca <- filtered_read_data_with_sd[,-22]
flipped_filtered <- t(data_for_pca)

pca_results = prcomp(flipped_filtered)
pca_results$sdev

pca_tibble_PC1_2 <- as_tibble(pca_results$x[,1:2], rownames = "Samples")
split_sample_column <- pca_tibble_PC1_2 %>% tidyr::separate(Samples, into = c("Sample", "Replicate"), sep = "_")
split_sample_column_without_sd <- filter(split_sample_column, Sample != "sd")

fixed_data <- mutate(split_sample_column_without_sd, Sample = c(Sample[1:11], Sample[13], Sample[12], Sample[14:21]))
fixed_data <- mutate(fixed_data, Replicate = c(Replicate[1:11], Replicate[13], Replicate[12], Replicate[14:21]))

ggplot(data = fixed_data, aes(x = PC1, y = PC2, color = Sample, shape = Replicate)) +
  geom_point(size = 2)

pca_dimensions = dim(pca_results$x)
pca_summary = tibble(PC=seq(1,pca_dimensions[2],1), sd=pca_results$sdev) %>%
  mutate(var=sd^2) %>% 
  mutate(norm_var=var/sum(var))

pca_summary %>% ggplot(aes(PC, sd)) +
  geom_col()

colnames(data_for_pca)[c(12, 13)] <- colnames(data_for_pca)[c(13, 12)]
combined = data_for_pca[,seq(1, 21, 3)]
combined = combined + data_for_pca[,seq(2, 21, 3)]
combined = combined + data_for_pca[,seq(3, 21, 3)]
combined = combined / 3
gene_sd <- rowSds(combined)
combined <- cbind(combined, gene_sd)

filtered_combined <- combined[combined[,"gene_sd"] > 1, ]

set.seed(42)
kmeans_results = kmeans(scale(as.matrix(filtered_combined)), centers=12, nstart=100)

cluster_labels <- kmeans_results$cluster
print(cluster_labels)

filtered_combined <- cbind(filtered_combined, cluster_labels)
sorted_combined <- filtered_combined[order(filtered_combined[, 9]), ]

sorted_clusters <- kmeans_results$cluster[order(kmeans_results$cluster)]

heatmap(sorted_combined, Rowv=NA, Colv=NA, RowSideColors=RColorBrewer::brewer.pal(12,"Paired")[sorted_clusters], ylab="Gene")

# I will investigate cluster 2 and cluster 3.

filtered_for_cluster_2 <- sorted_combined[sorted_combined[, "cluster_labels"] == 2, ]
filtered_for_cluster_3 <- sorted_combined[sorted_combined[, "cluster_labels"] == 3, ]

genes_in_cluster_2 <- rownames(filtered_for_cluster_2)
genes_in_cluster_3 <- rownames(filtered_for_cluster_3)

