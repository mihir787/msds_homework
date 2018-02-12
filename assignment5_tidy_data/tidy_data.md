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
y2016 <- df[-c(rowBadRecord),]
```

#Data Merging

```r
#a. read text file and set column names
y2015 <- read.table("yob2015.txt", header = FALSE, sep = ",")
colnames(y2015) <- c("first name", "gender" ,"amount of children")

#b. display last ten rows
tail(y2015, 10)
```

```
##       first name gender amount of children
## 33054       Ziyu      M                  5
## 33055       Zoel      M                  5
## 33056      Zohar      M                  5
## 33057     Zolton      M                  5
## 33058       Zyah      M                  5
## 33059     Zykell      M                  5
## 33060     Zyking      M                  5
## 33061      Zykir      M                  5
## 33062      Zyrus      M                  5
## 33063       Zyus      M                  5
```

```r
#It is interesting that all have 5 children, indicating that 5 children maybe the cutoff to make the list.

#c. Merge data
final <- merge(y2015, y2016, by="first name", )
```
