library(shiny)
library(dplyr)
library(ggplot2)
library(googleVis)

shinyServer(function(input, output){
  output$hist1 <- renderPlot(
    coviddata %>% filter(., state == input$state1 | state == input$state2, date == input$date1) %>% group_by(., state) %>% summarise(., sum1 = sum(cases)) 
    %>% ggplot(., aes(x = state, y = sum1)) + geom_bar(aes(fill = state), stat = 'identity') + ggtitle("Total number of Cases") + xlab(input$date1) + ylab("Total Number of cases"), width = "auto", height = "auto")

  output$hist2 <- renderPlot(
    coviddata %>% filter(., state == input$state1 | state == input$state2, date == input$date1) %>% group_by(., state) %>% summarise(., sum2 = sum(deaths)) 
    %>% ggplot(., aes(x = state, y = sum2)) + geom_bar(aes(fill = state), stat = 'identity') + ggtitle("Total number of Deaths") + xlab(input$date1) + ylab("Total Number of deaths"), width = "auto", height = "auto")
  
  output$scatter1 <- renderPlot(
    coviddata %>% filter(., state == input$state1 | state == input$state2) %>% group_by(., state, date) %>% summarize(., sum1 = sum(cases))
    %>% ggplot(., aes(x = date, y = sum1)) + geom_point(aes(color = state)) + ggtitle("Growth in Cases over time") + xlab('Date') + ylab("Total Number of cases"), width = "auto", height = "auto")

  output$scatter2 <- renderPlot(
    coviddata %>% filter(., state == input$state1 | state == input$state2) %>% group_by(., state, date) %>% summarize(., sum2 = sum(deaths))
    %>% ggplot(., aes(x = date, y = sum2)) + geom_point(aes(color = state)) + ggtitle("Growth in Deaths over time") + xlab('Date') + ylab("Total Number of deaths"), width = "auto", height = "auto")
  
  output$lollipop1 <- renderPlot(
    coviddata2 %>% ggplot(., aes(x = state, y = sum1)) + geom_segment(aes(x= state, xend= state, y=0, yend=sum1), color="grey") + geom_point(size=3, color="#69b3a2") + 
      coord_flip() +
      theme(
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        legend.position="none"
      ) +
      xlab("States")
      + ylab("Cases")
      + ggtitle("Cases by state"))
  
  output$lollipop2 <- renderPlot(
    coviddata3 %>% ggplot(., aes(x = state, y = sum1)) + geom_segment(aes(x= state, xend= state, y=0, yend=sum1), color="grey") + geom_point(size=3, color="#69b3a2") + 
      coord_flip() +
      theme(
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        legend.position="none"
      ) +
      xlab("States")
    + ylab("Deaths")
    + ggtitle("Deaths by state"))
  
  output$table1 <- DT::renderDataTable({
    datatable(coviddata, rownames=FALSE)
  })
  
  output$map1 <- renderGvis({
    gvisGeoChart(coviddata2, "state", "sum1",
                 options=list(region="US", displayMode="regions",
                              resolution="provinces",
                              width="auto", height="auto", title = "Cases by State"))
  })
  
  output$map2 <- renderGvis({
    gvisGeoChart(coviddata3, "state", "sum1",
                 options=list(region="US", displayMode="regions",
                              resolution="provinces",
                              width="auto", height="auto"))
  })
  
})