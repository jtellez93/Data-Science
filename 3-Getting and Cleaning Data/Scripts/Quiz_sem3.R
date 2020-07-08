
### pregunta 1 ####
# La American Community Survey distribuye datos descargables sobre 
# las comunidades de los Estados Unidos. Descargue la encuesta de 
# microdatos de 2006 sobre viviendas para el estado de Idaho usando 
# download.file() desde aquí:
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# y cargue los datos en R. El libro de códigos, que describe los nombres
# de las variables, está aquí:
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# 
# Cree un vector lógico que identifique los hogares en más de 10 acres 
# que vendieron más de $ 10,000 en productos agrícolas. 
# Asigne ese vector lógico a la variable AgricultureLogical. 
# Aplique la función which() como esta para identificar 
# las filas del marco de datos donde el vector lógico es VERDADERO.

# which(AgricultureLogical)

# ¿Cuáles son los primeros 3 valores que resultan?


url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, "./Data/quiz3_preg1.csv")
datos <- read.csv("./Data/quiz3_preg1.csv")

# AGS = Sales of Agriculture Products
# 1 .None
# 2 .$1-$999
# 3 .$1000-$2499
# 4 .$2500-$4999
# 5 .$5000-$9999
# 6 .$10000 + 

# ACR = Lot size
# 1 .House on less than one acre
# 2 .House on one to less than ten acres
# 3 .House on ten or more acres

library(dplyr)

agricultureLogical <- datos$ACR == 3 & datos$AGS == 6
head(which(agricultureLogical), 3)
# [1] 125 238 262


### pregunta 2 ####

# Usando el paquete jpeg, lea la siguiente imagen de su instructor en R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

# Use el parámetro native = TRUE. 
# ¿Cuáles son los cuantiles 30 y 80 de los datos resultantes?
# (Algunos sistemas Linux pueden producir una respuesta 638 diferente 
#  para el 30º cuantil)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url, "./Data/quiz3_preg2_IMG.jpg", mode = 'wb')

install.packages("jpeg")
library(jpeg)
?jpeg

imagen <- jpeg::readJPEG("./Data/quiz3_preg2_IMG.jpg", native = TRUE)

quantile(imagen, probs = c(0.3, 0.8))

#     30%         80% 
# -15259150 -10575416


### pregunta 3 ####
# Cargue los datos del Producto Interno Bruto para los 190 países
# clasificados en este conjunto de datos:
#         
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
# Cargue los datos educativos de este conjunto de datos:
#         
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# 
# Haga coincidir los datos según el código corto del país. 
# ¿Cuántos de los ID coinciden? Ordene el marco de datos en orden 
# descendente por rango de PIB (por lo que Estados Unidos es el último).
# ¿Cuál es el 13er país en el marco de datos resultante?
#         
# Fuentes de datos originales:
#         
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# 
# http://data.worldbank.org/data-catalog/ed-stats

urlPIB <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
urlEDU <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(urlPIB, "./Data/quiz3_preg3_PIB.csv")
download.file(urlPIB, "./Data/quiz3_preg3_EDU.csv")

PIB <- read.csv("./Data/quiz3_preg3_PIB.csv", skip = 4, nrows = 190) %>%
        select(X:X.4) %>%
        select(-X.2) 
names(PIB) <- c("CountryCode", "Rank", "Economy", "Total")

EDU <- read.csv("./Data/quiz3_preg3_EDU.csv", skip = 4, nrows = 190) %>%
        select(X:X.4) %>%
        select(-X.2) 
names(EDU) <- c("CountryCode", "Rank", "Economy", "Total")

merged_df <- merge(PIB, EDU, by = "CountryCode")
nrow(merged_df)
# [1] 190


merged_df_o <- arrange(merged_df, desc(merged_df$Rank.x))

merged_df_o[13, 3]
# [1] St. Kitts and Nevis



### pregunta 4 ####
# ¿Cuál es la clasificación promedio del PIB para el grupo 
# "Ingresos altos: OECD" y "Ingresos altos: nonOECD"?

# 32.96667 91.91304



### pregunta 4 ####
# Corte la clasificación del PIB en 5 grupos de cuantiles separados. 
# Haga una tabla versus Ingresos. Grupo. Cuántos países

# Cuáles son los ingresos medios más bajos, 
# pero entre las 38 naciones con mayor PIB?


#           Income Group quantileGDP  N
# 1: Lower middle income (38.6,76.2] 13
# 2: Lower middle income   (114,152]  9
# 3: Lower middle income   (152,190] 16
# 4: Lower middle income  (76.2,114] 11
# 5: Lower middle income    (1,38.6]  5

# 5
