---
title: "Covid-19 analysis in R (Top 20 Countries Affected)"
description: Where have most recorded cases and death occured?
date: '2020-10-10'
tags:
- covid19
- pandemic
featured_image: https://www.rcsi.com/dublin/-/media/feature/news/dublin/stock-images/covid-19-stock.jpg?h=575&w=752&la=en&hash=CA988B680AAC5AB49806CC2786D4E716
---

This was my first project. I started off by loading the relevant packages, and used the httr package which will make fetch my data from the European CDC (ECDC) website, download it to my disk and then read the file into R. This is what makes the data dynamic, given that with updated cases the ECDC makes to the data online, each time I run the program it will execute commands in light of the latest data.


```{r}
library(dplyr)
library(ggplot2)
library(httr)
url1 <- "https://opendata.ecdc.europa.eu/covid19/nationalcasedeath/csv/data.csv"
GET(url1, write_disk(tf <-tempfile(fileext=".csv")))
library(readr)
df <- read_csv((tf))

```

The data table looks like this by the way: 

![](/en/post/covid19_files/Picture1.png)



The next step involved cleaning the data and grouping each country, followed by adding up all of the cases and all of the deaths, I then assigned these with the labels 'cases' and 'deaths'



```{r}

cases <- df %>%
  filter(indicator == "cases") %>%
  group_by(country) %>%
  summarise(cases=sum(weekly_count)) 

deaths <- df %>%
  filter(indicator == "deaths")%>%
  group_by(country) %>%
  summarise(deaths=sum(weekly_count)) 

cases
deaths

```

I have now created two tables that look like the image below. They show me all countries, and the sum of all their recorded cases and deaths.

![](/en/post/covid19_files/tibbles.png)


I now want to know the countries/territories with the highest case and death count. With the commands below I generate a tibble showing me the top 20 worst affected countries.

```{r}

top_20_cases <- cases %>% top_n(20)
top_20_deaths <- deaths %>% top_n(20)

top_20_cases
top_20_deaths

```
![](/en/post/covid19_files/deaths_tibble.png)


I then visualized the data using ggplot to get a better look at both cases and death in chart format. Charts were both ordered from highest to lowest.

```{r}
                                           
top_20_deaths %>%
  ggplot(aes(x = reorder(country,deaths), y = deaths)) + coord_flip()+geom_bar(stat="identity", width=0.3) +
  theme_classic() +
  labs(title = "Covid-19 deaths", x= "Countries", y= "confirmed deaths") +
  theme(plot.title = element_text(hjust = 0.8)) 
```

![](/en/post/covid19_files/covid19deathsgraph.png)


```{r}

top_20_cases %>%
  ggplot(aes(x = reorder(country,cases), y = cases)) + coord_flip()+geom_bar(stat="identity", width=0.3) +
  theme_classic() +
  labs(title = "Covid-19 cases", x= "Countries", y= "confirmed cases") +
  theme(plot.title = element_text(hjust = 0.8)) + scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
#had to add last list of code to remove scientific notation on the y axis

```

![](/en/post/covid19_files/covid19casesgraph.png)