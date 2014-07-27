library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel('Data Converter (wide to long format)'),
    sidebarPanel(
      fileInput('fileInput','Step 1: Upload CSV File (in wide format)',accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
      numericInput('totalColumns','Step 2: Specify Total Id Variables',1)
    ),
    mainPanel(
      
      tabsetPanel(
      
        tabPanel('Welcome',
                 h3('Convert Wide Format Data to Long (narrow) Format'),
                 p('Often published data series are available in wide format.'),
                 a(href='http://en.wikipedia.org/wiki/Wide_and_narrow_data','Click here to see difference between wide and long format',target='_blank'),
                 p('This is a simple webservice for converting data in wide format to long format.
                    R has a very elegant library named reshape that can handle such conversions. This webservice uses 
                    melt function for converting wide data format to long format.
                  '),
                 p('Following steps must be performed to convert a data file in wide format to long format'),
                 tags$ol(  
                   tags$li('Upload a csv data file (variables must be separated by comma and enclosed by double quotes)'),
                   tags$li('Input the number of id variables that must be preserved. For example a value of 3 means first three columns will be repeated for remaining variables.'),
                   tags$li('Click the "Data" tab to view the original data in wide format and the converted data in long format. At the bottom a download button is available for downloading the data in long format')
                 )
                 
        ),
        
        tabPanel('Data',
                 h4('Uploaded Wide Format Data (showing first five records)'),
                 tableOutput('originalFileContents'),               
                 h4('Melted Long Format Data (showing first five records)'),
                 tableOutput('meltedFileContents'),
                 downloadButton('downloadFile','Download Long Format CSV File')
                 )
        
        
        
      )
  
  
      
      
    )
  )
)