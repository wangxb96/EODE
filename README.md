<div align="center">
<h1>Exhaustive Exploitation of Nature-inspired Computation for Cancer Screening in an Ensemble Manner</h1>

[**Xubin Wang**](https://github.com/wangxb96)<sup>1</sup> · **Yunhe Wang**<sup>2*</sup> · **Zhiqing Ma**<sup>3</sup> · **Ka-Chun Wong**<sup>4</sup> · **Xiangtao Li**<sup>1*</sup>


<sup>1</sup>Jilin University · <sup>2</sup>Hebei University of Technology · <sup>3</sup>Northeast Normal University · <sup>4</sup>City University of Hong Kong

<sup>*</sup>corresponding authors

[**Code**](https://github.com/wangxb96/EODE)

</div>

# Contents 
- [Overview](#Overview)
- [Framework](#Framework)
- [Data and Baseline Availability](#Data-and-Baseline-Availability)
- [Dependencies](#Dependencies)
- [Instructions](#Instructions)
- [Results](#Results)
- [Contact](#Contact)


## Overview
Accurate screening of cancer types is crucial for effective cancer detection and precise treatment selection. However, the association between gene expression profiles and tumors is often limited to a small number of biomarker genes. While computational methods using nature-inspired algorithms have shown promise in selecting predictive genes, existing techniques are limited by inefficient search and poor generalization across diverse datasets. This study presents a framework termed Evolutionary Optimized Diverse Ensemble Learning (EODE) to improve ensemble learning for cancer classification from gene expression data. The EODE methodology combines an intelligent grey wolf optimization algorithm for selective feature space reduction, guided random injection modeling for ensemble diversity enhancement, and subset model optimization for synergistic classifier combinations. Extensive experiments were conducted across 35 gene expression benchmark datasets encompassing varied cancer types. Results demonstrated that EODE obtained significantly improved screening accuracy over individual and conventionally aggregated models. The integrated optimization of advanced feature selection, directed specialized modeling, and cooperative classifier ensembles helps address key challenges in current nature-inspired approaches. This provides an effective framework for robust and generalized ensemble learning with gene expression biomarkers. 

## Framework
![model](https://github.com/wangxb96/EODE/blob/master/frameworkpro.png)
Overview of the proposed EODE algorithm: In the GWO feature selection phase, the original cancer gene expression training data is utilized to train all base classifiers, and the classifier with the highest performance is selected as the evaluation classifier. The processed data is then optimized to construct an ensemble model. Specifically, the training data is incrementally clustered using the K-means method to form subspace clusters. These clusters are used to train individual base classifiers, which are then added to the model pool. Any classifiers in the pool with below-average performance are filtered out. Next, the GWO is applied to optimize the classifier pool and determine the best possible ensemble combination. Finally, the optimized ensemble model is evaluated on the independent test dataset using a plurality voting strategy to generate the final cancer type predictions.

## Data and Baseline Availability
- **ComparisonMethods**: The baselines for comparison, including nature-inspired methods, machine learning methods and ensemble methods.
- **OriginalData**: The original data. They were randomly divided into the training set and the test set in an 8:2 ratio.
- **TrainData**: Training data used in the experiment.
- **TestData**: Test data used in the experiment.

## Dependencies
- This project was developped with **MATLAB 2021a**. Early versions of MATLAB may have incompatibilities.

## Instructions
### 1. Main Code
- EODE.m (This is the main file of the proposed model)
  - You can replace your data in the **Problem**. For example:
    - Problem = {'The_name_of_your_own_data'};
  - How to load your own data?
    ```
      traindata = load(['C:\Users\c\Desktop\EODE\train\',p_name]);
      traindata = getfield(traindata, p_name);
      data = traindata;
      feat = data(:,1:end-1); 
      label = data(:,end);
    ```
  - You can set the number of iterations of the whole experiment through **numRun**
  - The file path can be replaced under **traindata** and **testdata**
  - The parameters of GWO algorithm can be replaced in:
    - opts.k = 3; % number of k in K-nearest neighbor
    - opts.N = 100; % number of solutions
    - opts.T = 50; % maximum number of iterations
      
To reproduce our experiments, you can run **EODE.m** ten times and take the average of the results.
### 2. Data Partition 
- DataPartition.m (This file is used to divide the raw data in a 8:2 ratio)
### 3. Feature Selection Phase
- jGreyWolfOptimizer.m (To find an optimal feature subset)
### 4. Classifier Generation Phase
- generateClusters.m (To generate multiple clusters)
- trainClassifiers.m (To train base classifiers use these clusters)
### 5. Classifier Pool Optimization Phase
- classifierSelectionGWO.m (Use GWO algorithm to find an optimal classifier set)
- GWOPredict.m
### 6. Model Fusion
- fusion.m
### 7. Fitness Function
- jFeatureSelectionFunction.m
- jFitnessFunction.m

## Results
We conducted experiments on 35 datasets encompassing various cancer types, and the results demonstrate the effectiveness of our algorithm compared to four nature-inspired ensemble methods (PSOEL, EAEL, FESM, and GA-Bagging-SVM), six benchmark machine learning algorithms (KNN, DT, ANN, SVM, DISCR, and NB), six state-of-the-art ensemble algorithms (RF, ADABOOST, RUSBOOST, SUBSPACE, TOTALBOOST, and LPBOOST), and seven nature-inspired methods (ACO, CS, DE, GA, GWO, PSO, and ABC). Our algorithm outperformed these methods in terms of classification accuracy.

## Contact
wangxb19 at mails.jlu.edu.cn
