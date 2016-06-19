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