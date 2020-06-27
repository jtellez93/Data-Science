
### Escribir datos ####
# funciones para escribir datos en R, conservan los tipos de variables
#(metadatos)
dump() # Esta función toma un vector de nombres de objetos R 
       # y produce representaciones de texto de los objetos en un archivo 

dput() # Escribe una representación de texto ASCII de un objeto R 
      # en un archivo o conexión, o usa uno para recrear el objeto.

# ejemplo

# dump
x <- "foo"
y <- data.frame(a=1, b="a")
dump(c("x","y"), file = "data.R")
rm(x,y)
source("data.R")
x
y

# dput
y <- data.frame(a=1, b="a")
dput(y, file = "y.R")

new.y <- dget("y.R")
new.y
class(new.y)


### Depurar NA ####
x <- c(1, 2, NA, 4, NA, 6)

# complete.cases
good <- complete.cases(x)
x[good]

# is.na
bad <- is.na(x)
x[!bad]



### funciones de bucle ####

# lapply(): lapply(list, function, ...)
# evalua una funcion indicada a todos los elementos de una lista
# devuelve los resultados como lista

x <- list(a = c(1:10), b = c(11:20))
y <- lapply(x, mean) # calcula la lmedia de cada elemento de la lista
class(y)

# sapply(): sapply(list, function, ...)
# evalua una funcion indicada a todos los elementos de una lista
# devuelve los resultados como vector de lo contrario como lista

x <- list(a = c(1:10), b = c(11:20))
y <- sapply(x, mean) # calcula la lmedia de cada elemento de la lista
class(y)

# apply(): apply(array, margin, ...)
# evalua una funcion indicada a todos los elementos de una fila o
# columna seleccionada en el margin (1= filas, 2=columnas)
# devuelve los resultados como vector

x <- matrix(1:20, 4, 5)
y <- apply(x, 1, mean) # calcula la media para cada fila
y
z <- apply(x, 2, mean) # calcula la media para cada columna
z


# mapply(): mapply(function, ...)
# version multivariada de lapply y sapply
# evalua una funcion indicada a multiples objetos (listas)
# devuelve los resultados como lista
# sirve para vectorizar funciones que no admiten un vector como argumento.

list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))
mapply(rep, 1:4, 4:1)


# tapply(): tapply(vector, index, function)
# evalua una funcion a subconjuntos de un vector
# devuelve los resultados como vector o lista segun el caso

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10) # genera factores para un patron especificado de niveles

y <- tapply(x, f, mean) # calcula la media a cada subconjunto de x
# los subconjuntos se indicaron en f
y



# split(): function (x, f, drop = FALSE, ...)
# puede dividir un objeto en categorias indicadas en f
# una vez dividido se pueden usar las funciones lapply, sapply
# para aplicar una funcion a grupos individuales
# devuelve los resultados como lista


x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)

y <- split(x, f)
y

z <- lapply(split(x, f), mean)
z

w <- sapply(split(x, f), mean)
w

library(datasets)
head(airquality)

s <- split(airquality, airquality$Month) # divido el df por mes

lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = T))
# calcula la media para cada mes para tres columnas seleccionadas

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = T))
# calcula la media para cada mes para tres columnas seleccionadas


### Debugging Tools - Diagnosing the Problem ####
# herramientas de depuracion


# traceback(): imprime la pila de llamadas del último error detectado

# debug(): imprime todo el codigo de la funcion, 
# permite ejecutar codigo linea a linea con la letra n "next"

# recover(): puedo usarla como manejador de errores con 
# options(error = recover)



# The str Function










