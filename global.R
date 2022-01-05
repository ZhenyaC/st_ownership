library(tidyverse)
library(dplyr)
library(shiny)
library(readxl)
library(lubridate)


across<-read_excel("data/Spreads_test.xls", sheet = 1)
across$Date<-as.Date(across$Date, "%d-%b-%Y")
