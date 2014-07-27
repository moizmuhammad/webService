library(shiny)
library(reshape)

options(shiny.maxRequestSize=30*1024^2)

shinyServer(
  function(input,output) {
    output$originalFileContents <- renderTable({
      
      #select input file
      inputFile <- input$fileInput
      
      #check if file is empty (i.e. not uploaded). If yes then return NULL
      if (is.null(inputFile)) { 
        return(NULL)}

      
      #read the file as csv with first row as header
      df <- read.csv(inputFile$datapath,header=TRUE,sep=',',quote='"')
      head(df,5)
              
    })
    
    output$meltedFileContents <- renderTable({
    
      
      #select input file
      inputFile <- input$fileInput
      
      #check if file is empty (i.e. not uploaded). If yes then return NULL
      if (is.null(inputFile)) { 
        return(NULL)}
      
      
      #read the file as csv with first row as header
      df <- read.csv(inputFile$datapath,header=TRUE,sep=',',quote='"')
            
      #melt the data frame
      dfm <- melt(df, id=names(df[1:input$totalColumns]))
      head(dfm,5)
      
      
    })
    
    output$downloadFile <- downloadHandler(
      filename = function() { paste('meltedData', '.csv', sep='') },
      content = function(file) {

        inputFile <- input$fileInput

        if(is.null(inputFile))
          return(NULL)
        #read the file as csv with first row as header
        df <- read.csv(inputFile$datapath,header=TRUE,sep=',',quote='"')
        
        #melt the data frame
        dfm <- melt(df, id=names(df[1:input$totalColumns]))
        
        write.csv(dfm, file)
      }
    ) 
    
  }  
)