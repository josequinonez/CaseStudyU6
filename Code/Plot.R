## Question 4
## Plot the GDP for all of the countries. 
## Use ggplot2 to color your plot by Income Group. 


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

cat("Each plot represents a country's GDP (colored by Income Group)")
cat ("This chart shows how concentrated is GDP in the smallest extreme, and the difference versus USA's GDP")


ggplot(m2, aes(country_gdp/1000000, fill = Income_Group)) +
  geom_histogram(bins=30) +
  xlab("GDP (Millions USD)") +
  ylab("Number of countries") +
  labs(title="GDP by Income Group") + 
  theme(legend.position="right") +
  scale_fill_discrete(name = "Income Group")
  
  
cat("In this other type of chart, the number of countries is more measurable to differentiate the extre opposites in the distribution of GDP.")
cat ("")
cat("Interpretation: Both charts show how most of the countries (184 out of 189) are below $2.5M GDP and reveals a few emerging countries as opportunity areas for boosting development.")

