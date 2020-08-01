library(shiny)
library(miniUI)


myFirstGadget <- function(){
        
        ui <- miniPage(
                gadgetTitleBar("My First Gadget")
        )
        
        server <- function(input, output, session){
                # The done button closes the aqpp
                observeEvent(input$done, {
                        stopApp()
                })
        }
        runGadget(ui, server)
}
