data <- read.csv("data_banknote_authentication.txt", header = FALSE)
colnames(data) <- c("Variance", "Skewness", "Curtosis", "Entropy", "Class")

X_raw <- as.matrix(data[,1:4])

K <- 1:10  

# Normalization function
min_max_norm <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

X_norm <- apply(X_raw, 2, min_max_norm)

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

#A2: Norm data

kmeans_norm <- sapply(K, function(k){
  kmeans(X_norm, centers = k, nstart = 25)$tot.withinss
})

pam_norm <- sapply(K, function(k){
  pam_cost_function(X_norm, k)
})

norm_df <- data.frame(
  K = rep(K, 2),
  Cost = c(kmeans_norm, pam_norm),
  Method = rep(c("K-Means", "PAM"), each = length(K))
)

p2 <- ggplot(norm_df, aes(x = K, y = Cost, color = Method)) +
  geom_line(size = 1.3) +
  geom_point(size = 3) +
  labs(title = "Elbow Curve (Normalized Data)",
       x = "Number of Clusters (K)",
       y = "WCSS / PAM Cost") +
  theme_minimal(base_size = 14)

print(p2)
