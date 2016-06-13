## Set working directory for this project
setwd("/documents/personal/smu/doing data science/u6/casestudyu6")

## LoadData.R loads the csv files
source("LoadData.R")

## FormatGDP.R cleans the GDP dataset and makes it tidy
source("FormatGDP.R")

## FormatEDSTATS.R cleans the EDSTATS dataset and makes it tidy
source("FormatEDSTATS.R")

## Merge.R merges both datasets and answers the first 3 questions
source("Merge.R")

## Plot.R plots countries GDP from the merged dataset and answers to question 4
source("Plot.R")

## PlotQuantiles.R calculates quantiles,
## classify countries according to their GDP in this variable, 
## answers to question 5, and plots GDP grouped by quantiles
source("PlotQuantiles.R")
