### Install swirl ####
install.packages("swirl")
packageVersion("swirl")
library(swirl)

### Install the R Progroamming course ####
install_from_swirl("R Programming")


### Start swirl and complete the lessons ####
swirl()


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













