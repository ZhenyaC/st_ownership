library(tidyverse)
library(dplyr)
library(shiny)
library(readxl)
library(lubridate)

across<-read_excel("data/Spreads_test.xls", sheet = 1)
head(across, 5)

#across%>%ggplot(aes(x=Date, y= AAA)) + geom_line()


across$Date<-as.Date(across$Date, "%d-%b-%Y")
head(across, 5)

#across%>%filter(Date>="01-11-2021" & Date<="19-11-2021")

across%>%pivot_longer(cols = -Date, names_to = "rating", values_to = "value")%>% ggplot(aes(x=Date, y= value, color=rating)) + geom_line()




ig_industry<-read_excel("data/Spreads_test.xls", sheet = 3, range = "D1:W7000")
ig_industry<-ig_industry[-c(1:2),]
names(ig_industry)[1] <- "Date"
names(ig_industry)
head(ig_industry, 5)

ig_industry$Date<-as.Date(ig_industry$Date, "%d-%b-%Y")
ig_industry
#names(titanic_df)[names(titanic_df) == 'P_Class'] <- "PCLASS'

#companies$Name <- as.character(companies$Name)
#unlist(strsplit(companies$Name, " \\(.*\\)"))

colnames(ig_industry) <-strsplit(colnames(ig_industry), " \\(.*\\)")
ig_industry

read_excel("data/Spreads_test.xls", sheet = 5, range = "D1:W7000")