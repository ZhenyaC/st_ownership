#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Bofa OAS Spreads"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("years",
                        "Select a range of years:",
                        min = min_year,
                        max = max_year,
                        value = c(min_year, max_year),
                        sep = ""), 
            
            #selectInput("rating", "Choose Rating", choices = c("AAA", "AA", "A", "BBB", "B", "CCC", "AVG IG", "AVG HY"))
            #selectInput("choice", "Choose Rating", choices = names(across))
            selectizeInput("rating", "Choose a Rating", choices = across%>%
                          pivot_longer(cols = -Date, names_to = "rating", values_to = "value")%>%
                          pull(rating), multiple = T
            ),
            

            selectizeInput("industry", "Choose an Industry", choices = ig_industry%>%
                            pivot_longer(cols = -Date, names_to = "industry", values_to = "value")%>%
                            pull(industry)%>%
                            unique() %>%
                            sort(), multiple = T, selected="Automotive"),
                 
            
            
            selectizeInput("date", "Choose a Date", choices = across%>%
                           pivot_longer(cols = -Date, names_to = "rating", values_to = "value")%>%
                           pull(Date)%>%
                           unique() %>%
                            sort(),multiple = T, selected="2021-11-25"
            )
        ),
        
      
        # Show a plot of the generated distribution
        mainPanel(
          
           tabsetPanel(
             tabPanel("Spreads Across",
                      plotOutput("linePlot"),
                      tableOutput("table")
                      ),
             tabPanel("IG Spreads By Industry",
                       plotOutput("barPlot")
                      #tableOutput("table")
                     ),
             tabPanel("LATAM Spreads",
                      plotlyOutput("mapPlot")
                      #tableOutput("table")
                     )
            
                   )
           
              )
    )
))
