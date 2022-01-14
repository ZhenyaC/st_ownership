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