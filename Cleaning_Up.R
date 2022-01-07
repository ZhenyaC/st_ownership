library(tidyverse)
library(dplyr)
library(shiny)
library(readxl)
library(lubridate)
library(DT)

across<-read_excel("data/Spreads_test.xls", sheet = 1)
head(across, 5)


#Jan 6
#across<-across%>%mutate(Date=format(Date, "%d-%m-%Y"))

#head(across)

#across$Date<-as.Date(across$Date, "%d-%b-%Y")

head(across, 5)

across%>%filter(Date >="2021-10-01")%>%mutate(Date=format(Date, "%d-%m-%Y"))%>%view()




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
head(ig_industry)

ig_industry<-ig_industry[-c(1:2),]
head(ig_industry)
#error here
boxplot(ig_industry, use.cols=TRUE)

colnames(ig_industry)
#Could not rename these cols:
#ig_industry%>% rename(`Basic Industry`=Basic_Industry,
                     # `Cap Goods` = Cap_Goods,
                    #  `Cons Goods`=Consumer_Goods,
                     # `Fin Svcs`= Fin_Svcs,
                     # `Real Estate`=`Real Estate`) 


min(across$Date)
min_date<-min(format(as.Date(across$Date, format="%d/%m/%Y"), "%Y"))

typeof(min_date)

read_excel("data/Spreads_test.xls", sheet = 5, range = "D1:W7000")

#read_csv("data/test1.csv")

#across%>%ggplot(aes(x=Date, y= AAA)) + geom_line()
