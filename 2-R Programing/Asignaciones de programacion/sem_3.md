
# Asignacion de programacion semana 3

## Instrucciones

la segunda asignación de programación requerirá que escriba una función R que pueda almacenar en caché los cálculos potencialmente lentos. Por ejemplo, tomar la media de un vector numérico suele ser una operación rápida. Sin embargo, para un vector muy largo, puede tomar demasiado tiempo calcular la media, especialmente si tiene que calcularse repetidamente (por ejemplo, en un bucle). Si el contenido de un vector no está cambiando, puede tener sentido almacenar en caché el valor de la media para que cuando lo necesitemos de nuevo, se pueda buscar en la memoria caché en lugar de volver a calcular. En esta asignación de programación aprovechará las reglas de alcance del lenguaje R y cómo se pueden manipular para preservar el estado dentro de un objeto R.


## Criterios de revisión

Esta tarea se calificará mediante evaluación por pares. Durante la fase de evaluación, debe evaluar y calificar las presentaciones de al menos 4 de sus compañeros de clase. Si no completa al menos 4 evaluaciones, su calificación de asignación se reducirá en un 20%.


## Ejemplo: almacenamiento en caché de la media de un vector

En este ejemplo, presentamos el operador ``<< -`` que se puede utilizar para asignar un valor a un objeto en un entorno que es diferente del entorno actual. A continuación hay dos funciones que se utilizan para crear un objeto especial que almacena un vector numérico y la media de la memoria caché.

La primera función, ``makeVector`` crea un "vector" especial, que es realmente una lista que contiene una función para:

1. establecer el valor del vector
2. obtener el valor del vector
3. establecer el valor de la media
4. obtener el valor de la media

~~~
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
~~~

La siguiente función calcula la media del "vector" especial creado con la función anterior. Sin embargo, primero verifica si la media ya se ha calculado. Si es así, obtiene la media del caché y omite el cálculo. De lo contrario, calcula la media de los datos y establece el valor de la media en la memoria caché mediante la función ``setmean``.

~~~
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
~~~


## Asignación: almacenamiento en caché de la inversa de una matriz

La inversión de una matriz suele ser un cálculo costoso y puede haber algún beneficio en el almacenamiento en caché de la inversa de una matriz en lugar de calcularla repetidamente (también hay alternativas a la inversión en matriz que no discutiremos aquí). **Su tarea es escribir un par de funciones que almacenan en caché el inverso de una matriz.**

Escribe las siguientes funciones:

1. **makeCacheMatrix:** esta función crea un objeto especial "matriz" que puede almacenar en caché su inverso.

2. **cacheSolve:** Esta función calcula el inverso de la "matriz" especial devuelta por ``makeCacheMatrix arriba``. Si el inverso ya se ha calculado (y la matriz no ha cambiado), entonces el caché debe recuperar el inverso del caché.

Calcular el inverso de una matriz cuadrada se puede hacer con la función ``Solve`` en R. Por ejemplo, si X es una matriz invertible cuadrada, ``solve(X)`` devuelve su inverso.

Para esta asignación, suponga que la matriz suministrada siempre es invertible.

Para completar esta tarea, debe hacer lo siguiente:

1. Bifurca el repositorio de GitHub que contiene los archivos stub R en https://github.com/rdpeng/ProgrammingAssignment2 para crear una copia bajo tu propia cuenta.

2. Clone su repositorio GitHub bifurcado en su computadora para que pueda editar los archivos localmente en su propia máquina.

3. Edite el archivo R contenido en el repositorio de git y coloque su solución en ese archivo (no cambie el nombre del archivo).

4. Ingrese su archivo R completo en SU repositorio git y empuje su rama git al repositorio GitHub bajo su cuenta.

5. Envíe a Coursera la URL de su repositorio de GitHub que contiene el código R completo para la tarea.


Además de enviar la URL para su repositorio de GitHub, deberá enviar el hash SHA-1 de 40 caracteres (como una cadena de números del 0-9 y letras de af) que identifica la confirmación del repositorio que contiene la versión de los archivos que usted quiere enviar. Puedes hacer esto en GitHub haciendo lo siguiente

1. Ir a la página web del repositorio de GitHub para esta tarea

2. Haga clic en el ``"??`` confirma "enlace donde? es la cantidad de confirmaciones que tiene en el repositorio. Por ejemplo, si realizó un total de 10 confirmaciones en este repositorio, el enlace debería decir "10 confirmaciones".

3. Verá una lista de confirmaciones que ha realizado en este repositorio. El ``commit`` más reciente está en la cima. Si esto representa la versión de los archivos que desea enviar, simplemente haga clic en el botón "copiar al portapapeles" en el lado derecho que debería aparecer al pasar el cursor sobre el hash SHA-1. Pegue este hash SHA-1 en el sitio web del curso cuando envíe su tarea. Si no desea utilizar la confirmación más reciente, baje y encuentre la confirmación que desea y copie el hash SHA-1.


Una presentación válida se verá algo así (¡esto es solo un ejemplo!)

https://github.com/rdpeng/ProgrammingAssignment2


## Calificación

Esta tarea se calificará mediante evaluación por pares. Durante la fase de evaluación, debe evaluar y calificar las presentaciones de al menos 4 de sus compañeros de clase. Si no completa al menos 4 evaluaciones, su calificación de asignación se reducirá en un 20%.







