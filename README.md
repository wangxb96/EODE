# EODE: "Exhaustive Exploitation of Nature-inspired Computation for Cancer Screening in an Ensemble Manner"
# Contents 
- [Framework](#Framework)
- [Overview](#Overview)
- [Folders](#Folders)
- [Dependencies](#Dependencies)
- [Instructions](#Instructions)
- [Contact](#Contact)

## Framework
![model](https://github.com/wangxb96/EODE/blob/master/frameworkpro.png)
## Overview
Accurate screening of cancer types is crucial for effective cancer detection and precise treatment selection. However, the association between gene expression profiles and tumors is often limited to a small number of biomarker genes. While computational methods using nature-inspired algorithms have shown promise in selecting predictive genes, existing techniques are limited by inefficient search and poor generalization across diverse datasets. This study presents a framework termed Evolutionary Optimized Diverse Ensemble Learning (EODE) to improve ensemble learning for cancer classification from gene expression data. The EODE methodology combines an intelligent grey wolf optimization algorithm for selective feature space reduction, guided random injection modeling for ensemble diversity enhancement, and subset model optimization for synergistic classifier combinations. Extensive experiments were conducted across 35 gene expression benchmark datasets encompassing varied cancer types. Results demonstrated that EODE obtained significantly improved screening accuracy over individual and conventionally aggregated models. The integrated optimization of advanced feature selection, directed specialized modeling, and cooperative classifier ensembles helps address key challenges in current nature-inspired approaches. This provides an effective framework for robust and generalized ensemble learning with gene expression biomarkers. 

## Folders
- **ComparisonMethods**: The baselines for comparison, including nature-inspired methods, machine learning methods and ensemble methods.
- **OriginalData**: The original data. They were randomly divided into the training set and the test set in an 8:2 ratio.
- **TrainData**: Training data used in the experiment.
- **TestData**: Test data used in the experiment.
## Dependencies
- This project was developped with **MATLAB 2021a**. Early versions of MATLAB may have incompatibilities.
## Instructions
### 1. Main Code
- EODE.m (This is the main file of the proposed model)
  - You can replace your data in the **Problem**
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

## Contact
wangxb19 at mails.jlu.edu.cn
