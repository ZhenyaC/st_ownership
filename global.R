library(tidyverse)
library(dplyr)
library(shiny)
library(readxl)
library(lubridate)
library(DT)

#across%>%filter(Date >="2021-10-01")%>%mutate(Date=format(Date, "%d-%m-%Y"))%>%view()

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

