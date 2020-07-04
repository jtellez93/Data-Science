
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

~~~







