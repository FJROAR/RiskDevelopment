shinyUI(fluidPage(
  img(src = "TD.jpg"),
  img(src = "Big.jpg"),
  titlePanel ("Altman Model"),
  sidebarLayout(
    sidebarPanel(
      h1("Manual Altman Emulator"),
      br(),
      p("In this version, users introduce data for a firm."),
      p("When any element is modified, Z-Score and Risk Zone are automatically updated."),
      p("Remind: Market Value = Number of Shares X Value of a share")),

    

      mainPanel(
      h2("Instructions to calculate the Z-Score of a firm"),
      br(),
      p("Users has to do the followings selections:"),
      br(),
      p(" - From the list below, a type of enterprise has to be selected."),
      p(" - A value by variable has to be inputted."),
      p(" - In case of not cotized enterprise Book Value of a Firm is used against Market Value."),
      p(" - The Altman Z-Score calculation is valid when the seven variables are inputed."),
      p(" - For the Commercial and Services firm model, Sales variable is not used.")
  )),

fluidRow(
    
    column(3,
           radioButtons("radio", label = h3("Type of Enterprise"),
                        choices = list("Cotized" = 1, "Non cotized" = 2,
                                       "Non cotized: commercial and services" = 3),selected = 1))),
  
fluidRow(
  
  column(3, 
         numericInput("num1", 
                      label = h4("Total Assets:"), 
                      value = 0)),
  column(3, 
         numericInput("num2", 
                      label = h4("Working Capital:"),
                      value = 0)),
  column(3, 
         numericInput("num3", 
                      label = h4("Retained Earnings:"),
                      value = 0)),
  column(3, 
         numericInput("num4", 
                      label = h4("Earnings Before Taxes:"),
                      value = 0)),
  column(3, 
         numericInput("num5", 
                      label = h4("Market Value:"),
                      value = 0)),
  column(3, 
         numericInput("num6", 
                      label = h4("Total Liabilities:"),
                      value = 0)),
  
    column(3, 
         numericInput("num7", 
                      label = h4("Sales:"),
                      value = 0))
),

fluidRow(
  
  column(4, h2(textOutput("text1"))),
  column(8, h2(textOutput("text2"))))

))

