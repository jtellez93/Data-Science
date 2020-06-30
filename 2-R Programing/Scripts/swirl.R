### Install swirl ####
install.packages("swirl")
packageVersion("swirl")
library(swirl)

### Install the R Progroamming course ####
install_from_swirl("R Programming")


### Start swirl and complete the lessons ####
swirl()


### Semana 1 ####
### swirl Lesson 1: Basic Building Blocks ####

x <- 5 + 7
y <- x - 3

z <- c(1.1, 9, 3.14)
?c
z
c(z, 555)
c(z, 555, z)
z * 2 + 100

my_sqrt <- sqrt(z - 1)
my_sqrt

my_div <- z / my_sqrt
my_div

c(1, 2, 3, 4) + c(0, 10)
c(1, 2, 3, 4) + c(0, 10, 100)



### swirl Lesson 2: Workspace and Files ####

getwd() # directorio de trabajo
ls() # Objetos en el environment

x <- 9

list.files() # lista de todos los archivos en el directorio de trabajo
?list.files

args(list.files) # lista de argumentos del objeto (funcion)
old.dir <- getwd()

dir.create("testdir") # crea un nuevo directotio en el actual directorio de trabajo
setwd("testdir") # Asigna un nuevo directorio de trabajo

file.create("mytest.R") # Crea archivos en el actual directorio de trabajo
list.files()

file.exists("mytest.R") # valida si un archivo existe en el actual directorio de trabajo
file.info("mytest.R") # accede a la info acerca de un archivo especificado
file.rename("mytest.R", "mytest2.R") # cambia el nombre a un archivo
file.copy("mytest2.R", "mytest3.R") # copia archivos

file.path("mytest3.R") # muestra la direccion de un archivo
file.path("folder1", "folder2") # tambien se pueden construir nuevas rutas

?dir.create
dir.create(file.path('testdir2', 'testdir3'), recursive = TRUE)
# directorio y subdirectorio

setwd(old.dir)


### swirl Lesson 3: Sequences of Numbers ####

1:20
pi:10
15:1
?':'

seq(1, 20)
seq(0, 10, by = 0.5) # incremento de la forma by
seq(5, 10, length = 30) # length es el numero de incrementos en el intervalo

my_seq <- seq(5, 10, length=30)
length(my_seq)

1:length(my_seq)
seq(along.with = my_seq )
seq_along(my_seq)

rep(0, times = 40) # Repite un argumento el numero de veces deseado con times
rep(c(1, 2, 3), times = 10)
rep(c(0, 1, 2), times = 10)

rep(c(0, 1, 2), each = 10) # repite cada uno el numero de veces indicado



### swirl Lesson 4: Vectors ####

num_vect <- c(0.5, 55, -10, 6)
tf <- num_vect < 1
tf

num_vect >= 6

my_char <- c("My", "name", "is")
my_char

paste(my_char, collapse = " ") # concatena argumentos, los une con lo que se indique en collapse

my_name <- c(my_char, "Julian")
my_name
paste(my_name, collapse = " ")

paste("Hello", "world!", sep = " ")

paste(1:3, c("X", "Y", "Z"), sep = "") # concatena 2 vectores


paste(LETTERS, 1:4, sep = "-")


### swirl Lesson 5: Missing Values ####

x <- c(44, NA, 5, NA)
x * 3

y <- rnorm(1000)
z <- rep(NA, 1000)

my_data <- sample(c(y, z), 100) # toma una muestra de los elementos indicados
my_na <- is.na(my_data)
my_na

my_data == "NA"
sum(my_na)
my_data

0/0 # NAN
Inf - Inf # NAN



### swirl Lesson 6: Subsetting Vectors ####

x
x[1:10]
x[is.na(x)]

y <- x[!is.na(x)]
y
y[y > 0]

x[x > 0]
x[!is.na(x) & x > 0]

x[c(3, 5, 7)] # mostrar valores en esa posicion
x[0]
x[3000]

x[c(-2, -10)] # excluir valores
x[-c(2, 10)]

vect <- c(foo = 11, bar = 2, norf = NA) # vector con normbres 
names(vect)

vect2<- c(11, 2, NA)
names(vect2) <- c("foo", "bar", "norf") # asigna nombre a elementos del vector


identical(vect, vect2) # valida si son iguales

vect["bar"]
vect[c("foo", "bar")]


### swirl Lesson 7: Matrices and Data ####

my_vector <- 1:20
my_vector

