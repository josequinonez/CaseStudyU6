## Question 1
## Match the data based on the country shortcode. How many of the IDs match? 

## Merge both dataframes joining them by the country shortcode
m1 <- merge(x=gdp3, y=edstats3, by.x = "country_name_3c", by.y = "CountryCode")
cat ("Answer")
cat ("Number of IDs match: ", round(dim(m1)[1],0)) ## The number of observations responds to the question of the matching IDs

## 189 records matched between GDP and EDSTATS (only South Sudan wasn't included in EDSTATS)


## Question 2
## Sort the data frame in ascending order by GDP (so United States is last).
## What is the 13th country in the resulting data frame?

## Sorting dataframe m1 into m2
m2 <- m1[order(m1$country_gdp),] ## ascending order on GDP
cat ("Answer")
cat (m2[13,"country_name"], " is the 13th country in the resulting dataframe") ## name of the 13th country

## St. Kitts and Nevis (KNA) is in position 13 acccording to an ascending order by GDP
## St. Kitts and Nevis has a GDP of 767 USD and is ranked #178
## Grenada (GRD) is in position 12 with the same GDP of 767 USD and is also ranked #178



## Question 3
## What are the average GDP rankings for the "High income: OECD" 
## and "High income: nonOECD" groups? 

## Filter High income: OECD countries and get their mean for Ranking
m3 <- m2[m2$Income_Group == "High income: OECD","country_ranking"]
m3_mean <- mean(m3)
cat ("Answer")
cat ("The average GDP ranking for the High income: OECD group is ", round(m3_mean,2))

## Filter High income: nonOECD countries and get their mean for Ranking
m4 <- m2[m2$Income_Group == "High income: nonOECD", "country_ranking"]
m4_mean <- mean(m4)
cat ("The average GDP ranking for the High income: nonOECD group is ", round(m4_mean,2))

## The mean ranking for High income: OECD is 32.96 (GDP average for this group is $1,483,917 USD)
## The mean ranking for High income: nonOECD is 91.91 (GDP average for this group is $104,349 USD)
