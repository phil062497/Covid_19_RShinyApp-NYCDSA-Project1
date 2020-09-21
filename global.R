library(dplyr)
library(forcats)

# load covid data
coviddata <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv", header = T)

choicestates = coviddata$state
choicecounties = coviddata$county
coviddata$date = as.Date(coviddata$date, format = "%Y-%m-%d")


coviddata2 = coviddata %>% filter(., date == "2020-05-30") %>% group_by(., state) %>% summarize(., sum1 = sum(cases))
coviddata3 = coviddata %>% filter(., date == "2020-05-30") %>% group_by(., state) %>% summarize(., sum1 = sum(deaths))

#1. scatterplot of new cases at the county level
#2. bar chart of total case counts in different counties and displaying them next to each other 
#3. map at the state level of total case counts, color differentiated 