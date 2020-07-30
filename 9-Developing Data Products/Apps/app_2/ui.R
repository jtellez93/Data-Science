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
    titlePanel("Mi primer app shiny"),

    sidebarLayout(
        sidebarPanel(
           h1("H1 Text"),
           h2("H2 Text"),
           h3("H3 text"),
           em("Emphasized Text")
        ),

        mainPanel(
            h3("My Panel Text"),
            h4("Texto en H4"),
            code("some Code!")
        )
    )
))
