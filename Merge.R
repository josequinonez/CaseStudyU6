## Question 1
## Match the data based on the country shortcode. How many of the IDs match? 

## Merge both dataframes joining them by the country shortcode
m1 <- merge(x=gdp4, y=edstats2, by.x = "country_name_3c", by.y = "CountryCode")
dim(m1) ## The number of observations responds to the question of the matching IDs

## Answer 1
## 189 out of 190 GDP records matched (only South Sudan wasn't included in EDSTATS)



## Question 2
## Sort the data frame in ascending order by GDP rank (so United States is last).
## What is the 13th country in the resulting data frame?

## Sorting dataframe m1 into m2
m2 <- m1[order(-m1$country_ranking),] ## descending order on ranking so USA is last
m2[13,"country_name"] ## name of the 13th country

## Answer 2
## St. Kitts and Nevis (KNA) is in position 13 acccording to an ascending order by GDP (or descending order by Ranking)

## St. Kitts and Nevis has a GDP of 767 USD and is ranked #178
## Grenada (GRD) is in position 12 with the same GDP of 767 USD and is also ranked #178



## Question 3
## What are the average GDP rankings for the "High income: OECD" 
## and "High income: nonOECD" groups? 

## Filter High income: OECD countries and get their mean for Ranking
m3 <- m2[m2$Income_Group == "High income: OECD",]
m3_mean <- mean(m3$country_ranking)
m3_mean ## ranking mean for countries whose Income_Group == "High income: OECD"

## Filter High income: nonOECD countries and get their mean for Ranking
m4 <- m2[m2$Income_Group == "High income: nonOECD",]
m4_mean <- mean(m4$country_ranking)
m4_mean ## ranking mean for countries whose Income_Group == "High income: nonOECD"

## Answer 3
## The mean ranking for High income: OECD is 32.96 (GDP average for this group is $1,483,917 USD)
## The mean ranking for High income: nonOECD is 91.91 (GDP average for this group is $104,349 USD)
