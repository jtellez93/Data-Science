
# Programming Assignment 3

## R Programming

Descargue el archivo ``ProgAssignment3-data.zip`` que contiene los datos para la Tarea de programación 3 del sitio web de Coursera. Descomprima el archivo en un directorio que servirá como su directorio de trabajo. Cuando inicie R, asegúrese de cambiar su directorio de trabajo al directorio donde descomprimió los datos.

Los datos para esta asignación provienen del sitio web de Hospital Compare (http://hospitalcompare.hhs.gov) administrado por el Departamento de Salud y Servicios Humanos de EE. UU. El propósito del sitio web es proporcionar datos e información sobre la calidad de la atención en más de 4,000 hospitales certificados por Medicare en los EE. UU. Este conjunto de datos cubre esencialmente todos los principales hospitales de EE. UU. Este conjunto de datos se utiliza para una variedad de propósitos, incluida la determinación de si los hospitales deben ser multados por no brindar atención de alta calidad a los pacientes (ver http://goo.gl/jAXFX para obtener algunos antecedentes sobre este tema en particular).

El sitio web de Hospital Compare contiene muchos datos y solo analizaremos un pequeño subconjunto para esta tarea. El archivo zip para esta tarea contiene tres archivos

- **outcome-of-care-measure.csv:** contiene información sobre la mortalidad a los 30 días y las tasas de reingreso por ataques cardíacos, insuficiencia cardíaca y neumonía en más de 4,000 hospitales.

- **hospital-data.csv:** contiene información sobre cada hospital.

- **Hospital_Revised_Flatfiles.pdf:** Descripciones de las variables en cada archivo (es decir, el libro de códigos).

Una descripción de las variables en cada uno de los archivos está en el archivo PDF incluido llamado ``Hospital_Revised_Flatfiles.pdf``. Este documento contiene información sobre muchos otros archivos que no están incluidos con esta asignación de programación. Deberá centrarse en las variables para el Número 19 ``(“Outcome of Care Measures.csv”)`` y el Número 11 ``(“Hospital Data.csv”)``. Puede resultarle útil imprimir este documento (al menos las páginas de las Tablas 19 y 11) para tener a su lado mientras trabaja en esta tarea. En particular, los números de las variables para cada tabla indican índices de columna en cada tabla (es decir, ``"Hospital Name"`` es la columna 2 en el archivo ``outcome-of-care-measure.csv``).

## 1 Graficar las tasas de mortalidad de 30 días por ataque cardíaco

Lea los datos de resultados en R a través de la función ``read.csv`` y observe las primeras filas.

~~~
> outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
> head(outcome)
~~~

Hay muchas columnas en este conjunto de datos. Puede ver cuántos escribiendo `` ncol (_outcome) `` (puede ver el número de filas con la función ``nrow``). Además, puede ver los nombres de cada columna escribiendo ``names(outcome)`` (los nombres también están en el documento PDF.

Para hacer un histograma simple de las tasas de mortalidad de 30 días por ataque cardíaco (columna 11 en el conjunto de datos de resultados), ejecute

~~~
> outcome[, 11] <- as.numeric(outcome[, 11])
> ##Puede recibir una advertencia sobre la introducción de NA; eso está bien*
> hist(outcome[, 11])
~~~

Debido a que originalmente leímos los datos como caracteres (al especificar ``colClasses = "character"`` necesitamos forzar la columna para que sea numérica. Puede recibir una advertencia sobre la introducción de NA pero eso está bien.


## 2 Encontrar el mejor hospital en un estado

Escriba una función llamada ``best`` que tome dos argumentos: el nombre abreviado de 2 caracteres de un estado y un nombre de outcome. La función lee el archivo **``result-of-care-measure.csv``** y devuelve un vector de caracteres con el nombre del hospital que tiene la mejor mortalidad **(es decir, la más baja)** de 30 días para el resultado especificado en ese estado. El nombre del hospital es el nombre proporcionado en la variable ``Hospital.Name.`` Los resultados pueden ser uno de "heart attack", "heart failure" o "“pneumonia". Los hospitales que no tienen datos sobre un resultado particular deben excluirse del conjunto de hospitales al decidir las clasificaciones.

**Manejo de empates.** Si hay un empate para el mejor hospital para un resultado dado, entonces los nombres de los hospitales se deben ordenar en orden alfabético y se debe elegir el primer hospital de ese conjunto (es decir, si los hospitales "b", "c" y "f" están empatados para mejor, entonces el hospital "b" debe ser devuelto).

La función debe usar la siguiente plantilla.

~~~
best <- function(state, outcome) {
## Read outcome data
## Check that state and outcome are valid
## Return hospital name in that state with lowest 30-day death
## rate
}
~~~

La función debe verificar la validez de sus argumentos. Si se pasa un valor de state no válido a ``best``, la función debería arrojar un error a través de la función de detención con el mensaje exacto **“invalid state”.** Si se pasa un valor de outcome no válido a ``best``, la función debería arrojar un error a través de la función de detención con el mensaje exacto **"invalid outcome".**

Aquí hay algunos resultados de muestra de la función.

~~~
> source("best.R")
> best("TX", "heart attack")
[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
> best("TX", "heart failure")
[1] "FORT DUNCAN MEDICAL CENTER"
> best("MD", "heart attack")
[1] "JOHNS HOPKINS HOSPITAL, THE"
> best("MD", "pneumonia")
[1] "GREATER BALTIMORE MEDICAL CENTER"
> best("BB", "heart attack")
Error in best("BB", "heart attack") : invalid state
> best("NY", "hert attack")
Error in best("NY", "hert attack") : invalid outcome
~~~

Guarde su código para esta función en un archivo llamado ``**best.R**``.


## 3 Clasificación de hospitales por resultado en un estado

Escriba una función llamada ``rankhospital`` que tome tres argumentos: el nombre abreviado de 2 caracteres de un estado (**state**), un resultado (**outcome**) y la clasificación de un hospital en ese estado para ese resultado (**num**). La función lee el archivo ``result-of-care-measure.csv`` y devuelve un vector de caracteres con el nombre del hospital que tiene la clasificación especificada por el argumento ``num``. Por ejemplo, la llamada

rankhospital("MD", "heart failure", 5)

devolvería un vector de caracteres que contiene el nombre del hospital con la quinta tasa de mortalidad más baja de 30 días por "heart failure". El argumento ``num`` puede tomar los valores "mejor", "peor" o un número entero que indica la clasificación (**los números más pequeños son mejores**). Si el número dado por ``num`` es mayor que el número de hospitales en ese estado, entonces la función debería devolver **NA**. Los hospitales que no tienen datos sobre un resultado particular deben excluirse del conjunto de hospitales al decidir las clasificaciones.

**Manejo de empates.** Puede ocurrir que varios hospitales tengan la misma tasa de mortalidad de 30 días para una causa dada de muerte. En esos casos, los lazos deben romperse utilizando el nombre del hospital. Por ejemplo, en Texas ("TX"), se muestran aquí los hospitales con la tasa de mortalidad por insuficiencia cardíaca más baja de 30 días.

~~~
> head(texas)
Hospital.Name Rate Rank
3935 FORT DUNCAN MEDICAL CENTER 8.1 1
4085 TOMBALL REGIONAL MEDICAL CENTER 8.5 2
4103 CYPRESS FAIRBANKS MEDICAL CENTER 8.7 3
3954 DETAR HOSPITAL NAVARRO 8.7 4
4010 METHODIST HOSPITAL,THE 8.8 5
3962 MISSION REGIONAL MEDICAL CENTER 8.8 6
~~~

Note que Cypress Fairbanks Medical Center y Detar Hospital Navarro tienen la misma puntuacion de 30 días (8.7). Sin embargo, debido a que Cypress viene antes de Detar alfabéticamente, Cypress ocupa el puesto número 3 en este esquema y Detar está clasificado como número 4. Uno puede usar la función de orden para ordenar múltiples vectores de esta manera (es decir, donde un vector se usa para romper lazos en otro vector )

La función debe usar la siguiente plantilla.

~~~
rankhospital <- function(state, outcome, num = "best") {
## Read outcome data
## Check that state and outcome are valid
## Return hospital name in that state with the given rank
## 30-day death rate
}
~~~

La función debe verificar la validez de sus argumentos. Si se pasa un valor de **state** no válido a ``rankhospital``, la función debería arrojar un error a través de la función de detención con el mensaje exacto "invalid state". Si se pasa un valor de **outcome** no válido a ``rankhospital``, la función debe arrojar un error a través de la función de detención con el mensaje exacto "invalid outcome".

Aquí hay algunos resultados de muestra de la función.

~~~
> source("rankhospital.R")
> rankhospital("TX", "heart failure", 4)
[1] "DETAR HOSPITAL NAVARRO"
> rankhospital("MD", "heart attack", "worst")
3
[1] "HARFORD MEMORIAL HOSPITAL"
> rankhospital("MN", "heart attack", 5000)
[1] NA
~~~

Guarde su código para esta función en un archivo llamado ``rankhospital.R``.


## 4 Clasificación de hospitales en todos los estados

Escriba una función llamada ``rankall`` que tome dos argumentos: un nombre de resultado (**outcome**) y una clasificación de hospital (**num**). La función lee el archivo ``result-of-care-measure.csv`` y devuelve un marco de datos de 2 columnas que contiene el hospital en cada estado que tiene la clasificación especificada en ``num``. Por ejemplo, la función llamada ``rankall`` ("heart attack", "best") devolvería un marco de datos que contiene los nombres de los hospitales que son los mejores en sus respectivos estados para las tasas de mortalidad por ataque cardíaco de 30 días. La función debe devolver un valor para cada estado (algunos pueden ser NA). La primera columna en el marco de datos se llama ``**hospital**``, que contiene el nombre del hospital, y la segunda columna se llama ``**state**``, que contiene la abreviatura de 2 caracteres para el nombre del estado. Los hospitales que no tienen datos sobre un resultado particular deben excluirse del conjunto de hospitales al decidir las clasificaciones.

**Manejo de empates.** La función ``rankall`` debe manejar los lazos en las tasas de mortalidad de 30 días de la misma manera que la función ``rankhospital`` maneja los lazos.

La función debe usar la siguiente plantilla

~~~
rankall <- function(outcome, num = "best") {
## Read outcome data
## Check that state and outcome are valid
## For each state, find the hospital of the given rank
## Return a data frame with the hospital names and the
## (abbreviated) state name
}
~~~

**NOTA:** Para el propósito de esta parte de la tarea (y para mayor eficiencia), su función **NO** debe llamar a la función ``rankhospital`` de la sección anterior.

La función debe verificar la validez de sus argumentos. Si se pasa un valor de resultado no válido a ``rankall``, la función debería arrojar un error a través de la función de detención con el mensaje exacto "invalid outcome". La variable ``num`` puede tomar los valores "best", "worst" o un número entero que indica la clasificación (los números más pequeños son mejores). Si el número dado por ``num`` es mayor que el número de hospitales en ese estado, entonces la función debería devolver NA.

Aquí hay algunos resultados de muestra de la función.

~~~
> source("rankall.R")
> head(rankall("heart attack", 20), 10)
                                hospital state
AK                                  <NA>    AK
AL        D W MCMILLAN MEMORIAL HOSPITAL    AL
AR     ARKANSAS METHODIST MEDICAL CENTER    AR
AZ   JOHN C LINCOLN DEER VALLEY HOSPITAL    AZ
CA                 SHERMAN OAKS HOSPITAL    CA
CO              SKY RIDGE MEDICAL CENTER    CO
CT               MIDSTATE MEDICAL CENTER    CT
DC                                  <NA>    DC
DE                                  <NA>    DE
FL        SOUTH FLORIDA BAPTIST HOSPITAL    FL

> tail(rankall("pneumonia", "worst"), 3)

                                        hospital  state
WI    MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC     WI
WV                        PLATEAU MEDICAL CENTER     WV
WY              NORTH BIG HORN HOSPITAL DISTRICT     WY

> tail(rankall("heart failure"), 10)

                                                             hospital state
TN                          WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL    TN
TX                                         FORT DUNCAN MEDICAL CENTER    TX
UT  VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER    UT
VA                                           SENTARA POTOMAC HOSPITAL    VA
VI                             GOV JUAN F LUIS HOSPITAL & MEDICAL CTR    VI
VT                                               SPRINGFIELD HOSPITAL    VT
WA                                          HARBORVIEW MEDICAL CENTER    WA
WI                                     AURORA ST LUKES MEDICAL CENTER    WI
WV                                          FAIRMONT GENERAL HOSPITAL    WV
WY                                         CHEYENNE VA MEDICAL CENTER    WY
~~~

Guarde su código para esta función en un archivo llamado ``rankall.R``.
