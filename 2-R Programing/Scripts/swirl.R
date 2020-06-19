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
### swirl Lesson 8:  ####





































