# GDP Case Study
Jose Quinonez  
12 de junio de 2016  



# Introduction

### The World Bank Data  (http://data.worldbank.org) provides free and open databases about economic indicators in countries worldwide. 

#### One of the most popular indicators is the *GDP* Ranking. This is the Gross domestic product ranking table that covers a measurument of aggregate economic activity at a national and regional levels.

#### The Education Statistics (*EdStats*) is a collection of indicators related to education, access and expenditure (http://datatopics.worldbank.org/education).

### This document is the deliverable of the analysis of the given data regarding GDP and EDSTATS.

### The objective of this presentation is to show the analysis process, elaborate  on findings, and propose data-driven conclusions.

###Input data are files:
* GDP.csv (https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv)
* EDSTATS_Country.csv (https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

###Procedure:
* Load data
* Clean data to a tidy structure
* Merge data into a single structure
* Analize data
* Answer the target questions
* Summarize Findings & Conclusions

###Deliverable:
* A project uploaded to a Github repo

### Project directory structure:
* CaseStudyU6 (Root Dir)
  * /makefile.R
  * /Code (Dir)
    * /Code/LoadData.R
    * /Code/FormatGDP.R
    * /Code/FormatEDSTATS.R
    * /Code/Merge.R
    * /Code/Plot.R
    * /Code/PlotQuantiles.R
  * /Data (Dir)
    * /Data/EDSTATS_Country.csv
    * /Data/GDP.csv
  * /Paper (Dir)
    * /Paper/CaseStudyU6.Rmd
    * /Paper/CaseStudyU6.md
    * /Paper/CaseStudyU6.html
    * /Paper/CaseStudyU6_files (Dir)


# -------------------------------------------------------------------------

Load Data


```r
## Load libraries
library(downloader)
library(ggplot2)

## Set working directory for data files
setwd("../Data")

## Download files: GDP & EDSTATS
download("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",destfile="GDP.csv")
download("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile="EDSTATS_Country.csv")

## Read files: GDP & EDSTATS
gdp <- read.csv("GDP.csv", stringsAsFactors = FALSE, header = FALSE)
edstats <- read.csv("EDSTATS_Country.csv", stringsAsFactors = FALSE, header = FALSE)

setwd("../Code")
```

Clean data to a tidy structure

###### cleaning: GDP


```r
## Asssign initial working vector
gdp1 <- gdp

## Identify the initial number of rows at GDP
InitialNumofRowsGDP <- dim(gdp1)[1]

## Eliminate columns:3, 6:10 because they are nulls
gdp2 <- gdp1[,c(1,2,4,5)]

## Assign names to columns according to content
names(gdp2) <- c("country_name_3c", "country_ranking", "country_name", "country_gdp")

## Convert ranking and gdp to numeric data
gdp2$country_ranking <- suppressWarnings(as.integer(gdp2$country_ranking))
gdp2$country_gdp <- suppressWarnings(as.numeric(gsub(",","",gdp2$country_gdp))) ## eliminate thousand commas before converting to numeric

## Eliminate rows that do not correspond to a country
Missing_values <- is.na(gdp2$country_ranking) ## ranking = NA represent non specific countries
gdp3 <- gdp2[!Missing_values,] ## Final number of rows

## Identify the final number of rows at GDP
FinalNumofRowsGDP <- dim(gdp3)[1]

cat ("The number of eliminated rows in file GDP is :", InitialNumofRowsGDP, " - ", FinalNumofRowsGDP, " = ", InitialNumofRowsGDP - FinalNumofRowsGDP)
```

```
## The number of eliminated rows in file GDP is : 331  -  190  =  141
```

###### Cleaning: EDSTATS


```r
## Asssign initial working vector
edstats1 <- edstats

## Identify the initial number of rows at EDSTATS
InitialNumofRowsEDSTATS <- dim(edstats1)[1]

## Assign names to columns according to content of row 1
names(edstats1) <- gsub(" ", "_", edstats1[1,])

## Eliminate the first row because it corresponds to column names
edstats2 <- edstats1[2:InitialNumofRowsEDSTATS,]

## Eliminate rows with missing countryCode or Income_Group
Missing_values <- (is.na(edstats2$CountryCode)) | (edstats2$CountryCode == "") | (is.na(edstats2$Income_Group)) | (edstats2$Income_Group == "")
edstats3 <- edstats2[!Missing_values,]

## Identify the final number of rows at EDSTATS
FinalNumofRowsEDSTATS <- dim(edstats3)[1]

cat("The number of eliminated rows in file EDSTATS is :",  InitialNumofRowsEDSTATS, " - ",  FinalNumofRowsEDSTATS, " = ", InitialNumofRowsEDSTATS - FinalNumofRowsEDSTATS)
```

```
## The number of eliminated rows in file EDSTATS is : 235  -  210  =  25
```

Merge data, Analize data, and Answer the target questions


### Question 1
### Match the data based on the country shortcode. How many of the IDs match? 


```r
## Merge both dataframes joining them by the country shortcode
m1 <- merge(x=gdp3, y=edstats3, by.x = "country_name_3c", by.y = "CountryCode")

cat ("Number of IDs match: ", round(dim(m1)[1],0)) ## The number of observations responds to the question of the matching IDs
```

```
## Number of IDs match:  189
```


### Question 2
### Sort the data frame in ascending order by GDP (so United States is last).
### What is the 13th country in the resulting data frame?


```r
## Sorting dataframe m1 into m2
m2 <- m1[order(m1$country_gdp),] ## ascending order on GDP

cat (m2[13,"country_name"], " is the 13th country in the resulting dataframe") ## name of the 13th country
```

```
## St. Kitts and Nevis  is the 13th country in the resulting dataframe
```

```r
## St. Kitts and Nevis (KNA) is in position 13 acccording to an ascending order by GDP
## St. Kitts and Nevis has a GDP of 767 USD and is ranked #178
## Grenada (GRD) is in position 12 with the same GDP of 767 USD and is also ranked #178
```


###  Question 3
### What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups? 


```r
## Filter High income: OECD countries and get their mean for Ranking
m3 <- m2[m2$Income_Group == "High income: OECD","country_ranking"]
m3_mean <- mean(m3)

cat ("The average GDP ranking for the High income: OECD group is ", round(m3_mean,2))
```

```
## The average GDP ranking for the High income: OECD group is  32.97
```

```r
## Filter High income: nonOECD countries and get their mean for Ranking
m4 <- m2[m2$Income_Group == "High income: nonOECD", "country_ranking"]
m4_mean <- mean(m4)

cat ("The average GDP ranking for the High income: nonOECD group is ", round(m4_mean,2))
```

```
## The average GDP ranking for the High income: nonOECD group is  91.91
```

```r
## The mean ranking for High income: OECD is 32.96 (GDP average for this group is $1,483,917 USD)
## The mean ranking for High income: nonOECD is 91.91 (GDP average for this group is $104,349 USD)
```

## Question 4
## Plot the GDP for all of the countries. Use ggplot2 to color your plot by Income Group


```r
## Plot GDP having: X axis = Income Group, Y axis = GDP (divided by 1M)
## Axes are inverted,  Colored by Income Group

ggplot (m2, 
        aes(x = Income_Group, y = (country_gdp/1000000), color = Income_Group)) +
  geom_jitter() +
  coord_flip() +
  theme(legend.position="none") +
    xlab("Income Group") +
    ylab("GDP (Millions USD)") +
  labs(title="GDP by Income Group") 
```

![](CaseStudyU6_files/figure-html/Plot.R-1.png)<!-- -->

```r
cat("Each plot represents a country's GDP (colored by Income Group)")
```

```
## Each plot represents a country's GDP (colored by Income Group)
```

```r
cat ("This chart shows how concentrated is the GDP in the smallest extreme, and the difference versus USA's highest  GDP")
```

```
## This chart shows how concentrated is the GDP in the smallest extreme, and the difference versus USA's highest  GDP
```

```r
ggplot(m2, aes(country_gdp/1000000, fill = Income_Group)) +
  geom_histogram(bins=30) +
  xlab("GDP (Millions USD)") +
  ylab("Number of countries") +
  labs(title="GDP by Income Group") + 
  theme(legend.position="right") +
  scale_fill_discrete(name = "Income Group")
```

![](CaseStudyU6_files/figure-html/Plot.R-2.png)<!-- -->

```r
cat("In this other type of chart, the number of countries is more measurable to differentiate the extreme opposites in the distribution of GDP.")
```

```
## In this other type of chart, the number of countries is more measurable to differentiate the extreme opposites in the distribution of GDP.
```

```r
cat ("")
cat("Interpretation: Both charts show how most of the countries (184 out of 189) are below $2.5M GDP and reveals a few emerging countries as opportunity areas for boosting development.")
```

```
## Interpretation: Both charts show how most of the countries (184 out of 189) are below $2.5M GDP and reveals a few emerging countries as opportunity areas for boosting development.
```

## Question 5
## Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
## How many countries are Lower middle income, but among the 38 nations with highest GDP?


```r
## Calculate 5 quantiles (20% each) considering country gdp
quantiles <- quantile(m2$country_gdp, probs= seq(0,1,0.2))

## Create a new dataset m3 to add the new variable Income_Level
m3 <- m2

## Clasify each country's Income_Level according to the quantile that corresponds to the country_gdp 
m3[m3$country_gdp >= quantiles[1] & m3$country_gdp <= quantiles[2], "Income_Level"] <- "Q1"
m3[m3$country_gdp > quantiles[2] & m3$country_gdp <= quantiles[3], "Income_Level"] <- "Q2"
m3[m3$country_gdp > quantiles[3] & m3$country_gdp <= quantiles[4], "Income_Level"] <- "Q3"
m3[m3$country_gdp > quantiles[4] & m3$country_gdp <= quantiles[5], "Income_Level"] <- "Q4"
m3[m3$country_gdp > quantiles[5] & m3$country_gdp <= quantiles[6], "Income_Level"] <- "Q5"

## Create table to summarize Income_Group (rows) vs Income_Level (columns)
table(m3$Income_Group, m3$Income_Level) ## The intersection between the 4th row and the 5th column responds to question 5
```

```
##                       
##                        Q1 Q2 Q3 Q4 Q5
##   High income: nonOECD  2  4  8  5  4
##   High income: OECD     0  1  1 10 18
##   Low income           11 16  9  1  0
##   Lower middle income  16  9 11 13  5
##   Upper middle income   9  8  8  9 11
```

```r
cat("There are 5 Lower middle income countries within the 38 nations with highest GDP (quantile Q5)")
```

```
## There are 5 Lower middle income countries within the 38 nations with highest GDP (quantile Q5)
```

```r
## Plot country gdp by income group
## Considering log(gdp) for better resolution
## Considering 5 quantiles 
ggplot (m2, 
        aes(x = Income_Group, y = log(m2$country_gdp), color = Income_Group)) +
  geom_jitter() +
  coord_flip() +
  ylab("GDP Quantiles") +
  xlab("Income Group") +
  labs(title="GDP Quantiles by Income Group") +
  scale_y_discrete(limits = log(quantiles),
                   labels=c("", "Q1", "Q2", "Q3", "Q4", "Q5")) +
  theme(legend.position="none")
```

![](CaseStudyU6_files/figure-html/PlotQuantiles.R-1.png)<!-- -->

```r
cat ("Interpretation: Each quantile has 38 dots, each dot representing the log function of each country's GDP.")
```

```
## Interpretation: Each quantile has 38 dots, each dot representing the log function of each country's GDP.
```

```r
cat ("The log funtion reduces the extreme difference in scales. Since the range of GDPs in the 5th quantile (38 highest GDP nations) is so wide, that's why 5 Lower middle income countries got to be included in this range.")
```

```
## The log funtion reduces the extreme difference in scales. Since the range of GDPs in the 5th quantile (38 highest GDP nations) is so wide, that's why 5 Lower middle income countries got to be included in this range.
```




# -------------------------------------------------------------------------


# Main findings:

#### Data reveals extreme differences between countries GDPs. While most of the countries (184 out of 189) have a GDP less than $2.5M, USA´s GDP is greater than $16M, and 90% of the countries have a GDP less than $647K (1/25 times USA's GDP).

#### Data about population is not present to calculate GDP per capita, in order to show another perspective.

#### Current clasification for Income Group does not necesarily correspond to the GDP, because there are some countries considered as "Lower middle income" that have greater GDP than countries considered as "Upper middle income".

#### "High income: nonOECD" countries vary their GDP in several ranges, so some of these countries have smaller GDP than others categorized as "Low Income".

#### EDSTATS file details some qualitative variables like "Year of Latest agricultural census" or "Government Accounting concept". There are some findings  for further analysis:
* The variable "Latest household survey" could be split in two: one variable for the Indicator (values: MICS, DHS, NSS, etc.), and other variable for the year of data gathering.
* There are blanks in variables from the EDSTATS, e.g. there are 155 blanks in variable "National_accounts_reference_year" from 189 observations in the merged dataset.
* In the other hand, countries with highest GDPs have less blank values in the set of columns, e.g. USA or Australia have 6 blank columns, while countries like Tuvalu and Marshall Islands have 22 and 18 blank columns respectively.


# Conclusions:

### In order to improve the criteria for analysis, I propose:
* to separate a variable for OECD Group [Y/N], so each country could be classified as OECD Group in one variable
* Income Group [High, Upper middle, Lower middle, Lower Income] in another variable. So the OECD variable is independent from the level of income.

### Include population data to facilitate obtaining GDP per capita. 

### Define a standard Income Group category according to specific ranges in GDP or GDP per Capita values, e.g. 
* High Income = GDP per capita greater than $30K
* Upper middle income = GDP per capita between $20K and $30K
* Lower middle income = GDP per capita between $10K and $20K
* Low income  = GDP per capita less than $10K

### Complete the blank values in EDSTATS data to improve the overall analysis.

### The Histogram chart in question 4 reveals an outright conclusion about the worldwide distribution of GDP. There is a lot of efforts to do in order to understand the variables that trigger local economic development, but it certainly starts  by having better measurements that can be analyzed for better decision-making.

Jose Quinonez
