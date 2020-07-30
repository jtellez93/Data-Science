install.packages("shiny")
library(shiny)

# ui.R
# (user interfaz) da la interfaz de usuario, y determinará cómo se ve la aplicación 

# server.R 
# controlará lo que hace la aplicación.

# Crear shiny
# file - new file - shiny web app

?builder # muestra funciones basicas para construir codigo HTML

 ### sidebarPanel ####

# numericInput = entrada numerica
# function (inputId, label, value, min = NA, max = NA, step = NA, width = NULL) 
# step es el aumento entre pasos

# sliderInput = entrada a partir de un slider
# function (inputId, label, min, max, value, step)
# step es el aumento entre pasos

# checkboxInput = boton de seleccion, True es seleccionado, False es no seleccionado
# function (inputId, label, value = FALSE, width = NULL)  


### mainPanel ####

# plotOutput = salida grafica
# textOutput = salida de texto