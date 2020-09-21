library(DT)
library(shinydashboard)

shinyUI(dashboardPage(
    dashboardHeader(title = "COVID Data"),
    
    dashboardSidebar(
        sidebarUserPanel("Data from The New York Times"),
        sidebarMenu(
            menuItem("Histograms", tabName = "charts", icon = icon("chart-bar")),
            menuItem("Scatterplots", tabName = "scatterplots", icon = icon("chart-area")),
            menuItem("Lollipop Plot", tabName = "lollipop", icon = icon("chart-bar")),
            menuItem("Data", tabName = "data", icon = icon("database")),
            menuItem("Map", tabName = "map", icon = icon("map")),
            menuItem("About the Author", tabName = "author", icon = icon ("question"))),
        selectizeInput("state1",
                       label = h4("Select State #1 to Display"), choices = unique(choicestates), selected = "New York"),
        selectizeInput("state2",
                       label = h4("Select State #2 to Display"), choices = unique(choicestates), selected = "California"),
        selectizeInput("date1",
                       label = h4("Select Date to Display"), choices = unique(coviddata$date), selected = "2020-05-30")),
    dashboardBody(
        tabItems(
            tabItem(tabName = "charts",
                    box(plotOutput("hist1")),
                    box(plotOutput("hist2"))),
            tabItem(tabName = "scatterplots",
                    box(plotOutput("scatter1")),
                    box(plotOutput("scatter2"))),
            tabItem(tabName = "lollipop", 
                    box(plotOutput("lollipop1")),
                    box(plotOutput("lollipop2"))),
            tabItem(tabName = "data",
                    box(DT::dataTableOutput("table1"))),
            tabItem(tabName = "map",
                    box(htmlOutput("map1")),
                    box(htmlOutput("map2"))),
            tabItem(tabName = "author",
                    h3("For any feedback or suggestions on 
                    how to improve this app, please contact phil062497@gmail.com. Thanks!"))))
))