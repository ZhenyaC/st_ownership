library(tidyverse)
library(dplyr)
library(shiny)
library(readxl)
library(lubridate)
library(DT)

#across%>%filter(Date >="2021-10-01")%>%mutate(Date=format(Date, "%d-%m-%Y"))%>%view()

#For the Firt tab
across<-read_excel("data/Spreads_test.xls", sheet = 1)
#across<- across%>%mutate(Date=format(Date, "%d-%m-%Y"))
#typeof(Date)
across$Date<-as.Date(across$Date, "%d-%b-%Y")

across_pivoted<-across%>%pivot_longer(cols = -Date, names_to = "rating", values_to = "value")

#Jan 8: min_year and max_year do not work on UI side
#min_year <-min(format(as.Date(across$Date, format="%d-%m-%Y"), "%Y"))

#max_year <-max(format(as.Date(across$Date, format="%d-%m-%Y"), "%Y"))

min_year<-min(year(across$Date))

max_year<-max(year(across$Date))

#For the Second tab
ig_industry<-read_excel("data/Spreads_test.xls", sheet = 3, range = "D1:W7000")
ig_industry<-ig_industry[-c(1:2),]
names(ig_industry)[1] <- "Date"
ig_industry$Date<-as.Date(ig_industry$Date, "%d-%b-%Y")
colnames(ig_industry) <-strsplit(colnames(ig_industry), " \\(.*\\)")
names(ig_industry)<-names(ig_industry)%>%make.names()
ig_industry%>%
  filter(Date %in% as.Date(c("2021-10-21", "2020-03-23", "2019-12-04")))%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
  pivot_longer(cols = -Date, names_to = "industry", values_to = "value")%>%
  mutate(value=as.numeric(value))%>%
  ggplot(aes(x= industry, y= value, fill=Date)) + geom_bar(stat="identity", position = "dodge") + ylab("bps") + coord_flip()


### For LATAM
latam<-read_excel("data/Spreads_test.xls", sheet = 5, range = "D1:W7000")
#colnames()
head(latam)
latam<-latam[-c(1:2),]
names(latam)[1] <- "Date"
head(latam)
latam$Date<-as.Date(latam$Date, "%d-%b-%Y")
colnames(latam)<-strsplit(colnames(latam), " \\(.*\\)")
names(latam)<-names(latam)%>%make.names()
head(latam)
latam<-latam[-17:-20]
#mutate_all(latam[-1], function(x) as.numeric(as.character(x)))
head(latam)

pct_ch_per_county<-latam%>% filter(Date %in% as.Date(c("2020-12-31", "2021-11-25")))%>% mutate(Date=format(Date, "%d-%m-%Y")) %>%
  pivot_longer(cols = -Date, names_to = "country", values_to = "value")%>%
  mutate(value=as.numeric(value))%>%pivot_wider(id_cols=country, names_from = Date, values_from = value)%>%
  mutate(pct_ch=((`25-11-2021`-`31-12-2020`)/`31-12-2020`)*100)

pct_ch_per_county

pct_ch_per_county<-left_join(pct_ch_per_county, CODE, by=c("country"="COUNTRY"))

CODE<- read_csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv")