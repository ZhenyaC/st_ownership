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

across$Date<-as.Date(across$Date, "%d-%b-%Y")
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

names(across)<-names(across)%>%make.names()
head(across)

across%>%
  mutate(AVG_IG_HY_diff=AVG.IG-AVG.HY, BBB_BB_diff= BBB-BB, POST_CC_LOW_AAA=min(across$AAA, na.rm=TRUE), LOW_AAA_date=across$Date[which.min(across$AAA)], 
         POST_CC_LOW_AA=min(across$AA, na.rm=TRUE), LOW_AA_date=across$Date[which.min(across$AA)],
         POST_CC_LOW_A=min(across$A, na.rm=TRUE), LOW_A_date=across$Date[which.min(across$A)],
         POST_CC_LOW_BBB=min(across$BBB, na.rm=TRUE), LOW_BBB_date=across$Date[which.min(across$BBB)],
         POST_CC_LOW_BB=min(across$BB, na.rm=TRUE), LOW_BB_date=across$Date[which.min(across$BB)],
         POST_CC_LOW_B=min(across$B, na.rm=TRUE), LOW_B_date=across$Date[which.min(across$B)],
         POST_CC_LOW_CCC=min(across$CCC, na.rm=TRUE), LOW_CCC_date=across$Date[which.min(across$CCC)],
         POST_CC_AVG.IG=min(across$AVG.IG, na.rm=TRUE), LOW_AVG.IG_date=across$Date[which.min(across$AVG.IG)],
         POST_CC_AVG.HY=min(across$AVG.HY, na.rm=TRUE), LOW_AVG.HY_date=across$Date[which.min(across$AVG.HY)])%>%
         filter(Date =="2021-11-15")%>%
         select(-c("AAA", "AA", "A", "BBB", "BB", "B", "CCC", "AVG.IG", "AVG.HY", "MER", "AVG_IG_HY_diff", "BBB_BB_diff"))%>%
         t()
across_min

across%>%filter(Date =="2021-11-15")%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
  select(c("Date", "AAA", "AA", "A", "BBB", "BB", "B", "CCC", "AVG.IG", "AVG.HY")) %>%   
 pivot_longer(cols= -Date, names_to = "rating", values_to = "value")

sd<-across%>%
  filter(Date <="2020-03-01")%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
  select(c("Date", "AAA", "AA", "A", "BBB", "BB", "B", "CCC")) %>%
  sapply(sd, na.rm=TRUE) 
sd

mean_rt<-across%>%
  filter(Date <="2020-03-01")%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
  select(c("Date", "AAA", "AA", "A", "BBB", "BB", "B", "CCC")) %>%
  summarise_if(is.numeric, mean, na.rm=TRUE)
mean_rt

rbind(sd[-1], mean_rt)
  
across%>%
  filter(Date <="2021-11-25")%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
  select(c("Date", "AAA", "AA", "A", "BBB", "BB", "B", "CCC")) %>%
  mutate(across$AAA-across$AA, across$AAA-across$A, across$AAA-across$BBB, across$AAA-across$BB, across$AAA-across$B, 
         across$AAA-across$CCC)



  sapply(sd, na.rm=TRUE) 

  
       
        
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


colnames(ig_industry)


names(ig_industry)<-names(ig_industry)%>%make.names()

head(ig_industry)


temp<-ig_industry%>%
  filter(Date >="2021-10-25")%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
  pivot_longer(cols = -Date, names_to = "industry", values_to = "value")%>%
  mutate(value=as.numeric(value))
  
temp

#ggplot(temp, aes(y=industry, x=value, fill=industry)) + geom_boxplot()

temp%>%filter(industry %in% c("Automotive", "Banks", "Energy"," Healthcare", "Insurance"))%>%
  ggplot(aes(x=Date, y=value, fill=industry)) + geom_col()

#filter(Date == c("2021-10-21", "2020-03-23", "2019-12-04")
# For Industry tab
### Does not pick up third date, , i also used position = position_dodge() argument to geom_bar() function.
## And sorting bars alphabetically or by numeric value does not work ggplot(df, aes(x = reorder(day, -perc), y = perc))
ig_industry%>%
  filter(Date %in% as.Date(c("2021-10-21", "2020-03-23", "2019-12-04")))%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
  pivot_longer(cols = -Date, names_to = "industry", values_to = "value")%>%
  mutate(value=as.numeric(value))%>%
  ggplot(aes(x= industry, y= value, fill=Date)) + geom_bar(stat="identity", position = "dodge") + ylab("bps") + coord_flip()

head(ig_industry)
# does not work
ggplot(temp, aes(x=Date, y=value, color=industry)) + geom_area()
          

ig_industry%>%
  filter(Date =="2021-10-21")%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
  pivot_longer(cols = -Date, names_to = "industry", values_to = "value")%>%
  ggplot(aes(x=industry, y=value, fill=industry)) + geom_col()


head(across)



##################################
library(fmsb)
radarchart(ig_industry)
min(across$Date)
min_date<-min(format(as.Date(across$Date, format="%d/%m/%Y"), "%Y"))
typeof(min_date)
###################################

# For LATAM TAB

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

#df[ , chars] <- as.data.frame(apply(df[ , chars], 2, as.numeric))

sapply(latam, is.character)



latam[1,2] -latam[2,2]
as.data.frame(apply(latam[ , chars], 2, as.numeric))



#latam%>%summarise(sum(is.na(Date)))
test2<-latam%>% filter(Date %in% as.Date(c("2020-12-31", "2021-11-25")))%>% 
  mutate(Date=format(Date, "%d-%m-%Y"))
test2
write.csv(test2)
write.csv(test2, file = "c:\\data\\test2.csv")

#typeof(test2)
#test2%>%
#  sapply(test2[-1], function(x) as.numeric(as.character(x)))%>%view()


#################################3
test3<-test2%>%
  select(-Date)%>%
  mutate_if(is.character, as.numeric)

test3%>% mutate((test3-test3)*100)
  

(test3[1,] -test3[-1,])*100

apply(test2[-1]), 

##########################################
  
pct_ch_per_county<-latam%>% filter(Date %in% as.Date(c("2020-12-31", "2021-11-25")))%>% mutate(Date=format(Date, "%d-%m-%Y")) %>%
    pivot_longer(cols = -Date, names_to = "country", values_to = "value")%>%
    mutate(value=as.numeric(value))%>%pivot_wider(id_cols=country, names_from = Date, values_from = value)%>%
    mutate(pct_ch=((`25-11-2021`-`31-12-2020`)/`31-12-2020`)*100)

pct_ch_per_county

pct_ch_per_county<-left_join(pct_ch_per_county, CODE, by=c("country"="COUNTRY"))
  

               ig_industry%>%
                 select(as.Date(ig_industry$Date))%>%
                 mutate(Date=format(Date, "%d-%m-%Y"))%>%
                 pull(ig_industry$Date)%>%
                 unique() %>%
                 sort()