dim(my_vector)
length(my_vector)

dim(my_vector) <- c(4, 5) # asigna dimension 4, 5 al vector (matriz)
dim(my_vector)

attributes(my_vector) # atributoso del objeto

my_vector
class(my_vector)

my_matrix <- my_vector
?matrix

my_matrix2 <- matrix(1:20, nrow = 4, ncol = 5) # crea una matriz
identical(my_matrix, my_matrix2)

patients <- c("Bill", "Gina", "Kelly", "Sean")
cbind(patients, my_matrix) # combina objetos por filas o columnas


my_data <- data.frame(patients, my_matrix)
my_data

class(my_data)

cnames <- c("patient", "age", "weight", "bp", "rating", "test") # vector de nombres
colnames(my_data)

colnames(my_data) <- cnames # cambiar nombres de encabezado a un dataframe
my_data




### Semana 2 ####
### swirl Lesson 8: Logic ####

TRUE == TRUE
(FALSE == TRUE) == FALSE
6 == 7
6 < 7
10 <= 10
1
4
5 != 7
!5 == 7
2
4

# El operador & es equivalente a interseccion (y)
FALSE & FALSE 
TRUE & c(TRUE, FALSE, FALSE) # evalua cada elemento del vector
TRUE && c(TRUE, FALSE, FALSE) # evalua solo el primero

# El operador | es equivalente a union (o)
TRUE | c(TRUE, FALSE, FALSE) # evalua cada elemento del vector
TRUE || c(TRUE, FALSE, FALSE) # evalua solo el primero

5 > 8 || 6 != 8 && 4 > 3.9
3

isTRUE(6 > 4)
4

identical('twins', 'twins') # evalua si son identicos
4

xor(5 == 6, !FALSE) # funcion (o) exclusivo, (TRUE, TRUE) = FALSE, (TRUE, FALSE) = TRUE
1

ints <- sample(10)
ints
ints > 5

which(ints > 7) # toma un vector y devuelve los indices que cumplen una condicion dada
2

any() # retorna TRUE si uno de los elementos del vector es TRUE
all() # retorna TRUE si todos los elementos del vector son TRUE

any(ints < 0)
all(ints > 0)
2


### swirl Lesson 9: Functions ####

Sys.Date()
mean(c(2, 4, 5))

boring_function <- function(x) {
        x
}

boring_function('My first function!')
boring_function


my_mean <- function(my_vector) {
        x <- sum(my_vector)/length(my_vector)
        x
}

my_mean(c(4, 5, 10))


remainder <- function(num = 2, divisor = 2) {
        num %% divisor
}

remainder(5)
remainder(11, 5)
remainder(divisor = 11, num = 5)
remainder(4, div = 2)

args(remainder)


evaluate <- function(func, dat){
        func(dat)
}

evaluate(sd, c(1.4, 3.6, 7.9, 8.8))

evaluate(function(x){x+1}, 6)

evaluate(function(x){x[1]}, c(8, 4, 0))

evaluate(function(x){x[length(x)]}, c(8, 4, 0))

?paste
paste("Programming", "is", "fun!")


telegram <- function(...){
        paste("START", ..., "STOP")
}

telegram("Hola", "mundo")



mad_libs <- function(...){
        # Do your argument unpacking here!
        args <- list(...)
        # Don't modify any code below this comment.
        # Notice the variables you'll need to create in order for the code below to
        # be functional!
        place <- args[["place"]]
        adjective <- args[["adjective"]]
        noun <- args[["noun"]]
        
        paste("News from", place, "today where", adjective, "students took to the streets in protest of the new", noun, "being installed on campus.")
}

mad_libs("cali", "bueno", "Julian")


"%p%" <- function(a, b){ # Remember to add arguments!
        paste(a, b)
}

"I"%p%"love"%p%"R!"



### swirl Lesson 10: Dates and Times ####

d1 <- Sys.Date() # fecha del sistema
class(d1)  # clase de un objeto
unclass(d1) # muestra como luce internamente un objeto
d1

d2 <- as.Date("1969-01-01")
unclass(d2)

t1 <- Sys.time() # fecha y hora del sistema
t1
class(t1) # POSIXct y POSIXt son lasa dos formas de representar la informacion en R
# por default R muestra el sistema POSIXct
unclass(t1)

t2 <- as.POSIXlt(Sys.time()) # tipo POSIXt, contiene mas informacion
t2
class(t2)
unclass(t2)
str(unclass(t2)) # vista mas compacta que unclass
t2$min

