
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





