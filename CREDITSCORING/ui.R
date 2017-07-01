library(shiny)

fluidPage(
  img(src = "TD.jpg"),   img(src = "Big.jpg"),
  titlePanel("Credit Scorecard Building Framework"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"')
    ),
    mainPanel(
      tableOutput('contents')
    )
  ),

  fluidRow(
    
  column(3,wellPanel(numericInput("tra1", "Peso Training: ", value = 0.7),
                     actionButton("SubmitButton", "Submit"))
    )),
  
  column(6,
         tableOutput("contents1")
  ),
  
  
  br(),

  h2(p("Training - Validation Analysis")),
    
  fluidPage(sidebarPanel(

  h5(textOutput('text1')),
  h5(textOutput('text2'))
  
    
  )),

fluidRow(
  
  br(),
  
  h2(p("Balanceo del Training")),
  
  column(3,wellPanel(textInput("Dec1", "Indique si desea balancear el training: ", value = "No"),
                     numericInput("bal1", "Introduzca un porcentaje de balanceo: ", value = 0.015),
                     actionButton("SubmitButton2", "Submit"))
  )),

  fluidPage(sidebarPanel(
  
    h5(textOutput('text3'))
  
  ))
  
)


