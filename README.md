# EODE
Code for "Exhaustive Exploitation of Nature-inspired Computation for Cancer Screening in an Ensemble Manner"
## Framework
![model](https://github.com/wangxb96/EODE/blob/master/frameworkpro.png)
## Abstract
Accurate screening of cancer types is a critical process in cancer detection, which can help cancer patients by providing them with a precise treatment. Unfortunately, only a few characteristic biomarker genes from gene expression profiles  are closely associated with tumors. Therefore, it is relevant and essential to select biomarker genes from these profiles for screening in cancer. Recent nature-inspired computational methods have been proposed for the selection of relevant biomarker genes across multiple types of cancers. However, we note some limitations; such as low efficiency and poor generalization. To address these challenges, this paper proposes a framework called EODE, which incorporates the grey wolf optimizer (GWO) to optimize feature subsets and then creates an optimized ensemble classifier in a collaborative manner. We demonstrate the performance of our proposed model using 35 different cancer gene expression datasets. The experimental results reveal that our model has strong robustness compared with other benchmark methods for the identification of important biomarker genes across different cancer types. Furthermore, we investigate the general applicability of EODE on a pan-cancer dataset containing 33 different cancer types from the The Cancer Genome Atlas (TCGA) PanCanAtlas project. EODE achieved an accuracy of 0.8654 and performed better than the other computational models. In addition, we conduct gene ontology enrichment and pathology analyses to reveal new insights into the characterization and identification of underlying cancer pathogenesis.
## Folders
- **ComparisonMethods**: The baselines for comparison, including nature-inspired methods, machine learning methods and ensemble methods.
- **OriginalData**: The original data. They were randomly divided into the training set and the test set in an 8:2 ratio.
- **TrainData**: Training data used in the experiment.
- **TestData**: Test data used in the experiment.
## Instructions
### 1. Main Code
- EODE.m (This is the main file of the proposed model)
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
