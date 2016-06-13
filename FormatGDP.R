## Asssign initial working vector
gdp1 <- gdp

## Eliminate the first 5 rows and the last 5 rows because their structure don't match with the structure 
gdp2 <- gdp1[6:236,]

## Eliminate columns:3, 6:10 because they are nulls
gdp3 <- gdp2[,c(1,2,4,5)]

## Assign names to columns according to content
names(gdp3) <- c("country_name_3c", "country_ranking", "country_name", "country_gdp")

## Convert ranking and gdp to numeric data
gdp3$country_ranking <- as.integer(gdp3$country_ranking)
gdp3$country_gdp <- as.numeric(gsub(",","",gdp3$country_gdp)) ## eliminate thousand commas before converting to numeric

## Eliminate rows that do not correspond to a country
Missing_values <- is.na(gdp3$country_ranking) ## ranking = NA represent non specific countries
gdp4 <- gdp3[!is.na(gdp3$country_ranking),]
