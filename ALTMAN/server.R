shinyServer(function(input, output){

  output$text1 <- renderText({
    
    X1 = input$num2/input$num1
    X2 = input$num3/input$num1
    X3 = input$num4/input$num1
    X4 = input$num5/input$num6
    X5 = input$num7/input$num1
    
    if(is.nan(X1) == 1 || is.infinite(X1) == 1 || is.na(X1) == 1) {X1 = 0}
    if(is.nan(X2) == 1 || is.infinite(X2) == 1 || is.na(X2) == 1) {X2 = 0}
    if(is.nan(X3) == 1 || is.infinite(X3) == 1 || is.na(X3) == 1) {X3 = 0}
    if(is.nan(X4) == 1 || is.infinite(X4) == 1 || is.na(X4) == 1) {X4 = 0}
    if(is.nan(X5) == 1 || is.infinite(X5) == 1 || is.na(X5) == 1) {X5 = 0}
    
    if(input$radio == 1)
    {Altman = 1.2*X1 + 1.4*X2 + 3.3*X3 + 0.6*X4+0.999*X5}
    if(input$radio == 2)
    {Altman = 0.717*X1 + 0.847*X2 + 3.107*X3 +0.420*X4+0.998*X5}
    if(input$radio == 3)
    {Altman = 6.56*X1 + 3.26*X2 + 1.05*X3 + 1.05*X4}
    
    paste("Z-Score value = ", Altman)
  })
  output$text2 <- renderText({
    
    X1 = input$num2/input$num1
    X2 = input$num3/input$num1
    X3 = input$num4/input$num1
    X4 = input$num5/input$num6
    X5 = input$num7/input$num1
    
    if(is.nan(X1) == 1 || is.infinite(X1) == 1 || is.na(X1) == 1) {X1 = 0}
    if(is.nan(X2) == 1 || is.infinite(X2) == 1 || is.na(X2) == 1) {X2 = 0}
    if(is.nan(X3) == 1 || is.infinite(X3) == 1 || is.na(X3) == 1) {X3 = 0}
    if(is.nan(X4) == 1 || is.infinite(X4) == 1 || is.na(X4) == 1) {X4 = 0}
    if(is.nan(X5) == 1 || is.infinite(X5) == 1 || is.na(X5) == 1) {X5 = 0}
    
    if(input$radio == 1)
    {Altman = 1.2*X1 + 1.4*X2 + 3.3*X3 + 0.6*X4+0.999*X5}
    if(input$radio == 2)
    {Altman = 0.717*X1 + 0.847*X2 + 3.107*X3 +0.420*X4+0.998*X5}
    if(input$radio == 3)
    {Altman = 6.56*X1 + 3.26*X2 + 1.05*X3 + 1.05*X4}
    
    if(input$radio == 1 && Altman > 2.99 )
    {Zone = "Secured"}
    if(input$radio == 1 && Altman <= 2.99 && Altman > 1.81 )
    {Zone = "Dubious"}
    if(input$radio == 1 && Altman <= 1.81 )
    {Zone = "Bankruptcy"}
    
    if(input$radio == 2 && Altman > 2.90 )
    {Zone = "Secured"}
    if(input$radio == 2 && Altman <= 2.90 && Altman > 1.23 )
    {Zone = "Dubious"}
    if(input$radio == 2 && Altman <= 1.23 )
    {Zone = "Bankruptcy"}

    if(input$radio == 3 && Altman > 2.60 )
    {Zone = "Secured"}
    if(input$radio == 3 && Altman <= 2.60 && Altman > 1.10 )
    {Zone = "Dubious"}
    if(input$radio == 3 && Altman <= 1.10 )
    {Zone = "Bankruptcy"}
    
    paste("According to the model, the firm is in a ", Zone, " zone")
  })
})