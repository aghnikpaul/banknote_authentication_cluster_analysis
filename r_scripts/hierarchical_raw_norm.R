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


# Part B: Hierarchical clustering dendrograms 

#B1: raw data


dist_raw <- dist(X_raw, method = "euclidean")
hc_raw   <- hclust(dist_raw, method = "ward.D2")

#Find the cut point
h    <- hc_raw$height               # merge heights, sorted ascending
gaps <- diff(h)                     # jump between consecutive merges
i    <- which.max(gaps)             # biggest jump
cut_height <- (h[i] + h[i + 1]) / 2 # middle of that gap
k    <- length(h) + 1 - i           # clusters left after cutting (n - i)

# should equal k
length(unique(cutree(hc_raw, h = cut_height)))

#Plot
dendro_raw <- dendro_data(hc_raw, type = "rectangle")

ggplot() +
  geom_segment(data = dendro_raw$segments,
               aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_hline(yintercept = cut_height,
             colour = "blue", linewidth = 1, linetype = "dashed") +
  annotate("text",
           x = max(dendro_raw$segments$x), y = cut_height,
           label = paste0("Cut at height = ", round(cut_height, 2),
                          "  (k = ", k, " clusters)"),
           colour = "blue", hjust = 1, vjust = -0.7, size = 5) +
  labs(title = "Hierarchical Clustering Dendrogram (Raw Data)",
       x = "Observations",
       y = "Height") +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_blank(),
        panel.grid.major.x = element_blank())

#B2: Norm data


dist_norm <- dist(X_norm, method = "euclidean")
hc_norm   <- hclust(dist_norm, method = "ward.D2")

#find the cut point
h    <- hc_norm$height              # merge heights, sorted ascending
gaps <- diff(h)                     # jump between consecutive merges
i    <- which.max(gaps)             # biggest jump
cut_height <- (h[i] + h[i + 1]) / 2 # middle of that gap
k    <- length(h) + 1 - i           # clusters left after cutting (n - i)

#should equal k
length(unique(cutree(hc_norm, h = cut_height)))

# plot
dendro_norm <- dendro_data(hc_norm, type = "rectangle")

ggplot() +
  geom_segment(data = dendro_norm$segments,
               aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_hline(yintercept = cut_height,
             colour = "red", linewidth = 1, linetype = "dashed") +
  annotate("text",
           x = max(dendro_norm$segments$x), y = cut_height,
           label = paste0("Cut at height = ", round(cut_height, 2),
                          "  (k = ", k, " clusters)"),
           colour = "red", hjust = 1, vjust = -0.7, size = 5) +
  labs(title = "Hierarchical Clustering Dendrogram (Normalized Data)",
       x = "Observations",
       y = "Height") +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_blank(),
        panel.grid.major.x = element_blank())

