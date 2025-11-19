# Classifying Open-Ended Narratives of One's Sense of Self Using NLP and Machine Learning

This repository accompanies the tutorial paper **“Classifying Open-Ended Narratives of One’s Identity Using Natural Language Processing and Machine Learning”** which is currently under review. It includes R code for training a multiclass classification model that uses narrative language to categorize individuals into one of three ethnic–racial identity (ERI) profiles. The manuscript will be provided once it is published.

## Overview

Key components of the workflow include:

* Cleaning textual narrative data
* Feature extraction
* Feature selection
* Data preprocessing
* Hyperparameter tuning
* Model training and evaluation
* Feature importance
* Model testing and evaluation

## Repository Structure
```
├─ scripts/
│  ├─ 01_text_cleaning.R
│  ├─ 02_feature_selection.R
│  ├─ 03_data_preprocessing.R
│  └─ 04_rf_model_train_test.R
│
└─ README.md
```

## Getting Started

### Requirements

The tutorial uses R (version 4.5.1 or later recommended) and the following packages:

* `readxl`
* `dplyr`
* `fastDummies`
* `stats`
* `caret`
* `yardstick`
* `WriteXLS`

Install them with:

```r
install.packages(c("readxl", "dplyr", "fastDummies", "stats", "caret", "yardstick", "WriteXLS"))
```
### Notes

Throughout the scripts, use of specific package/libraries for each function is indicated w/ "::", e.g., "readxl::read_excel("pathname_to_file.xlsx")" uses the 'readxl' package.

df = dataframe or dataset

## Contact

For questions or collaborations, reach out through the repository’s issue tracker.
