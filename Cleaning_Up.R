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
#JAn 8
min_year <-min(format(as.Date(across$Date, format="%d-%m-%Y"), "%Y"))
min_year
typeof(min_year)

typeof(min(year(across$Date)))

max(year(across$Date))

head(across, 5)

across%>%filter(Date >="2008-01-01")%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
  select(c("Date", "AAA", "AA", "A", "BBB", "BB", "B", "CCC", `AVG IG`, `AVG HY`)) %>%
  mutate(AVG_IG_HY_diff=`AVG IG`-`AVG HY`, BBB_BB_diff= BBB-BB, POST_CC_LOW_AAA=min(across$AAA, na.rm=TRUE),  
         POST_CC_LOW_AA=min(across$AA, na.rm=TRUE), POST_CC_LOW_A=min(across$A, na.rm=TRUE), POST_CC_LOW_BBB=min(across$BBB, na.rm=TRUE))



#JAn 6
colnames(across)<-make.names(colnames(across))

across_min<-across%>%
  mutate(AVG_IG_HY_diff=AVG.IG-AVG.HY, BBB_BB_diff= BBB-BB, POST_CC_LOW_AAA=min(across$AAA, na.rm=TRUE), LOW_AAA_date=across$Date[which.min(across$AAA)], 
         POST_CC_LOW_AA=min(across$AA, na.rm=TRUE), LOW_AA_date=across$Date[which.min(across$AA)],
         POST_CC_LOW_A=min(across$A, na.rm=TRUE), LOW_A_date=across$Date[which.min(across$A)],
         POST_CC_LOW_BBB=min(across$BBB, na.rm=TRUE), LOW_BBB_date=across$Date[which.min(across$BBB)],
         POST_CC_LOW_BB=min(across$BB, na.rm=TRUE), LOW_BB_date=across$Date[which.min(across$BB)],
         POST_CC_LOW_B=min(across$B, na.rm=TRUE), LOW_B_date=across$Date[which.min(across$B)],
         POST_CC_LOW_CCC=min(across$CCC, na.rm=TRUE), LOW_CCC_date=across$Date[which.min(across$CCC)],
         POST_CC_AVG.IG=min(across$AVG.IG, na.rm=TRUE), LOW_AVG.IG_date=across$Date[which.min(across$AVG.IG)],
         POST_CC_AVG.HY=min(across$AVG.HY, na.rm=TRUE), LOW_AVG.HY_date=across$Date[which.min(across$AVG.HY)])%>%
        filter(Date =="2021-11-15")%>%mutate(Date=format(Date, "%d-%m-%Y")) %>% 
        select(-c("AAA", "AA", "A", "BBB", "BB", "B", "CCC", "AVG.IG", "AVG.HY", "MER", "AVG_IG_HY_diff", "BBB_BB_diff"))%>%
        t()
across_min

across%>%filter(Date =="2021-11-15")%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
  select(c("Date", "AAA", "AA", "A", "BBB", "BB", "B", "CCC", "AVG.IG", "AVG.HY")) %>%   
 pivot_longer(cols= -Date, names_to = "rating", values_to = "value")

        
        
colnames(across)

across[which.min(across$AAA)]
across$Date[which.min(across$AAA)]




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
