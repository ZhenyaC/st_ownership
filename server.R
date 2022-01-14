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
  
  #Jan 6 - making reactive and adding filter between date
  across_filtered<-reactive({
    across_pivoted%>% 
      filter(rating %in% input$rating)
   
  })
  
  output$linePlot <- renderPlot({
    
    #line plot for each of the spreads -did not work for columns
    # across%>%select(input$choice)%>%ggplot(aes(x=Date, y= input$choice)) + geom_line()
    
    across_filtered()%>%
      #Jan8: filtering between input years do not work
      filter(between(year(Date), input$years[1], input$years[2]))%>%
     # mutate(Date=format(Date, "%d-%m-%Y"))%>%
      ggplot(aes(x=Date, y= value, color=rating)) + geom_line()
    
  })
  
  
  output$barPlot <- renderPlot({
    ig_industry%>%
      filter(Date %in% as.Date(c("2021-10-21", "2020-03-23", "2019-12-04")))%>%mutate(Date=format(Date, "%d-%m-%Y")) %>%
      pivot_longer(cols = -Date, names_to = "industry", values_to = "value")%>%
      mutate(value=as.numeric(value))%>%
      ggplot(aes(x= industry, y= value, fill=Date)) + geom_bar(stat="identity", position = "dodge") + ylab("bps") + coord_flip()
  })
    
     ## Table
    
    output$table <- renderTable({
      
      #across%>%filter(Date >="2021-01-10")%>%mutate(Date=format(Date, "%d-%m-%Y"))%>%view()
      
        across %>% filter(Date >= "2021-11-10")%>%mutate(Date=format(Date, "%d-%m-%Y"))
      # across %>% subset(Date >= as.Date("01-01-2021"))
       # across$Date<-as.character(across$Date)
        #across[ , input$choice]
    })    
})
