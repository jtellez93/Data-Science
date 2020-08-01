install.packages("shiny")
library(shiny)

# ui.R
# (user interfaz) da la interfaz de usuario, y determinará cómo se ve la aplicación 

# server.R 
# controlará lo que hace la aplicación.

# Crear shiny
# file - new file - shiny web app

?builder # muestra funciones basicas para construir codigo HTML


# sidebarPanel ------------------------------------------------------------
# panel lateral
# numericInput = entrada numerica
# function (inputId, label, value, min = NA, max = NA, step = NA, width = NULL) 
# step es el aumento entre pasos

# sliderInput = entrada a partir de un slider
# function (inputId, label, min, max, value, step)
# step es el aumento entre pasos

# checkboxInput = campo de seleccion, True es seleccionado, False es no seleccionado
# function (inputId, label, value = FALSE, width = NULL)  

# submitButton = boton para enviar datos del input al server 
#para ser procesados
# submitButton(text = "Apply Changes", icon = NULL, width = NULL)


# mainPanel ---------------------------------------------------------------
# panel principal

# plotOutput = salida grafica, si quiero que sea un grafico dinamico
# uso el argumento brush = brushOpts(id = "brush1")
# esto genera un input deacuerdo a la seccion elegida en el grafico.

# textOutput = salida de texto

# tabsetPanel = si quiero una interfas con paneles, pestañas.
# tabsetPanel(type = ..., tabPanel(title, ..., value = title))



# Reactivity --------------------------------------------------------------
# cuando necesito que se realice una operacion cada que el valor 
# de entrada se actualiza, debo crear los objetos de tipo reactivo
# reactive({ variable_nombre <- input }
#          expresion )
# para usar el objeto reactivo en el output
# la notacion es variable_nombre()




# Delayed Reactivity ------------------------------------------------------
# Reactividad retardada
# la forma en que funciona con reactividad, tan pronto como cambie
# los valores de su control deslizante, vuelve a ejecutar 
# automáticamente el código en las funciones del servidor.

# Cuando no quiero que lo haga automaticamente, sino cuando de click
# en un boton o algo por el estilo, eso es Reactividad retardada




