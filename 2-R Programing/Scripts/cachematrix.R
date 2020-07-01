## esta función crea un objeto especial "matriz" 
# que puede almacenar en caché su inverso.

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

## Esta función calcula el inverso de la "matriz" 
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