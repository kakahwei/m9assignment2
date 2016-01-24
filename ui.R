library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
  headerPanel("Data Science Student Performance"),
  
  sidebarPanel(
    h3("Form"),
    textInput("studentName","Student Name:",value =""),
    numericInput("score","Score :",value ="70" ,min = 0, max =  100 ,step = 10),
    selectInput("module", "Module  : ",
                c(1,2,3,4,5,6,7,8,9,10), selected = 1),
    dateInput("dateComplete", "Date complete(YY-MM):", format = "yyyy-mm",value =Sys.Date(),language = "En"),
    submitButton("Add Record")
  ),
  
  mainPanel(
    
    h3("Newly Add Record"),
    tableOutput("singleRec"),
    textOutput('message'),
    
    h3("History"),
    #tableOutput("Data"),
    dataTableOutput("historyTable")
    
  )
))