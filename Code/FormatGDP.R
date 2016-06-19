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

## The number of eliminated rows is 331 - 190 = 141