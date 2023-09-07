# EODE
Code for "Exhaustive Exploitation of Nature-inspired Computation for Cancer Screening in an Ensemble Manner"
## Framework
![model](https://github.com/wangxb96/EODE/blob/master/frameworkpro.png)
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
