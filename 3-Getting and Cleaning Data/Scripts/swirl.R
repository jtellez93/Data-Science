
# paquete swirl
packageVersion("swirl")
library(swirl)
install_from_swirl("Getting and Cleaning Data")
swirl()


### leccion 1: Manipulating Data with dplyr ####


mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
dim(mydf)
head(mydf)

library(dplyr)
packageVersion("dplyr")

cran <- tbl_df(mydf)
rm(mydf)

?tbl_df # ahora se debe usar as_tibble()
cran

# Específicamente, dplyr proporciona cinco 'verbos' 
# que cubren las tareas más fundamentales de manipulación de datos: 
# seleccionar (), filtrar (), organizar (), mutar () y resumir ().
# select(), filter(), arrange(), mutate(), and summarize()

?select # permite seleccionar variables de interes
select(cran, ip_id, package, country)

5:20 # secuencia convencional

# dplyr tambien se puede usar ":" con las columnas que deseo ver 

select(cran, r_arch:country) # en el DF cran, seleccione columnas 
# desde r_arch hasta country

# tambien puedo hacerlo en orden inverso
select(cran, country:r_arch)

cran # aun no he modificado el DF original

# si quiero omitir columnas uso "-" y el nombre de la variable

select(cran, -time)

-5:20
-(5:20)

select(cran, -(X:size))

# si quiero seleccionar filas utilizo filter()

filter(cran, package == "swirl") # filtra la columna paquetes que sean iguales a swirl 

# tambien puedo hacer varios filtros en una sola expresion

filter(cran, r_version == "3.1.1", country == "US")

# con filter() tambien puedo usar comparaciones binarias
?Comparison

filter(cran, r_version <= "3.0.2", country == "IN")

# tambien se puede hacer uso de operadores boleanos
filter(cran, country == "US" | country == "IN")
filter(cran, size > 100500, r_os == "linux-gnu")


# deteccion de NA's
is.na(c(3, 5, NA, 10))
!is.na(c(3, 5, NA, 10))

filter(cran, !is.na(r_version))


# para organizar uso arrange()
cran2 <- select(cran, size:ip_id)

arrange(cran2, ip_id) # por defecto arrange() organiza en orden ascendente
arrange(cran2, desc(ip_id)) # en orden descendente se usa el argumento desc()

# puedo organizar varias columnas a la vez y de diferente forma

arrange(cran2, package, ip_id)
arrange(cran2, country, desc(r_version), ip_id)



# tambien puedo agregar variables a un DF con mutate()
cran3 <- select(cran, ip_id, package, size)
cran3

# si quiero agregar una columna llamada size_mb que contenga el tamaño de descarga en mb
mutate(cran3, size_mb = size / 2^20)

# ahora otra columna con el tamaño de descarga en gb
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)

# se pueden agregar columnas con diferentes operaciones
mutate(cran3, correct_size = size + 1000)


# para resumir la informacion del DF utilizo summarize()
# colapsa el df en una sola fila, (total por columna)
summarize(cran, avg_bytes = mean(size))


### leccion 2: Grouping and Chaining with dplyr ####

library(dplyr)

cran <- tbl_df(mydf)
rm("mydf")
cran

# puedo agrupar variables deacuerdo a categorias con group_by()

?group_by

by_package <- group_by(cran, package)
by_package

# una vez agrupados es mas interesante usar summarize para calcular por grupos

summarize(by_package, mean(size))

# tambien puedo sacar varios resumenes y guardarlos en un objeto
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

pack_sum


# si quiero saber el numero de paquetes deacuerdo al numero de 
# descargas que estan por encima del 99% uso la funcion quantile()
quantile(pack_sum$count, probs = 0.99)

#los que tienen mas de 679 estan en el cuantil 99% 

top_counts <- filter(pack_sum, count > 679)
top_counts

View(top_counts)

top_counts_sorted <- arrange(top_counts, desc(count))

View(top_counts_sorted)

# cuantil 99% para lal columna unique
quantile(pack_sum$unique, probs = 0.99)

# son las filas conmas de 465 
top_unique <- filter(pack_sum, unique > 465)
View(top_unique)

top_unique_sorted <- arrange(top_unique, desc(unique))
View(top_unique_sorted)


### leccion 3: Tidying Data with tidyr ####
library(dplyr)
library(tidyr)

3
students
# la variable sexo se encuentra en dos columnas 
# para reunir la variable en una sola columna puedo usar la funcion gather()
?gather
gather(students, key = sex, value = count, -grade)

# actualmente se recomienda el uso de pivot_longer()

students2
# la variable sexo esta dividida en 4 columnas debe reunirse en una sola 
gather(students2, key =  sex_class, value = count, -grade)
res <- gather(students2, sex_class, count, -grade)
res

# ahora tengo la variable sexo y sexclass en una columna debo separarlas
# siempre debe estar una variable en una columna
# para este caso usamos separate()
# Separe una columna de caracteres en varias columnas con una expresión regular o ubicaciones numéricas

?separate
separate(data = res, col = sex_class, into = c("sex", "class"))

# da el mismo resultado si lo hacemos encadenando con %>%

students2 %>%
        gather( sex_class, count, -grade) %>%
        separate( sex_class, c("sex", "class")) %>%
        print


# en este caso hay que reunir las clases por grado 
students3
students3 %>%
        gather( class, grade, class1:class5 , na.rm = TRUE) %>%
        print

# el siguiente paso requiere de spread()
?spread
# Distribuya un par clave-valor en varias columnas.

students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread( test, grade) %>%
        print


library(readr)
parse_number("class5")
# Esto elimina los caracteres no numéricos antes o después del 
# primer número. La marca de agrupación especificada por la 
# configuración regional se ignora dentro del número.

# si deseo cambiar las palabras class_1, class_2... 
#utilizo esta funcion para que solo quede la parte numerica 1,2...

students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        mutate(class = parse_number(class)) %>%
        print

# otro problema con messy data

students4
# los datos estan organizados por variable y por observacion
# sin enbargo hay observaciones repetidas para id, nombre y sex, por tanto 
# deben separarse en tablas diferentes

student_info <- students4 %>%
        select( id, name, sex)%>%
        unique()

gradebook <- students4 %>%
        select(id, class, midterm, final)

# para relacionar tablas tenemos este ejemplo con dos tablas
passed
failed

# primero creamos una columna llamada status con la 
# etiqueta passed o failed a los estudientes que aprobaron o perdieron

passed <- passed %>% mutate(status = "passed")
failed <- failed %>% mutate(status = "failed")

# para unir estas dos tablas usamos bind_rows()
# esta funcion sirve para para vincular muchos df en uno.
?bind_rows

bind_rows(passed, failed)


# I've created a variable called 'sat' in your workspace, which contains data
# on all college-bound seniors who took the SAT exam in 2013

sat
sat %>%
        select(-contains("total")) %>%
        gather(part_sex, count, -score_range) %>%
        separate(part_sex, c("part", "sex")) %>%
        print


sat %>%
        select(-contains("total")) %>%
        gather(part_sex, count, -score_range) %>%
        separate(part_sex, c("part", "sex")) %>%
        group_by(part, sex) %>%
        mutate(total = sum(count), prop = count / total) %>% 
        print


### leccion 4: Dates and Times with lubridate ####


