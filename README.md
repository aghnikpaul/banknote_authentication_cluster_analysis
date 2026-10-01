[readme.md](https://github.com/user-attachments/files/32911543/readme.md)
# **Banknote Authentication Clustering Analysis** 

A mini-project on **unsupervised clustering of the Banknote Authentication dataset** from the **UCI Machine Learning Repository** , implemented in **R** . 

The project investigates the cluster structure of banknote data using **K-Means, Partitioning Around Medoids (PAM), and Hierarchical Clustering** , and studies how **Min-Max normalization** affects the clustering results. **PCA** is additionally used to visualize the resulting cluster structure in two dimensions. 




## **Project Overview** 

The Banknote Authentication dataset contains numerical features extracted from images of banknotes. The original dataset provides a class label indicating whether a banknote is **genuine or forged** . 

Although the dataset has two known classes, this project treats the four numerical attributes as **unlabeled data during clustering** . The given class labels are used afterward only to compare and interpret the resulting clusters. 

### **Main objectives** 

1. Understand and explore the Banknote Authentication dataset. 

2. Apply K-Means clustering to the data. 

3. Apply PAM (K-Medoids) clustering. 

4. Compare clustering behavior before and after normalization. 

5. Perform Hierarchical Agglomerative Clustering. 

6. Generate and analyze dendrograms. 

7. Determine an appropriate dendrogram cut-off. 

8. Compare clusters with the original genuine/forged labels. 

9. Use PCA to visualize cluster structure in two dimensions. 

# **Dataset** 

### **Banknote Authentication Dataset** 

**Source:** UCI Machine Learning Repository 

The dataset contains **1,372 observations** and **4 numerical features** , along with a class label. 

Variance: Variance of the Wavelet Transformed image 

Skewness: Skewness of the Wavelet Transformed image 

Curtosis: Curtosis of the Wavelet Transformed image 

Entropy: Entropy of the image 

Class: Original authentication label 

The four numerical features are used for clustering. 

The class variable is **not used when forming clusters** . 

### **Class labels** 

The original dataset uses: 

- 0: Genuine 

- 1: Forged 

# **Methodology** 

The project is divided into two major parts. 

1. Banknote Authentication Dataset 

2. Dataset Understanding & EDA 

3. K-Means on Raw Data 

4. PAM on Raw Data 

5. Hierarchical Clustering on Raw Data 

6. Min-Max Normalization [0,1] of Raw Data 

7. K-Means on Normalized data 

8. PAM on Normalized data 

9. Hierarchical Clustering on Normalized data 

10. PCA Visualization of data before on Normalization 

11. PCA Visualization of data after on Normalization 

# **Part A — Partitional Clustering** 

Two partitional clustering methods are studied: 

1. **K-Means** 

2. **PAM (Partitioning Around Medoids / K-Medoids)** 

The number of clusters is evaluated over a range of values of K. 

## **A1. K-Means** 

K-Means partitions observations into K clusters by assigning each observation to the nearest centroid. 

The main objective is to minimize the **Within-Cluster Sum of Squares (WCSS)** : 



where: WCSS= ∑∑||xi - μk||<sup>2</sup> 

1. xi= observation 

2. Ck= cluster _k_ 

3. μk= centroid of cluster k 

A lower WCSS indicates more compact clusters. 

The **Elbow Method** is used to examine how WCSS changes as K increases. 

## **A2. PAM / K-Medoids** 

PAM is similar to K-Means, but instead of using the mathematical mean as the cluster center, it selects an actual observation from the dataset as the **medoid** . 

The clustering is evaluated using the total dissimilarity/cost. 

### **K-Means vs PAM** 

#### **K-Means** 

1. Uses centroids 

2. Center may not be an actual observation 

3. Uses squared distances/WCSS 

4. More sensitive to outliers 

#### **PAM** 

1. Uses medoids 

2. Medoid is an actual observation 

3. Uses dissimilarity/cost Uses dissimilarity/cost 

4. Generally more robust to outliers 

# **Normalization** 

Each numerical feature is normalized using **Min-Max normalization** : 
            X’ =(X-Xmin)/(Xmax-Xmin)
This transforms every feature to the range: [0,1]


This transforms every feature to the range: 



### **Why normalize?** 

K-Means, PAM, and hierarchical clustering rely on distances. 

If variables have very different numerical ranges, a feature with a larger scale can contribute disproportionately to the distance calculation. 

Normalization therefore allows the features to contribute on a comparable scale. 

# **Part A — Experimental Comparison** 

The following experiments are performed: 

### **Before normalization** 

1. K-Means: WCSS vs K 

2. PAM: Cost vs K 

### **After normalization** 

1. K-Means: WCSS vs K 

2. PAM: Cost vs K 

The plots are generated using **ggplot2** . 

The raw and normalized curves are compared to observe the effect of feature scaling on clustering. 

# **Part B — Hierarchical Clustering** 

Agglomerative hierarchical clustering is used to build a hierarchy of observations. 

Initially, each observation is considered a separate cluster. 

Clusters are progressively merged until all observations belong to one cluster. 

The result is visualized using a **dendrogram** . 

## **Ward's Linkage** 

The project uses **Ward's linkage (ward.D2)** . 

Ward's method merges clusters while minimizing the increase in within-cluster variation. 

Conceptually, it chooses the merge that causes the smallest increase in: 

#### _WCSS_ 

This makes Ward's method particularly suitable for numerical data when compact clusters are of interest. 

# **Dendrogram Analysis** 

Dendrograms are generated for: 

### **B1. Raw data** 

1. Raw features 

2. Euclidean distance 

3. Ward.D2 hierarchical clustering 

4. Dendrogram 

### **B2. Normalized data** 

1. Normalized features [0,1] 

2. Euclidean distance 

3. Ward.D2 hierarchical clustering 

4. Dendrogram 

The two dendrograms are compared to examine how normalization changes the hierarchical structure. 

# **Dendrogram Cut-Off** 

The cut-off is determined from the hierarchical clustering structure rather than simply choosing a height visually. 

The merge heights are: h1,h2,...,h(n-1)


Successive differences can be calculated as: h'= h(i+1) - hi



A large increase in merge height indicates that relatively dissimilar groups are being merged. 

The dendrogram can therefore be cut before a large merge-height increase to obtain a meaningful cluster partition. 

# **PCA Visualization** 

PCA ( **Principal Component Analysis** ) is used as an additional visualization technique. 

The original dataset has four numerical dimensions, which cannot be directly visualized in a simple 2D scatter plot. 

PCA projects the data onto principal components. 

The first two components are used to produce: 

1. PC1 vs PC2 plots 

2. Cluster-colored observations 

3. Comparison with genuine/forged labels 

### **Important distinction** 

#### PCA **does not perform clustering** . 

It is used to visualize the structure of the data and the clusters obtained from clustering algorithms. 

# **Cluster vs Class Analysis** 

After clustering, the original class labels are used only for interpretation. 

For example, a cluster-count table can be generated: 

Cluster a: #Genuine #Forged Cluster b: #Genuine #Forged 

This allows us to examine whether individual clusters are predominantly associated with genuine or forged notes. 

### **Important** 

The clustering algorithms do **not** use the Class column to determine the clusters. 

This keeps the clustering analysis **unsupervised** . 

# **Main Observations** 

The analysis investigates the following questions: 

### **1. Does normalization affect clustering?** 

Yes. Since the algorithms rely on distances, changing the feature scales changes the distance relationships and can therefore change the resulting clustering structure. 

### **2. Do K-Means and PAM produce identical clusters?** 

Not necessarily. 

K-Means uses centroids, whereas PAM uses actual observations as medoids. Therefore, their optimization criteria and resulting assignments can differ. 

### **3. Does hierarchical clustering produce the same structure?** 

The dendrogram provides a different view of the data because it represents a hierarchy of successive merges rather than directly optimizing a fixed partition. 

### **4. Why can PCA appear to show a different number of groups?** 

PCA is a **dimensionality-reduction technique** , not a clustering algorithm. Visual groups in a 2D PCA projection should therefore not automatically be interpreted as the definitive number of clusters. 

# **Software & Packages** 

The project is implemented in **RStudio**. 

### **Main packages** 

1. ggplot2 

2. cluster 

3. factoextra 

4. dplyr 

5. tidyr 

6. ggdendro 

**Key functions:** Purpose & R Function 

K-Means: kmeans() 

PAM: pam() 

Distance matrix; dist() 

Hierarchical clustering: hclust() 

Cut dendrogram: cutree() 

PCA: prcomp() 

Plotting: ggplot() 

Dendrogram visualization: fviz_dend() / ggdendro (Used here) 

# **Repository Structure** 

banknote_authentication_cluster_analysis.git/
readme.md

Data/
data_banknote_authentication.txt

R Scripts/ 
1.	k-means_pam_raw.R
2.	k-means_pam_norm.R
3.	hieararchical_raw_norm.R
4.	pca_raw_norm.R

plots/
1.	kmeans_pam_raw.png
2.	kmeans_pam_norm.png
3.	dendro_raw.png
4.	dendro_norm.png
5.	pca_raw.png
6.	pca_norm.png

results/
1.	cluster_counts_raw.csv
2.	cluster_counts_norm.csv

presentation/
banknote_clustering_presentation.pptx

# **How to Run** 

### **1. Clone the repository** 

git clone: https://github.com/aghnikpaul/banknote_authentication_cluster_analysis.git 

### **2. Open the project in R/RStudio.** 

### **3. Install required packages** 

install.packages(c( "ggplot2", "cluster", "factoextra", "dplyr", "tidyr", "ggdendro" )) 

### **4. Place the dataset inside:** 

data/ 

### **5. Run the R scripts in order.** 

# **Expected Outputs** 

The project produces: 

1. Dataset summary and EDA 

2. K-Means WCSS curves 

3. PAM cost curves 

4. Raw-data clustering results 

5. Normalized-data clustering results 

6. Raw-data dendrogram 

7. Normalized-data dendrogram 

8. Dendrogram cut-off analysis 

9. PCA visualization 

10. Cluster vs genuine/forged counts 

11. Raw vs normalized comparisons 

# **Academic Context** 

This project was completed as a **mini-project on clustering and unsupervised learning** . 

The analysis specifically addresses: 

### **Part A — Partitional Clustering** 

1. K-Means 

2. PAM 

3. Sum of squares / cost vs K 

4. Min-Max normalization 

5. Raw vs normalized comparison 

### **Part B — Hierarchical Clustering** 

1. Dendrogram generation 

2. Cut-off selection 

3. Cluster/class comparison 

4. Min-Max normalization 

5. Raw vs normalized dendrogram comparison 

# **Key Takeaway** 

The project demonstrates that **feature scaling is an important consideration in distancebased clustering** . K-Means, PAM, and hierarchical clustering provide complementary perspectives on the structure of the Banknote Authentication dataset, while PCA provides a useful two-dimensional visualization of that structure. 

The original class labels are retained for **post-clustering comparison** , rather than being used to train the clustering algorithms. 






Clustering Analysis 

# **Dataset Reference** 

**Banknote Authentication Dataset** 

UCI Machine Learning Repository 

Dua, D. and Graff, C. (2019). UCI Machine Learning Repository, University of California, Irvine, School of Information and Computer Sciences. 

## **Topics** 

R Clustering K-Means PAM K-Medoids Hierarchical-Clustering Dendrogram PCA Data-Science MachineLearning UCI Banknote-Authentication Unsupervised-Learning 

#### **Aghnik Paul** 
Data Analyst & ML Consultant
E-mail: aghnik.stat@gmail.com
linkedin: https://linkedin.com/in/aghnikpaul
Portfolio: https://aghnikpaul.page.gd
