
### Reading mySQL ####

# los datos estan estructurados en bases de datos
# en bases de datos con tablas
# en tablas con campos

# cada campo es una columna (variable)
# cada fila es llamada record (observacion)

install.packages("RMySQL")
install.packages("DBI")
library(DBI)
library(RMySQL)


ucscDb <- dbConnect(MySQL(), user = "genome",
                    host = "genome-mysql.cse.ucsc.edu")

result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)

# es imortante desconectarse del servidor antes 
# de empezar a analizar la informacion


result # en este objeto queda guardada una lista con todas las bases de datos 
# disponibles en el MySQL server, ubicadas en la direccion host indicadas


# hg19 es una construccion particular del genoma humano
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19",
                    host = "genome-mysql.cse.ucsc.edu")

alltables <- dbListTables(hg19) # observamos todas las tablas que hay en hg19
length(alltables)

alltables[1:5]

dbListFields(hg19, "affyU133Plus2") # si suponemos que conocemos que tabla nos interesa
# podemos ver los campos de esa tabla con esta funcion
# tabla corresponde a dataframe y campo corresponde a columna

dbGetQuery(hg19, "select count(*) from affyU133Plus2")
# si deseo saber el numero de filas de este dataframe utilizo este comando


## Read from the table 
# con la funcion deReadTable() podemos leer una tabla de la conexion con MySQL server
# estamos leyendo el df affyU133Plus2 de la base de datos hg19
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)


## Select a specific subset
# aqui sleccionamos de la base de datos hg19, de la tabla affyU133Plus2
# un subconjunto en el que se cumplen que los valores de misMatches estan entre 1 y 3

# primero se crea la consulta
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")

# luego buscamos la consulta creada
affyMis <- fetch(query); quantile(affyMis$misMatches)


# tambien podemos buscar la consulta con un tamaño n deseado, 
# n hace referencia al numero de columnas
affyMisSmall <- fetch(query, n = 10); dbClearResult(query)
dim(affyMisSmall)

# con dbclearResult() liberamos el objeto query para evitar agotar
# los recursos (memoria, descriptores de archivos, etc.)

dbDisconnect(hg19)



### Reading HDF5 ####
# Hierarchical Data Format
# Formato de datos jerárquico

# este formato es usado para guardar datasets grandes
# Conjuntos de datos, que son matrices multidimensionales de tipo homogéneo
# Grupos, que son estructuras de contenedor que pueden contener datasets y otros grupos


### Reading from the Web ####

## Webscraping o raspado web
# el web scraping se enfoca en la transformación de datos sin estructura
# en la web (como el formato HTML) en datos estructurados
# que pueden ser almacenados y analizados en una base de datos central,
# en una hoja de cálculo o en alguna otra fuente de almacenamiento.

# Alguno de los usos del web scraping son
# la comparación de precios en tiendas, 
# la monitorización de datos relacionados con el clima de cierta región,
# la detección de cambios en sitios webs
# y la integración de datos en sitios webs.
# También es utilizado para obtener información relevante
# de un sitio a través de los rich snippets.


## Getting data off webpages - readLines()
# la funcion readLines() permiter leer codigo HTML de internet

con <- url("https://scholar.google.com/citations?hl=es&user=HI-I6C0AAAAJ")
htmlCode <- readLines(con, warn = F) # lemos el codigo HTML
# el argumento warn omite el warning cuando detecta
# que no encuentra linea final en la url que indicamos

close(con) # permite cerrar la conexion,
# debo hacerlo antes de empezar a trabajar con los datos

htmlCode # muestra el codigo HTML



### Parsing with XML ###
library(RCurl)
library(XML)

url <- "https://scholar.google.com/citations?hl=es&user=HI-I6C0AAAAJ"

xData <- getURL(url)
html <- htmlTreeParse(xData, useInternalNodes = T)

xpathSApply(html, "//title", xmlValue)

xpathSApply(html, "//td[@class='gsc_a_c']", xmlValue)
xpathSApply(html, "//td[@class='gsc_a_y']", xmlValue)


### Get from the httr package ####

library(httr)

html2 <- GET(url)
content2 <- content(html2, as = "text")
parsedHtml <- htmlParse(content2, asText = TRUE)

xpathSApply(parsedHtml, "//title", xmlValue)

xpathSApply(parsedHtml, "//td[@class='gsc_a_c']", xmlValue)
xpathSApply(parsedHtml, "//td[@class='gsc_a_y']", xmlValue)



### Accesing websites with passwords #### 

pg1 <- GET("http://httpbin.org/basic-auth/user/passwd")
pg1

# Response [http://httpbin.org/basic-auth/user/passwd]
# Date: 2020-07-06 03:03
# Status: 401
# Content-Type: <unknown>
#         <EMPTY BODY>
# el status indica que no se ha podido acceder
#dado que requiere logearse


# con el paquete HTTR realmente puede autenticarse 
# para los sitios web, y puede hacerlo
# asignando a esto lo que llamaremos el identificador.
pg2 <- GET("http://httpbin.org/basic-auth/user/passwd",
           authenticate("user","passwd"))
# en los argumentos de authenticate 
#van las credenciales para logearse, usuario y contraseña
pg2
# Response [http://httpbin.org/basic-auth/user/passwd]
# Date: 2020-07-06 03:06
# Status: 200
# Content-Type: application/json
# Size: 47 B
# {
#         "authenticated": true, 
#         "user": "user"
# }

names(pg2)


### Using handles ####

google <- handle("http://google.com")

pg1 <- GET(handle = google, path = "/")
pg2 <- GET(handle = google, path = "search")



### Reading data from APIs


