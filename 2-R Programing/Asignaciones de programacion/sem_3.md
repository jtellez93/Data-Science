
## Asignacion de programacion semana 3

# Instrucciones

la segunda asignación de programación requerirá que escriba una función R que pueda almacenar en caché los cálculos potencialmente lentos. Por ejemplo, tomar la media de un vector numérico suele ser una operación rápida. Sin embargo, para un vector muy largo, puede tomar demasiado tiempo calcular la media, especialmente si tiene que calcularse repetidamente (por ejemplo, en un bucle). Si el contenido de un vector no está cambiando, puede tener sentido almacenar en caché el valor de la media para que cuando lo necesitemos de nuevo, se pueda buscar en la memoria caché en lugar de volver a calcular. En esta asignación de programación aprovechará las reglas de alcance del lenguaje R y cómo se pueden manipular para preservar el estado dentro de un objeto R.

# Criterios de revisión

Esta tarea se calificará mediante evaluación por pares. Durante la fase de evaluación, debe evaluar y calificar las presentaciones de al menos 4 de sus compañeros de clase. Si no completa al menos 4 evaluaciones, su calificación de asignación se reducirá en un 20%.

# Ejemplo: almacenamiento en caché de la media de un vector

En este ejemplo, presentamos el operador << - que se puede utilizar para asignar un valor a un objeto en un entorno que es diferente del entorno actual. A continuación hay dos funciones que se utilizan para crear un objeto especial que almacena un vector numérico y la media de la memoria caché.

La primera función, makeVector crea un "vector" especial, que es realmente una lista que contiene una función para:

1. establecer el valor del vector
2. obtener el valor del vector
3. establecer el valor de la media
4. obtener el valor de la media

~
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
~

