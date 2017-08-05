library(shiny)
library(woe)

function(input, output, session) {
  
  
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
    
    if (input$Dec1 == 0)
    {
      
      Texto = HTML(paste("No se balancea el Training", sep="<br/>"))
  
    }
    
    if (input$Dec1 == 1)
    {
      RUTA <- "DATA/"
    
      balanceado <- read.csv(paste0(RUTA, "DatosTraining.csv"), header=input$header , sep=input$sep,
                         quote=input$quote)

      #balanceado <- read.csv(paste0(RUTA, "DatosTraining.csv"), sep=",")
      
            
      s1 <- sum(balanceado$target)
      st <- nrow(balanceado)
    
      rate = round(s1 / (st + s1), 6)
    
    
      if(rate > input$bal1)
      {
        Texto = HTML(paste(paste0("No se balancea ya que el porcentaje de 1s es: ", round(s1/st,6), " mayor que ", 
                                  input$bal1), sep="<br/>"))
      
      }
    
      if(rate <= input$bal1)
      {
        balanceado0 <- balanceado[which(balanceado$target == 0),]
        balanceado1 <- balanceado[which(balanceado$target == 1),]

        set.seed(1)
        
        indice0 <- sample(c(1:st), size = round(((1-input$bal1) * s1)/input$bal1,0))
        
        balanceado0 <- balanceado0[indice0,]
        balanceado <- rbind(balanceado0, balanceado1)
      
        write.csv(balanceado, paste0(RUTA, "training_balanceado.csv"), row.names = FALSE)
        
        t1 <- paste0("Se ha balanceado el training a la tasa ", input$bal1)
        t2 <- paste0("-Num. de 0s en training_balanceado = ", nrow(balanceado0))
        t3 <- paste0("-Num. de 1s en training_balanceado = ", nrow(balanceado1))
        Texto = HTML(paste(t1, t2, t3, sep="<br/>"))
        
      }
      
      
    }
    
    Texto
    

  })
    
  output$text3 <- renderText({
      Text3()
      
    })
  
  Dataset <- eventReactive(input$SubmitButton3,{
    #infile <- input$datafile
    #if (is.null(infile)) {
    #  return(NULL)
    #}
    
    RUTA = "DATA/"
    read.csv(paste0(RUTA, input$Conj1), header=input$header , sep=input$sep,
                                      quote=input$quote)
  })
  
  
  output$varselect <- renderUI({
    
    
  })
  
  observe({
    
    if (identical(Dataset(), '') || identical(Dataset(), data.frame()))
      return(NULL)
    
    updateSelectInput(session, inputId = "x1", "Lista de variables:",
                      choices=names(Dataset()))
  })


  IvTable <- eventReactive(input$SubmitButton4,{
    
    
    RUTA = "DATA/"
    Datos <- read.csv(paste0(RUTA, input$Conj1), header=input$header , sep=input$sep,
             quote=input$quote)
    
    Variable <- Datos[,input$x1]

    Datos2 <- iv.replace.woe(Datos, iv=iv.mult(Datos,"target"))
    lista_variables <- colnames(Datos2)
    n = length(lista_variables)
    indice = vector("numeric", length = n)
  

    
    for (i in 1:n){
      
      indice[i] = 0
      if (substr(lista_variables[i], nchar(lista_variables[i]) - 2, nchar(lista_variables[i])) == "woe"){
        
        indice[i] = i
        
      }
      
    }
    
    Datos2 <- Datos2[,indice]
    write.csv(Datos2, paste0(RUTA,"WOE.csv"), row.names = FALSE)
    

    if (is.numeric(Variable))
    {
      iv.num(Datos, input$x1, "target")
    }
    
    else if (is.character(Variable))
    {
      iv.str(Datos, input$x1, "target")
    }
    
    else if (is.factor(Variable))
    {
      iv.str(Datos, input$x1, "target")
    }
    
  })
  

  output$Iv <- renderRHandsontable({
    rhandsontable(IvTable(), readOnly = TRUE, selectCallback = TRUE, rowHeaders = FALSE) %>%
      hot_cols(renderer = "function (instance, td, row, col, prop, value, cellProperties) {
               Handsontable.renderers.TextRenderer.apply(this, arguments);
               
               td.style.background = 'orange';
  }")
    
  })

  output$varselect1 <- renderUI({
  
  })
  
  observe({
      
      if (identical(Dataset(), '') || identical(Dataset(), data.frame()))
        return(NULL)
      
      updateSelectInput(session, inputId = "x2", "Lista de variables:",
                        choices=names(Dataset()))
  })
    
    
  
  
  
  
}
