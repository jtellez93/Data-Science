
### Reading mySQL ####

# los datos estan estructurados en bases de datos
# en tablas con bases de datos
# en campos con tablas

# cada fila es llamada record

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


