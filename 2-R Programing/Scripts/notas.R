
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



### The str Function ####

# Muestra de forma compacta la estructura interna de un objeto R, 
# una función de diagnóstico y una alternativa al resumen 
# (y, en cierta medida, dput). Idealmente, 
# solo se muestra una línea para cada estructura "básica".


str(str)
# function (object, ...)

str(lm)
str(ls)

x <- rnorm(100, 2, 4)
summary(x)
str(x)

f <- gl(40, 10)
str(f)
summary(f)

library(datasets)
head(airquality)

str(airquality)


m <- matrix(rnorm(100), 10, 10)
str(m)

s <- split(airquality, airquality$Month)
str(s)



### Simulation ####

# Generating Random Numbers

# para cada distribucion de probabilidad hay 
# funciones asociadas por letra (d, r, p, q)
# d = densidad
# r = generacion de variables aleatorios
# p = distribucion acumulada
# q = funcion cuantil

x <- rnorm(10)
x

x <- rnorm(10, 20, 2)
x
summary(x)


set.seed(1) # establece el valor de la semilla para la generacion de 
# numeros seudo aleatorios
rnorm(5)

rpois(10, 1)
rpois(10, 20)

ppois(2, 2) # distribucion acumulada
# [1] 0.6766764 Pr(x <= 2)

ppois(4, 2) 
# [1] 0.947347 Pr(x <= 4)

ppois(6, 2) 
# [1] 0.9954662 Pr(x <= 4)


# Simulating a Linear Model


# asuma el siguiente modelo de regresion lineal 
# y = B0 + B1x + epxilon
# epxilon ~ N(0. 2^2)
# x ~ N(0, 1^2), B0= 0.5, B1 = 2

set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y = 0.5 + 2 * x + e

summary(y)
plot(x, y)


set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y = 0.5 + 2 * x + e

summary(y)
plot(x, y)


# generar numeros aleatorios de un modleo lineal generalizado

# Y = Poisson(mu)
# log mu = B0 + B1x
# B0 = 0.5, B1 = 0.3

set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x

y = rpois(100, exp(log.mu))

summary(y)
plot(x, y)


# Random Sampling

set.seed(1)
sample(1:10, 4) # toma una muestra aleatoria de un tamañp dado de un objeto
sample(letters, 5)

sample(1:10)
sample(1:10, replace = TRUE) # muestra con reemplazo



# Profiling R code
# analisis de rendimiento
# se usa para optimizar el codigo, es una forma sistematica de revisar
# el tiempo que tarda en ejecucion cada proceso del codigo


# system.time(expr, gcFirst = TRUE)
# evalua el tiempo de ejecucion de una expresion
# retorna los el tiempo de ejecucion en segundos

# user time: tiempo usado de la CPU por la expresion
# elapsed time: tiempo observado por el usuario


# Tiempo de ususario mayor al de la maquina
system.time(readLines("http://www.jhsph.edu"))
#  user  system elapsed 
#  0.14    0.01    1.68 


# Tiempo de ususario menor al de la maquina
hilbert <- function(n){
        i <- 1:n
        1 / outer(i - 1, i, "+")
}

x <- hilbert(1000)

system.time(svd(x))
#  user  system elapsed 
#   4.06    0.01    4.44


system.time({
        n <- 1000
        r <- numeric(n)
        for(i in 1:n){
                x <- rnorm(n)
                r[i] <- mean(x)
        }
})

#  user  system elapsed 
#   0.13    0.00    0.13


# Rprof(...) inicia el analizador de R
# summaryRprof(...) resume los resultados del analizador
# no se puede usar junto con la funcion system.time()


