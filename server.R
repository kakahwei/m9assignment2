determineRank <- function(mark)
{
  if (mark > 89)
  {
    "Distinction"
  }
  else if (mark > 69)
  {
    "Passed"
  }else
  {
    "Failed"
  }
  
}

library(shiny) 

shinyServer(function(input, output) {

  makeData <- observe(
    {
      #Enable this and set to your local dicectory
      #setwd('E:/myGitFolder/m9_Coursera/m9assignment2')
      if (!file.exists("Coursera_Record.csv"))
      {
        write.table(
          t(c(
            'Student Name',
            'Module',
            'Date Complete',
            'Score',
            'Rank'
          )),file = "Coursera_Record.csv" ,sep = ",",col.names = F,row.names = F
        )
        output$message <- renderText('New csv file is created. Kindly refresh this page and start key in the data')
        
      }else
      {
        if(nchar(input$studentName) >0 && !is.na(input$module) &&
           !is.na(input$dateComplete) && !is.na(input$score))
        {
          output$message <- renderText('Record added.')
          
          output$singleRec <- renderTable({
            singleRec = data.frame(
              'Student Name' = input$studentName,
              Module = input$module,
              'Date Completed' = as.character(input$dateComplete, format='%Y-%m'),
              Score = input$score,
              Rank = determineRank(input$score)
            )
          },include.rownames = FALSE)
          
          write.table(
            t(
              c(
                input$studentName,
                input$module,
                as.character(input$dateComplete, format='%Y-%m'),
                input$score,
                determineRank(input$score)
              )
            ),file = "Coursera_Record.csv",sep = ",",col.names = F,row.names = F,append = T
          )
        }  
        else
        {
          output$message <- renderText('Please fill up all info')
        }
      }
      
      df <- read.csv("Coursera_Record.csv",sep = "," )
      #output$Data <- renderTable({df})
      output$historyTable = renderDataTable({df}, options = list(orderClasses = TRUE , lengthMenu = c(10, 20, 30), pageLength = 10))
    })
  
  
  
})