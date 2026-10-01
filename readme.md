# **Banknote Authentication Clustering Analysis** 

A mini-project on **unsupervised clustering of the Banknote Authentication dataset** from the **UCI Machine Learning Repository** , implemented in **R** . 

The project investigates the cluster structure of banknote data using **K-Means, Partitioning Around Medoids (PAM), and Hierarchical Clustering** , and studies how **Min-Max normalization** affects the clustering results. **PCA** is additionally used to visualize the resulting cluster structure in two dimensions. 

# **Project Overview** 

The Banknote Authentication dataset contains numerical features extracted from images of banknotes. The original dataset provides a class label indicating whether a banknote is **genuine or forged** . 

Although the dataset has two known classes, this project treats the four numerical attributes as **unlabeled data during clustering** . The given class labels are used afterward only to compare and interpret the resulting clusters. 

# **Main objectives** 

- Understand and explore the Banknote Authentication dataset. 

- Apply **K-Means clustering** to the data. 

- Apply **PAM (K-Medoids)** clustering. 

- Compare clustering behavior before and after normalization. 

- Perform **Hierarchical Agglomerative Clustering** . 

- Generate and analyze dendrograms. 

- Determine an appropriate dendrogram cut-off. 

- Compare clusters with the original genuine/forged labels. 

- Use **PCA** to visualize cluster structure in two dimensions. 

# **Dataset: Banknote Authentication Dataset** 

**Source:** UCI Machine Learning Repository 

The dataset contains **1,372 observations** and **4 numerical features** , along with a class label. 

# **Feature Description** 

Variance Variance of the Wavelet Transformed image 

Skewness Skewness of the Wavelet Transformed image Curtosis Curtosis of the Wavelet Transformed image Entropy Entropy of the image Class Original authentication label 

The four numerical features are used for clustering. 

The class variable is **not used when forming clusters** . 

# **Class labels** 

The original dataset uses: 

- 0: Genuine 

- 1: Forged 

# **Methodology** 

The project is divided into two major parts. 

1. Dataset Understanding & EDA 

2. Apply K-Means on raw data 

3. Apply PAM on Raw Data 

4. Perform Hierarchical Clustering on raw data 

5. Perform Min-Max Normalization [0,1] on raw data 

6. Apply K-Means on normalized data 

7. Apply PAM on normalized data 

8. Hierarchical Clustering 

9. PCA Visualization 

# **Part A — Partitional Clustering** 

Two partitional clustering methods are studied: 

1. K-Means 

2. PAM (Partitioning Around Medoids / K-Medoids) 

The number of clusters is evaluated over a range of values of K. 

# **A1. K-Means** 

K-Means partitions observations into K clusters by assigning each observation to the nearest centroid. 

The main objective is to minimize the **Within-Cluster Sum of Squares (WCSS)** : 



where: 



- _C k_ = cluster _k_ 



A lower WCSS indicates more compact clusters. 

The **Elbow Method** is used to examine how WCSS changes as K increases. 

# **A2. PAM / K-Medoids** 

PAM is similar to K-Means, but instead of using the mathematical mean as the cluster center, it selects an actual observation from the dataset as the **medoid** . 

The clustering is evaluated using the total dissimilarity/cost. 

# **K-Means vs PAM** 

**K-Means PAM** Uses centroids Uses medoids 

Center may not be an actual observation Medoid is an actual observation Uses squared distances/WCSS Uses dissimilarity/cost More sensitive to outliers Generally more robust to outliers 

# ** Normalization** 

Each numerical feature is normalized using **Min-Max normalization** : 



This transforms every feature to the range: 

> [ 0,1 ] 

# **Why normalize?** 

K-Means, PAM, and hierarchical clustering rely on distances. 

If variables have very different numerical ranges, a feature with a larger scale can contribute disproportionately to the distance calculation. 

Normalization therefore allows the features to contribute on a comparable scale. 

# **Part A — Experimental Comparison** 

The following experiments are performed: 

# **Before normalization** 

- K-Means → WCSS vs K 

- PAM → Cost vs K 

# **After normalization** 

- K-Means → WCSS vs K 

- PAM → Cost vs K 

The plots are generated using **ggplot2** . 

The raw and normalized curves are compared to observe the effect of feature scaling on clustering. 

# **Part B — Hierarchical Clustering** 

Agglomerative hierarchical clustering is used to build a hierarchy of observations. 

Initially, each observation is considered a separate cluster. 

Clusters are progressively merged until all observations belong to one cluster. 

The result is visualized using a **dendrogram** . 

# **Ward's Linkage** 

The project uses **Ward's linkage (ward.D2)** . 

Ward's method merges clusters while minimizing the increase in within-cluster variation. 

Conceptually, it chooses the merge that causes the smallest increase in: 

# _WCSS_ 

This makes Ward's method particularly suitable for numerical data when compact clusters are of interest. 

# ** Dendrogram Analysis** 

Dendrograms are generated for: 

# **B1. Raw data** 

Raw features 

↓ 

Euclidean distance 

↓ 

Ward.D2 hierarchical clustering 

↓ 

Dendrogram 

# **B2.Normalized data** 

Normalized features [0,1] 

↓ 

Euclidean distance 

↓ 

Ward.D2 hierarchical clustering 

↓ 

# Dendrogram 

The two dendrograms are compared to examine how normalization changes the hierarchical structure. 

# ** Dendrogram Cut-Off** 

The cut-off is determined from the hierarchical clustering structure rather than simply choosing a height visually. 

The merge heights are: 



Successive differences can be calculated as: 



A large increase in merge height indicates that relatively dissimilar groups are being merged. 

The dendrogram can therefore be cut before a large merge-height increase to obtain a meaningful cluster partition. 

