# load libs and data set, remove column headings
library(cluster)
library(ggplot2)
library(ggdendro)

set.seed(123)

data <- read.csv("data_banknote_authentication.txt", header = FALSE)
colnames(data) <- c("Variance", "Skewness", "Curtosis", "Entropy", "Class")

X_raw <- as.matrix(data[,1:4])

# Normalization function
min_max_norm <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

X_norm <- apply(X_raw, 2, min_max_norm)



# C1: PCA on Raw Data

pca_raw <- prcomp(X_raw,
                  center = TRUE,
                  scale. = FALSE)

# Variance explained by each principal component
pca_raw_var <- (pca_raw$sdev^2) / sum(pca_raw$sdev^2)

# PCA scores
pca_raw_df <- data.frame(
  PC1 = pca_raw$x[, 1],
  PC2 = pca_raw$x[, 2],
  Class = factor(data$Class)
)

# Axis labels with percentage of variance explained
pc1_raw_label <- paste0(
  "PC1 (", round(pca_raw_var[1] * 100, 2), "%)"
)

pc2_raw_label <- paste0(
  "PC2 (", round(pca_raw_var[2] * 100, 2), "%)"
)

# PCA plot - Raw Data
pca_plot_raw <- ggplot(pca_raw_df,
                       aes(x = PC1, y = PC2, color = Class)) +
  geom_point(size = 2.5, alpha = 0.75) +
  labs(
    title = "PCA Visualization - Raw Data",
    subtitle = "Principal Component Analysis before normalization",
    x = pc1_raw_label,
    y = pc2_raw_label,
    color = "Class"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "right"
  )

print(pca_plot_raw)


# C2: PCA on Normalized Data

pca_norm <- prcomp(X_norm,
                   center = TRUE,
                   scale. = FALSE)

# Variance explained by each principal component
pca_norm_var <- (pca_norm$sdev^2) / sum(pca_norm$sdev^2)

# PCA scores
pca_norm_df <- data.frame(
  PC1 = pca_norm$x[, 1],
  PC2 = pca_norm$x[, 2],
  Class = factor(data$Class)
)

# Axis labels with percentage of variance explained
pc1_norm_label <- paste0(
  "PC1 (", round(pca_norm_var[1] * 100, 2), "%)"
)

pc2_norm_label <- paste0(
  "PC2 (", round(pca_norm_var[2] * 100, 2), "%)"
)

# PCA plot - Normalized Data
pca_plot_norm <- ggplot(pca_norm_df,
                        aes(x = PC1, y = PC2, color = Class)) +
  geom_point(size = 2.5, alpha = 0.75) +
  labs(
    title = "PCA Visualization - Normalized Data",
    subtitle = "Principal Component Analysis after min-max normalization",
    x = pc1_norm_label,
    y = pc2_norm_label,
    color = "Class"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "right"
  )

print(pca_plot_norm)


# C3: Display Raw and Normalized PCA together

# Combine PCA scores into one data frame
pca_comparison_df <- rbind(
  data.frame(
    PC1 = pca_raw$x[, 1],
    PC2 = pca_raw$x[, 2],
    Class = factor(data$Class),
    Dataset = "Raw Data"
  ),
  data.frame(
    PC1 = pca_norm$x[, 1],
    PC2 = pca_norm$x[, 2],
    Class = factor(data$Class),
    Dataset = "Normalized Data"
  )
)

# Combined visualization
pca_comparison_plot <- ggplot(
  pca_comparison_df,
  aes(x = PC1, y = PC2, color = Class)
) +
  geom_point(size = 2.5, alpha = 0.75) +
  facet_wrap(~ Dataset, scales = "free") +
  labs(
    title = "PCA Comparison: Raw vs Normalized Data",
    subtitle = "Projection of Banknote Authentication observations onto PC1 and PC2",
    x = "PC1",
    y = "PC2",
    color = "Class"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    strip.text = element_text(face = "bold"),
    legend.position = "right"
  )

print(pca_comparison_plot)


# C4: PCA Variance Explained

# Create variance-explained data frames
variance_raw_df <- data.frame(
  PC = paste0("PC", 1:length(pca_raw_var)),
  Variance = pca_raw_var * 100
)

variance_norm_df <- data.frame(
  PC = paste0("PC", 1:length(pca_norm_var)),
  Variance = pca_norm_var * 100
)

# Raw PCA variance plot
pca_variance_raw <- ggplot(
  variance_raw_df,
  aes(x = PC, y = Variance)
) +
  geom_col() +
  geom_text(
    aes(label = paste0(round(Variance, 2), "%")),
    vjust = -0.3,
    size = 4
  ) +
  labs(
    title = "Variance Explained by Principal Components - Raw Data",
    x = "Principal Component",
    y = "Variance Explained (%)"
  ) +
  theme_minimal(base_size = 14) +
  ylim(0, max(variance_raw_df$Variance) * 1.15)

print(pca_variance_raw)


# Normalized PCA variance plot
pca_variance_norm <- ggplot(
  variance_norm_df,
  aes(x = PC, y = Variance)
) +
  geom_col() +
  geom_text(
    aes(label = paste0(round(Variance, 2), "%")),
    vjust = -0.3,
    size = 4
  ) +
  labs(
    title = "Variance Explained by Principal Components - Normalized Data",
    x = "Principal Component",
    y = "Variance Explained (%)"
  ) +
  theme_minimal(base_size = 14) +
  ylim(0, max(variance_norm_df$Variance) * 1.15)

print(pca_variance_norm)


# C5: PCA Loadings

cat("\n================ PCA LOADINGS: RAW DATA ================\n")
print(round(pca_raw$rotation, 4))

cat("\n================ PCA LOADINGS: NORMALIZED DATA ================\n")
print(round(pca_norm$rotation, 4))


# C6: Percentage of variance explained

cat("\n================ VARIANCE EXPLAINED: RAW DATA ================\n")
print(round(pca_raw_var * 100, 2))

cat("\n================ VARIANCE EXPLAINED: NORMALIZED DATA ================\n")
print(round(pca_norm_var * 100, 2))