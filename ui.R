#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("MtCars Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("cyl", "Number of cylinders:", min =4, max=8, step=2, value=c(4,8)),
       sliderInput("hp", "HP:", min =50, max=350, value=c(50,350)),
       checkboxInput("ShowLM",value = TRUE, label = "Show smooth"),
       h3("Your car"),
       selectInput("mycyl", "Number of cylinders:", choices=c(4,6,8)),
       selectInput("myam", "Gear:", choices=c("Automatic","Manual")),
       sliderInput("myhp", "HP:", min =50, max=350, value=50),
       sliderInput("mywt", "Weight (1000 lbs):", min =1, max=4, value=1, step = 0.1)
       # ,
       # actionButton("mypredict", "Predict it!")

    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot",  brush = "cars_brush"),
       # h2("Predicted value:"),
       # tableOutput("predictedValue"),
       h2("Selected items:"),
       verbatimTextOutput("info")
    )
    
  )
))
