shinyUI(
  fluidPage(
    
    # Application title
    titlePanel("BOFA OAS Spreads Analysis"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        
        selectizeInput("lei",
                       "Lei:",
                       choices = lei_list,
                       selected = c("01KWVG908KE7RKPTNP46"),
                       multiple = T),
        
        selectizeInput("county",
                       "County Code:",
                       choices = county_list,
                       selected = c("53001"),
                       multiple = T),
        
        width = 2
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          
          tabPanel("Spreads Across Asset Classes",
                   plotlyOutput("acrossPlot"),
                   tableOutput("acrossTable")
          ),
          
          tabPanel("Investment Grade",
                   plotlyOutput("igPlot"),
                   tableOutput("igTable")
          ),
          tabPanel("LATAM",
                   plotlyOutput("latamPlot"),
                   tableOutput("latamTable")
          ),
          tabPanel("Map",
                   leafletOutput("gMap"),
                   selectInput("mapRace",
                               "Map Race",
                               choices = race_list,
                               selected = "Asian"),
                   selectInput("leiMap",
                               "LEI for Map",
                               choices = lei_list,
                               selected = "01KWVG908KE7RKPTNP46")
          ),
          # tabPanel("Mean Loan",
          #          plotOutput("avg_loan_race_plot"),
          #          plotOutput("avg_loan_age_plot"),
          #          selectInput("avgRace",
          #                      "Race",
          #                      choices = race_list,
          #                      selected = "Asian"),
          #          selectInput("avgAge",
          #                      "Age",
          #                      choices = age_list,
          #                      selected = ">25")
          #          
          # ),
          tabPanel("HY Spreads",
                   tableOutput("hyTable")
          ),
          tabPanel("Summary",
                   verbatimTextOutput("textSummary")
          )
        )
      )
    )
  )
)