#  **PCA Visualization** 

PCA ( **Principal Component Analysis** ) is used as an additional visualization technique. 

The original dataset has four numerical dimensions, which cannot be directly visualized in a simple 2D scatter plot. 

PCA projects the data onto principal components. 

The first two components are used to produce: 

- PC1 vs PC2 plots 

- Cluster-colored observations 

- Comparison with genuine/forged labels 

# **Important distinction** 

# PCA **does not perform clustering** . 

It is used to visualize the structure of the data and the clusters obtained from clustering algorithms. 

# **Cluster vs Class Analysis** 

After clustering, the original class labels are used only for interpretation. 

For example, a cluster-count table can be generated: 

# **Cluster Genuine Forged** 

Cluster 1 ... ... Cluster 2 ... ... 

# **Cluster Genuine Forged** 

Cluster 3 ... 

This allows us to examine whether individual clusters are predominantly associated with genuine or forged notes. 

# **Important** 

The clustering algorithms do **not** use the Class column to determine the clusters. 

This keeps the clustering analysis **unsupervised** . 

# **Main Observations** 

The analysis investigates the following questions: 

# **1. Does normalization affect clustering?** 

Yes. Since the algorithms rely on distances, changing the feature scales changes the distance relationships and can therefore change the resulting clustering structure. 

# **2. Do K-Means and PAM produce identical clusters?** 

Not necessarily. 

K-Means uses centroids, whereas PAM uses actual observations as medoids. Therefore, their optimization criteria and resulting assignments can differ. 

# **3. Does hierarchical clustering produce the same structure?** 

The dendrogram provides a different view of the data because it represents a hierarchy of successive merges rather than directly optimizing a fixed partition. 

# **4. Why can PCA appear to show a different number of groups?** 

PCA is a **dimensionality-reduction technique** , not a clustering algorithm. Visual groups in a 2D PCA projection should therefore not automatically be interpreted as the definitive number of clusters. 

# **Software & Packages** 

The project is implemented in **R** . 

# **Main packages** 

ggplot2 

cluster factoextra dplyr tidyr 

ggdendro 

# **Key functions** 

|**Purpose**|**R Function**|
|---|---|
|K-Means|kmeans()|
|PAM|pam()|
|Distance matrix|dist()|
|Hierarchical clustering|hclust()|
|Cut dendrogram|cutree()|
|PCA|prcomp()|
|Plotting|ggplot()|



Dendrogram visualization fviz_dend() / ggdendro 

# **Repository Structure** 

banknote-clustering-analysis/ 

│ 

- ├── README.md │ 

- ├── data/ 

- │   └── banknote_authentication_dataset.csv │ ├── R/ 

- │   ├── 01_dataset_eda.R 

- │   ├── 02_part_A_kmeans_pam.R 

- │   ├── 03_part_B_hierarchical.R │   └── 04_pca_visualization.R │ 

- ├── plots/ │   ├── kmeans_pam_raw.png │   ├── kmeans_pam_normalized.png │   ├── dendrogram_raw.png │   ├── dendrogram_normalized.png │   ├── pca_raw.png │   └── pca_normalized.png │ 

- ├── results/ 

│   ├── cluster_counts_raw.csv │   └── cluster_counts_normalized.csv │ └── presentation/ └── banknote_clustering_presentation.pptx 

# **🔄 How to Run** 

**1. Clone the repository** git clone https://github.com/USERNAME/banknote-clustering-analysis.git 

**2. Open the project in R/RStudio. 3. Install required packages** install.packages(c( "ggplot2", "cluster", 

"factoextra", 

"dplyr", 

"tidyr", 

"ggdendro" 

)) 

# **4. Place the dataset inside:** 

data/ 

# **5. Run the R scripts in order.** 

# 📊 **Expected Outputs** 

The project produces: 

- Dataset summary and EDA 

- K-Means WCSS curves 

- PAM cost curves 

- Raw-data clustering results 

- Normalized-data clustering results 

- Raw-data dendrogram 

- Normalized-data dendrogram 

- Dendrogram cut-off analysis 

- PCA visualization 

- Cluster vs genuine/forged counts 

- Raw vs normalized comparisons 

# 🎓 **Academic Context** 

This project was completed as a **mini-project on clustering and unsupervised learning** . 

The analysis specifically addresses: 

# **Part A — Partitional Clustering** 

- K-Means 

- PAM 

- Sum of squares / cost vs K 

- Min-Max normalization 

- Raw vs normalized comparison 

# **Part B — Hierarchical Clustering** 

- Dendrogram generation 

- Cut-off selection 

- Cluster/class comparison 

- Min-Max normalization 

- Raw vs normalized dendrogram comparison 

# **🔄 Key Takeaway** 

The project demonstrates that **feature scaling is an important consideration in distance-based clustering** . K-Means, PAM, and hierarchical clustering provide complementary perspectives on the structure of the Banknote Authentication dataset, while PCA provides a useful two-dimensional visualization of that structure. 

The original class labels are retained for **post-clustering comparison** , rather than being used to train the clustering algorithms. 

# **🔄 Author** 

# **Your Name** 

Mini Project — Clustering Analysis Course: ____________________ Institution: ____________________ Academic Year: 2026 

# 📚 **Dataset Reference** 

# **Banknote Authentication Dataset** 

UCI Machine Learning Repository 

Dua, D. and Graff, C. (2019). UCI Machine Learning Repository, University of California, Irvine, School of Information and Computer Sciences. 

# ⭐ **Topics** 

R Clustering K-Means PAM K-Medoids Hierarchical-Clustering Dendrogram PCA DataScience Machine-Learning UCI Banknote-Authentication Unsupervised-Learning 

