
### pregunta 1 ####
# Registre una aplicación con la API de Github 
# aquí https://github.com/settings/applications. 
# Acceda a la API para obtener información sobre los repositorios
# de sus instructores (pista: esta es la url que desea
# "https://api.github.com/users/jtleek/repos"). 
# Utilice estos datos para encontrar la hora en que se creó 
# el repositorio de datos compartidos. ¿A qué hora se creó?

library(httr)

# Encuentra la configuración de OAuth para github
oauth_endpoints("github") 

# mi API de githhub
myapp <- oauth_app("github",
                   key = "Iv1.71dc407055bd5dba",
                   secret = "852b1ad1e67602f8f42f5afafae2a32895b9b5ac"
)


# Obtenga credenciales de OAuth
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)


# Usar API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek?tab=repositories", gtoken)
stop_for_status(req)
content <- content(req)

#obtengo url de los repos
content$repos_url


gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)

# obtengo dta de los repos
content <- content(req)

# extraigo nombre y fecha de creacion de cada repo
library(dplyr)
y <- list()
for (i in 1:30){
        y[[i]] <- data.frame(content[[i]]$name, content[[i]]$created_at)
}

y <- bind_rows(y)
names(y) <- c("name", "created_at")

# obtengo fecha del repo datasharing
y[y$name == "datasharing",]

# name           created_at
# 19 datasharing 2013-11-07T13:25:07Z



### pregunta 2 ####

# El paquete sqldf permite la ejecución de comandos SQL en 
# marcos de datos R. 
# Utilizaremos el paquete sqldf para practicar las consultas
# que podamos enviar con el comando dbSendQuery en RMySQL.
# 
# Descargue los datos de American Community Survey y cárguelos
# en un objeto R llamado acs

# ¿Cuál de los siguientes comandos seleccionará solo los datos
# para los pesos de probabilidad pwgtp1 con edades inferiores a 50?

library(sqldf)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

download.file(url, "./Data/Quiz2_preg2.csv")
acs <- read.csv("./Data/Quiz2_preg2.csv")

head(acs)

res <- sqldf("select pwgtp1 from acs where AGEP < 50")
head(res)



### pregunta 3 ####
# Usando el mismo marco de datos que creó en el problema anterior, 
# ¿cuál es la función equivalente a unique(acs$AGEP)

x <- unique(acs$AGEP)
length(x)

a <- sqldf("select AGEP where unique from acs") #no
b <- sqldf("select unique * from acs") #no
c <- sqldf("select distinct pwgtp1 from acs")
d <- sqldf("select distinct AGEP from acs")

identical(x, c$pwgtp1) # FALSE
identical(x, d$AGEP) # TRUE



### pregunta 4 ####
# Cuántos caracteres hay en las líneas 10, 20, 30 y 100 de HTML
# de esta página: http://biostat.jhsph.edu/~jleek/contact.html

con <- url("http://biostat.jhsph.edu/~jleek/contact.html") # creo lalconexion
htmlCode <- readLines(con, warn = F) # leo el Html code
close(con) # cierro la conexion

# la funcion nchar() cuenta el numero de caracteres

lineas <- c("10", "20", "30", "100")
y <- list()
for (i in lineas){
        y[i] <- nchar(htmlCode[as.numeric(i)])
}

y <- t(as.data.frame(bind_rows(y)))
y
# [,1]
# 10    45
# 20    31
# 30     7
# 100   25


### pregunta 5 ####
# Lea este conjunto de datos en R e informe 
# la suma de los números en la cuarta de las nueve columnas.

# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# Sugerencia: este es un formato de archivo de ancho fijo

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

# la funcion read.fwf() Lea una tabla de datos formateados 
# de ancho fijo en un data.frame.

datos <- read.fwf(fileUrl, skip = 4 , widths = c(12, 7, 4, 9, 4, 9, 4, 9, 4))

sum(datos[, 4])
# [1] 32426.7
