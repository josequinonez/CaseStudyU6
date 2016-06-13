## Question 4
## Plot the GDP for all of the countries. 
## Use ggplot2 to color your plot by Income Group. 


## Load ggplot2 library
library(ggplot2)

## Plot GDP having: X axis = Income Group, Y axis = GDP (divided by 1M)
## Axes are inverted
## Colored by Income Group
ggplot (m2, 
        aes(x = Income_Group, y = (country_gdp/1000000), color = Income_Group)) +
  geom_jitter() +
  coord_flip() +
  theme(legend.position="none") +
    xlab("Income Group") +
    ylab("GDP (Millions USD)") +
  labs(title="GDP by Income Group") 

## Answer 4
## Plot gdp (in millions USD) for all countries 
## Interpretation: The plot shows how most of the countries' GDP (184 out of 189) are below $2.5M
## and reveals a few emerging countries as opportunity areas for boosting development



## Plot GDP having: X axis = Income Group, Y axis = log(GDP)
## Considering log(gdp) for better resolution
## Axes are inverted
## Colored by Income Group
ggplot (m2, 
        aes(x = Income_Group, y = log(country_gdp), color = Income_Group)) +
  geom_jitter() +
  coord_flip() +
  theme(legend.position="none") +
  xlab("Income Group") +
  ylab("log(GDP)") +
  labs(title="GDP by Income Group") 

## Answer 4
## Plot log(gdp) for all countries 
## Interpretation: The plot shows less differences  than the previous one,
## but reveals more clearly the number of countries for each income group

