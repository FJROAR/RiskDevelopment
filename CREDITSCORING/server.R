library(shiny)

function(input, output) {
  
  
  #Se guarda una copia de los datos en DATA
  
  #Datos <- 
  
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    library(DataExplorer)
    
    #Se guarda una copia de los datos en DATOS
    RUTA = "DATA/"
    DATOS <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                          quote=input$quote)
    
    GenerateReport(DATOS, output_dir = "C:/FJRA/2017/PET_PROJECTS/RISK_ANALYSIS/www/",output_file = "Datos.html")
    
    write.csv(DATOS, paste0(RUTA, "DatosTotal.csv" ), row.names = FALSE)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)[c(1:5),]
    
    
    
  })
  
  
    
  output$contents1 <- renderTable({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    
    RUTA = "DATA/"
    DATOS <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                      quote=input$quote)
    
    #Los datos deben tener siempre una variable binaria denominada target
    TAB0 <- DATOS[DATOS$target == 0,]
    indice0 <- sample(c(1:nrow(TAB0)), input$tra1 * nrow(TAB0), replace = FALSE)

    TAB1 <- DATOS[DATOS$target == 1,]
    indice1 <- sample(c(1:nrow(TAB1)), input$tra1 * nrow(TAB1), replace = FALSE)
    
    DATOS  <- rbind(TAB0[indice0,], TAB1[indice1,])
    write.csv(DATOS, paste0(RUTA, "DatosTraining.csv" ), row.names = FALSE)
    DATOS  <- rbind(TAB0[-indice0,], TAB1[-indice1,])
    write.csv(DATOS, paste0(RUTA, "DatosTest.csv" ), row.names = FALSE)
    
    })
    
  
  Text1 <- eventReactive(input$SubmitButton,{
    
    RUTA <- "DATA/"

    s1 <- sum(read.csv(paste0(RUTA, "DatosTraining.csv"), header=input$header , sep=input$sep,
                 quote=input$quote) [,c("target")])
  
    s0 <- nrow(read.csv(paste0(RUTA, "DatosTraining.csv"), header=input$header , sep=input$sep,
                       quote=input$quote))
        
    rate = round(s1 / (s1 + s0), 6)
    
    paste0("Training.    Number of 1s: ", s1, " Number of 0s: ", s0, " Rate: ", rate)
    
  })
  
  output$text1 <- renderText({
    Text1()
  })
  
  
  Text2 <- eventReactive(input$SubmitButton,{
    
    RUTA <- "DATA/"
    
    s1 <- sum(read.csv(paste0(RUTA, "DatosTest.csv"), header=input$header , sep=input$sep,
                       quote=input$quote) [,c("target")])
    
    s0 <- nrow(read.csv(paste0(RUTA, "DatosTest.csv"), header=input$header , sep=input$sep,
                        quote=input$quote))
    
    rate = round(s1 / (s1 + s0), 6)
    
    paste0("Validation. Number of 1s: ", s1, " Number of 0s: ", s0, " Rate: ", rate)
    
  })
  
  output$text2 <- renderText({
    Text2()
    
  })
  
  
  Text3 <- eventReactive(input$SubmitButton2,{
    
    RUTA <- "DATA/"
    
    balanceado <- read.csv(paste0(RUTA, "DatosTraining.csv"), header=input$header , sep=input$sep,
                       quote=input$quote)

    s1 <- sum(balanceado$target)
    s0 <- nrow(balanceado)
    
    rate = round(s1 / (s1 + s0), 6)
    
    
    if(rate > input$bal1)
    {
      paste0("No se balancea ya que el porcentaje de 1s es: ", s1/s0)
      
    }
    
    if(rate <= input$bal1)
    {
      paste0("Se balancea el training: ")
      
    }
    
  })
    
  output$text3 <- renderText({
      Text3()
      
    })
    
  
}
