
## Components of Tidy Data
1 datos en bruto
2 un conjunto de datos ordenados
3 el libro de codigo describiendo cada  variable y valores en el conunto de datos ordenados
4 un explicito y exacto procedimiento de como usar los componentes 1 -> 2,3


## The code book
un formato comun es un archivo de word o texto
debe tener una seccion llamada Study design donde se describa como se recolecto la informacion
debe tener una seccion llamada code book donde se describa cada variable y unidades

## The instruction list
idealmente un script en R
la entrada son los datos en bruto
la salida es el conjunto de datos ordenado procesado
no hay parametros para el script
se debe describir paso a paso como optener la salida

## Downloading files

~~~
file.exists("directoyName") # valida si el directorio existe
dir.create("directoyName") # crea el directorio si este no existe

# ejemplo de validar y crear directorio si este no existe

if(!file.exists("data")){
        dir.create("data")
}
~~~

## Getting data from the internet

se hace usando la funcion ``download.file()``

~~~
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
list.files("./data") # muestra los archivos en el directorio

dateDownloaded <- date() # guardo la fecha en la que descargue la informacion
dateDownloaded
~~~


## Reading local flat files

para leer archivos planos usamos ``read.table()``
estos son algunos parametros importantes ``header, sep, row.names, nrows``

estas son funciones relacionadas ``read.csv(), read.csv2()``

~~~
cameraData <- read.table("./Data/data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)

cameraData <- read.csv("./Data/data/cameras.csv")
head(cameraData)

# read.csv tiene por defecto el separador por comas
~~~


## Reading XML
Extensible markup language
Lenguaje de marcado extensible

es frecuentemente usaDO para guardar estructuras de datos, particularmente muy usado en aplicaciones de internet, extraer XML es la base para la mayoría del  web scraping
**componentes**
* Markup: etiquetas que dan la estructura del texto
* Content: el texto real del documento
~~~
library(RCurl)
library(XML)
fileUrl <- "https://www.w3schools.com/xml/simple.xml"

xData <- getURL(fileUrl)

doc <- xmlTreeParse(xData, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

names(rootNode)
~~~

puedo acceder directamente a partes del documento XML

~~~
rootNode[[1]] # muestra el nodo 1 completo 
rootNode[[1]][[1]] # muestra el elemento 1 del nodo 1
~~~

con l funcion ``xmlSApply()`` puedo operan en los subnodos del nodo XML y no en los campos del propio objeto de nodo. la funcion ``xmlValue()`` extrae el contenido de un nodo.

Entonces puedo extraer el contenido de cada nodo en ``rootNode`` usando estas dos funciones.

~~~
xmlSApply(rootNode, xmlValue)
~~~

con la funcion ``xpathSApply()`` encuentro nodos coincidentes en un árbol XML interno / DOM

puedo buscar por ejemplo un criterio de interes **name**, si la uso con ``xmlValue()`` puedoobtener el valor de cada elemento **name** dentro de cada subnodo de ``rootNode``
~~~
xpathSApply(rootNode, "//name", xmlValue)
~~~

si deseo obtener el precio puedo usar el criterio **price**
~~~
xpathSApply(rootNode, "//price", xmlValue)
~~~

### Ejemplo

extraer informacion de la pagina de espn de el equipo de la nfl baltimore ravens

~~~
fileUrl <- "https://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"
xData <- getURL(fileUrl)

doc <- htmlTreeParse(xData, useInternalNodes =  TRUE)
nextGame <- xpathSApply(doc, "//li[@class='nextGame']", xmlValue)
# el argumento li hace referencia a lista

nextGame
~~~



## Reading JSON
acrónimo de JavaScript Object Notation
notación de objeto de JavaScript
es un formato de texto sencillo para el intercambio de datos, muy usualmente usado en internet.

es similar a el formato XML pero con sintaxis diferente.

para leer archivos ``.json`` se hace uso de lafuncion ``fromJSON()``

~~~
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtellez93/repos")
names(jsonData)

names(jsonData$owner) # nombres de una variable en particular en este caso (owner)

jsonData$owner$login 
~~~

## Writing data frames to JSON

para escribir df en .json se usa la funcion ``toJSON()``
~~~
myjson <- toJSON(iris, pretty = TRUE)
cat(myjson) # concatena e imprime
~~~

para leerlos nuevamente y trabajarlos usamos nuevamente ``fromJSON``

~~~
iris2 <- fromJSON(myjson)
head(iris2)
~~~


## Using data.table()

esta escrita en C, esto la hacemucho mas rapida.
es muy rapida para el subsetting, para agrupar y para actualizar datos

~~~
library(data.table)

DF <- data.frame(x=rnorm(9), y=rep(c("a","b","c"), each = 3), z=rnorm(9))
head(DF, 3)

DT <- data.table(x=rnorm(9), y=rep(c("a","b","c"), each = 3), z=rnorm(9))
head(DF, 3)
~~~

para ver todas las tablas de datos en memoria se usa la funcion ``tables()``

~~~
tables()
~~~

subsetting rows

~~~
DT[2, ]
DT[DT$y == "a"]
DT[c(2,3)]
DT[,c(2,3)]
~~~

calculating values for variables with expressions

~~~
DT[, list(mean(x), sum(z))]
DT[, table(y)]
~~~

Adding new columns

~~~
DT[, w:=z^2]
DT[, y:= 2]
~~~

Multiple operations

~~~
DT[, m:= {tmp <- (x + z); log2(tmp + 5)}]
~~~

Plyr like operations

~~~
DT[, a:= x>0]
DT[, b:= mean(x + w), by = a]
~~~

Special variables

``.N`` es entero, de largo 1, contiene el nuemro r

~~~
set.seed(123)
DT <- data.table(x = sample(letters[1:3], 1E5, TRUE))
DT[, .N, by = x]
~~~

Keys

~~~
DT <- data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
setkey(DT, x) # establesco la llave para relacionar la tabla
DT['a']
~~~

Joins

~~~
DT1 <- data.table(x=c("a", "a", "b", "dt1"), y=1:4)
DT2 <- data.table(x=c("a", "b", "dt2"), z=5:7)
setkey(DT1, x); setkey(DT2, x)

merge(DT1, DT2)
~~~





















