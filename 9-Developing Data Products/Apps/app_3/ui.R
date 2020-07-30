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
    titlePanel("Slider App"),

    
    sidebarLayout(
        sidebarPanel(
            
            #titulo para el slider
            h1("Move the Slider!"),
           
             # creo el slider
            sliderInput(inputId = "slider2", 
                        label = "Slide Me!", 
                        min = 0, 
                        max = 100, 
                        value = 0)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3("Slider Value:"),
            textOutput("text1")
        )
    )
))
