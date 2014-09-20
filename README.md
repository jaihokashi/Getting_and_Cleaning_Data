---
title: ""
output: html_document
---

# Introduction

This is **Getting and Cleaning Data** course assignment and use **Human Activity Recognition Using Smartphones Dataset** from [UIC Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### The tidy data is generated by the following steps.
1. Read features_list.txt file and retrieve 2nd column from features_list to append as column name in both Test and Train data sets.
2. Read Train and Test data sets and append the column names from previous step.
3. Read subject and append at into both Train and Test data sets.
4. Read activity data and update with proper description.
5. Append the respective activity column on both Train and Test data sets.
6. Sync Column names so as to merge 2 data sets and then, merge 2 data sets.
7. Extracts only the measurements on the mean and standard deviation for each measurement.
8. Generate tidy data set with the average of each variable for each activity and each subject. 

The final tidy data set contains **88 variables** and **180 observation**.

This repository includes the following files:

- README.md
- run_analysis.R
- CodeBook.md

