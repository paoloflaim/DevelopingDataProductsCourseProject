library(datasets)
library(ggplot2)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  showPredictValue <- FALSE
  # observeEvent(input$mypredict, {
  #       p <- predictModel()
  #       output$predictedValue <- renderTable(p)
  # })
  
  predictModel <- reactive({
          fit <- lm(mpg ~ cyl + wt + factor(am) + hp, mtcars)
          myam <- switch (input$myam,
                          Automatic = 0,
                          Manual = 1
          )
          nd <- data.frame(cyl = as.numeric(input$mycyl), wt = as.numeric(input$mywt), am = myam, hp = as.numeric(input$myhp))
          p <- predict(fit, newdata = nd)
  })
  
  output$distPlot <- renderPlot({
    db <- datasetInput()
    g <- ggplot(data=db, aes(x=wt, y=mpg)) +
                geom_point(aes(color=factor(cyl), size = mpg)) 
        pm <- predictModel()
        predictedValue <- data.frame(wt=input$mywt, mpg=as.numeric(pm[1]))
        if(!is.null(predictedValue)){
                g <- g + geom_point(data=predictedValue, aes(x=wt, y=mpg, size=30),shape=18, colour="black")
        }
        if(input$ShowLM){
                g <- g + geom_smooth(method = 'loess', formula = "y ~ x")
        }
        g + labs(x = "Weight", y="Miles per gallon", title="mtcars dataset")
    g
  })
  
  
  datasetInput <- reactive({
          cylmin <- input$cyl[1]
          cylmax <- input$cyl[2]
          hpmin  <- input$hp[1]
          hpmax  <- input$hp[2]
          mtcars[mtcars$cyl >= cylmin & mtcars$cyl <= cylmax & mtcars$hp >= hpmin & mtcars$hp <= hpmax, ]
  })
  

  output$info <- renderPrint({
          brushedPoints(mtcars, input$cars_brush, allRows = FALSE)
  })
  
})
