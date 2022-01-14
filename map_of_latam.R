library(rworldmap)  
df <- NULL  
df$country <- c("Brazil","Mexico","Argentina")  
df$code<-c("BRA", "MEX", "ARG")  
df$popsize<-c(1000, 5000, 200)  
df<-as.data.frame(df)  
sPDF <- joinCountryData2Map( df, joinCode = "ISO3", nameJoinColumn = "code")  
mapCountryData(sPDF, nameColumnToPlot="popsize", mapRegion='latin america')

sPDFmyCountries <- sPDF[sPDF$NAME %in% df$country,]

mapCountryData(sPDF, nameColumnToPlot="popsize", xlim=bbox(sPDFmyCountries)[1,], ylim=bbox(sPDFmyCountries)[2,])