weekdays(d1) # muestra el dia de la semana de cualquier fecha u objeto formato fecha
months(t1) # muestra el mes de cualquier fecha u objeto formato fecha
quarters(t2) # muestra trimestre de cualquier fecha u objeto formato fecha

t3 <- "October 17, 1986 08:24"
t4 <- strptime(t3, "%B %d, %Y %H:%M") # convierte vectores de carecteres en POSIXlt
t4
class(t4)

Sys.time() > t1
Sys.time() - t1

difftime(Sys.time(), t1, units = 'days') # muestra la diferencia entre fechas, en formato especificado



### swirl Lesson 11: lapply and sapply ####

head(flags)
dim(flags) #muestra la dimension de un objeto

class(flags)


cls_list <- lapply(flags, class) # aplico class a cada columna del df
cls_list
class(cls_list)
as.character(cls_list) # convierto a vector de caracteres 

cls_vect <- sapply(flags, class)
cls_vect
class(cls_vect)

sum(flags$orange)


flag_colors <- flags[, 11:17]
head(flag_colors)
lapply(flag_colors, sum)
sapply(flag_colors, sum)
sapply(flag_colors, mean)


flag_shapes <- flags[, 19:23]
lapply(flag_shapes, range)
shape_mat <- sapply(flag_shapes, range)
shape_mat
class(shape_mat)


unique(c(3, 4, 5, 5, 5, 6, 6)) # elimina duplicados
unique_vals <- lapply(flags, unique)
unique_vals
sapply(unique_vals, length)
sapply(flags, unique)


lapply(unique_vals, function(elem) elem[2])



### swirl Lesson 12: vapply and tapply ####

sapply(flags, unique)

vapply(flags, unique, numeric(1))
ok()

sapply(flags, class)
vapply(flags, class, character(1))


?tapply
table(flags$landmass)
table(flags$animate)


tapply(flags$animate, flags$landmass, mean)
tapply(flags$population, flags$red, summary)
4
tapply(flags$population, flags$landmass, summary)
1



### swirl Lesson 13: Looking at Data ####

ls() # muestra los objetos de mi espacio de trabajo, global environment
class(plants)
dim(plants) # muestra numero de filas y numero de columnas
nrow(plants) # numero de filas
ncol(plants) # numero de columnas

object.size(plants) # muestra el espacio ocupado en memoria por el objeto

names(plants) # muestra encabezados del df

head(plants) # muestra las primeras 6 filas
head(plants, 10) # muestra las primeras 10 filas

tail(plants) # muestra las ultimas 6 filas
tail(plants, 15) # muestra las ultimas 15 filas

summary(plants)

table(plants$Active_Growth_Period) # frecuencia por categoria

str(plants)



### swirl Lesson 14: Simulation ####

?sample

sample(1:6, 4, replace = TRUE)
sample(1:20, 10)

LETTERS
sample(LETTERS)

flips <- sample(c(0,1), 100, replace = TRUE, prob = c(0.3, 0.7))
flips

sum(flips)

?rbinom
rbinom(1, size = 100, prob = 0.7)

flips2 <- rbinom(100, 1, prob = 0.7)
flips2
sum(flips2)

?rnorm
rnorm(10)
rnorm(10, 100, 25)

?rpois
rpois(5, 10)

my_pois <- replicate(100, rpois(5, 10))
# replicate crea una matriz donde cada columna contiene una ejecucion 
my_pois

cm <- colMeans(my_pois) # calcula la media por columna de una matriz
hist(cm)


### swirl Lesson 15: Base Graphics  ####

data(cars)
?cars

head(cars)

plot(cars)
?plot

plot(x = cars$speed, y = cars$dist)
plot(dist ~ speed, cars)

plot(x = cars$dist, y = cars$speed)

plot(x = cars$speed, y = cars$dist, xlab = "Speed")
plot(x = cars$speed, y = cars$dist, ylab = "Stopping Distance")
plot(x = cars$speed, y = cars$dist, xlab = "Speed", ylab = "Stopping Distance")

plot(cars, main = "My Plot")
plot(cars, sub = "My Plot Subtitle")

plot(cars, col = 2) # color rojo.

plot(cars, xlim = c(10, 15)) # limita los valores del eje x

plot(cars, pch = 2) # cambia forma de los puntos



data(mtcars)

?boxplot

boxplot(mpg ~ cyl, mtcars)

hist(mtcars$mpg)










