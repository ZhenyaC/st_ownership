#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  

    output$linePlot <- renderPlot({

        #line plot for each of the spreads -did not work for columns
        # across%>%select(input$choice)%>%ggplot(aes(x=Date, y= input$choice)) + geom_line()
        across%>%pivot_longer(cols = -Date, names_to = "rating", values_to = "value")%>% 
        filter(rating %in% input$rating)%>%
        ggplot(aes(x=Date, y= value, color=rating)) + geom_line()

    })
    
     ## Table
    
    output$table <- renderTable({
      
        across %>% filter(Date>=01-12-2021)
        #across[ , input$choice]
    })    
})
