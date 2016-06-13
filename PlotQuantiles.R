## Question 5
## Cut the GDP ranking into 5 separate quantile groups.
## Make a table versus Income.Group. 
## How many countries are Lower middle income 
## but among the 38 nations with highest GDP?

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
table(m3$Income_Group, m3$Income_Level) ## The intersection between the 4th row and the 5th column respondes to question 5

## Answer 5
## There are 5 "Lower middle income" countries 
## within the 38 nations with highest GDP (quantile Q5)

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

## Plot log(gdp) by country gdp classified according to quantiles
## Interpretation: The plot shows even less differences  than the previous one
## because there is a wide range of GDPs for the 38 nations with highest GDP.
## That's why 5 Lower middle income countries got to be included in this range
