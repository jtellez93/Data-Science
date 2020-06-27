
prueba <- function(a, b){
  if(a == b){
    resultado <- "TRUE"
  } else{
    resultado <- "FALSE"
  }
  return(resultado)
}

# crea un "vector" especial, que es realmente una lista que contiene una función para:
# establecer el valor del vector
# obtener el valor del vector
# establecer el valor de la media
# obtener el valor de la media

makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}


# calcula la media del "vector" especial creado con la función anterior. 
# Sin embargo, primero verifica si la media ya se ha calculada. 
# Si es así, obtiene la media del caché y omite el cálculo. 
# De lo contrario, calcula la media de los datos y 
# establece el valor de la media en la memoria caché 
# mediante la función setmean.

cachemean <- function(x, ...) {
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}

# prueba

x <- as.numeric(c(1:20))
class(x)
a <- mean(x)
z <- makeVector(x)

b <- cachemean(z)

prueba(a, b)



#### Respuesta ####

# makeCacheMatrix: esta función crea un objeto especial "matriz" 
#que puede almacenar en caché su inverso.

makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) i <<- inverse
  getinverse <- function() i
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


# cacheSolve: Esta función calcula el inverso de la "matriz" 
# especial devuelta por makeCacheMatrix arriba. 
# Si el inverso ya se ha calculado (y la matriz no ha cambiado), entonces el caché debe recuperar el inverso del caché.

cacheSolve <- function(x, ...) {
  i <- x$getinverse()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinverse(i)
  i
}


# prueba

set.seed(1000)
Y <- matrix(rnorm(9) , 3, 3)
a <- solve(Y)
Z <- makeCacheMatrix(Y)

b <- cacheSolve(Z)

prueba(a, b)



