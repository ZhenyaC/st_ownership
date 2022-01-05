ui <- fluidPage(
  titlePanel("Spreads")
  sidebarLayout(
    selectInput("rating_one",
                label=("Select a Rating"),
                choices = across%>%
                  pivot_longer(cols = -Date, names_to = "rating", values_to = "value")%>%
                  pull(rating),
                selectInput("rating_multi",
                            label = ("Select Ratings"),
                            multiple = TRUE,
                            selectize = FALSE,
                            choices = across%>%
                              pivot_longer(cols = -Date, names_to = "rating", values_to = "value")%>%
                              pull(rating)
                ),
     mainPanel(type = "tabs",
               tabPanel("Spreads Across", plotOutput("line")),
               tabPanel("IG Spreads by Industry", plotOutput("boxplot"))

     
     )
    )
  )
)

==========
  server
=========
  single_rating <- reactive({
    
  })

=================
  
  