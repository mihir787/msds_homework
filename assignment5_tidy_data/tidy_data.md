---
title: "Assignment 5 - Tidy Data"
author: "mihir parikh"
date: "2/12/2018"
output:
  html_document:
    keep_md: true
---

#Data Munging

```r
#a. read text file, set column names
df <- read.table("yob2016.txt", header = FALSE, sep = ";")
colnames(df) <- c("first name", "gender" ,"amount of children")

#b. summary and structure of data
summary(df)
```

```
##    first name    gender    amount of children
##  Aalijah:    2   F:18758   Min.   :    5.0   
##  Aaliyan:    2   M:14111   1st Qu.:    7.0   
##  Aamari :    2             Median :   12.0   
##  Aarian :    2             Mean   :  110.7   
##  Aarin  :    2             3rd Qu.:   30.0   
##  Aaris  :    2             Max.   :19414.0   
##  (Other):32857
```

```r
str(df)
```

```
## 'data.frame':	32869 obs. of  3 variables:
##  $ first name        : Factor w/ 30295 levels "Aaban","Aabha",..: 9317 22546 3770 26409 12019 20596 6185 339 9298 11222 ...
##  $ gender            : Factor w/ 2 levels "F","M": 1 1 1 1 1 1 1 1 1 1 ...
##  $ amount of children: int  19414 19246 16237 16070 14722 14366 13030 11699 10926 10733 ...
```

```r
dim(df)
```

```
## [1] 32869     3
```

```r
head(df)
```

```
##   first name gender amount of children
## 1       Emma      F              19414
## 2     Olivia      F              19246
## 3        Ava      F              16237
## 4     Sophia      F              16070
## 5   Isabella      F              14722
## 6        Mia      F              14366
```

```r
#c. display bad record
rowBadRecord <- grep("yyy", df$`first name`)

#d. remove bad record
df <- df[-c(rowBadRecord),]
```
