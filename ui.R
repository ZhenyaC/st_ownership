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
            ) 
            
            #selectInput("rating", "Choose a Rating", choices = across%>%
                       #   pivot_longer(cols = -Date, names_to = "rating", values_to = "value")%>%
                        #  pull(rating)
            #)
        ),
        
      
        # Show a plot of the generated distribution
        mainPanel(
          
           tabsetPanel(
             tabPanel("Spreads Across",
                      plotOutput("linePlot"),
                      tableOutput("table")
                      ),
             tabPanel("IG Spreads By Industry"
                      # plotOutput("linePlot"),
                      #tableOutput("table")
                     ),
             tabPanel("LATAM Spreads"
                      # plotOutput("linePlot"),
                      #tableOutput("table")
                     )
            
                   )
           
              )
    )
))
