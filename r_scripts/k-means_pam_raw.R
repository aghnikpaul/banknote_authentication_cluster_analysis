# load libs and data set, remove column headings
library(cluster)
library(ggplot2)
library(ggdendro)

set.seed(123)

data <- read.csv("data_banknote_authentication.txt", header = FALSE)
colnames(data) <- c("Variance", "Skewness", "Curtosis", "Entropy", "Class")

X_raw <- as.matrix(data[,1:4])


###############################################################################
# Part A partitional clust, elbow curve(K-Means & PAM)


K <- 1:10   

# Correct PAM Cost Function
pam_cost_function <- function(X, k) {
  pam_model <- pam(X, k)
  clusters <- pam_model$clustering
  medoids <- pam_model$medoids
  
  cost <- 0
  for (i in 1:nrow(X)) {
    medoid <- medoids[clusters[i], ]
    cost <- cost + sum((X[i,] - medoid)^2)
  }
  return(cost)
}

#A1: Raw data

kmeans_raw <- sapply(K, function(k){
  kmeans(X_raw, centers = k, nstart = 25)$tot.withinss
})

pam_raw <- sapply(K, function(k){
  pam_cost_function(X_raw, k)
})

raw_df <- data.frame(
  K = rep(K, 1),
  Cost = c(kmeans_raw, pam_raw),
  Method = rep(c("K-Means", "PAM"), each = length(K))
)

p1 <- ggplot(raw_df, aes(x = K, y = Cost, color = Method)) +
  geom_line(size = 1.3) +
  geom_point(size = 3) +
  labs(title = "Elbow Curve (Raw Data)",
       x = "Number of Clusters (K)",
       y = "WCSS / PAM Cost") +
  theme_minimal(base_size = 14)

print(p1)
