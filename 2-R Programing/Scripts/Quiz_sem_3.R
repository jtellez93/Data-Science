library(datasets)
data(iris)

?iris

tapply(iris$Sepal.Length, iris$Species, mean)

apply(iris[, 1:4], 2, mean)


library(datasets)
data(mtcars)

?mtcars

tapply(mtcars$mpg, mtcars$cyl, mean) #si
sapply(split(mtcars$mpg, mtcars$cyl), mean) #si
with(mtcars, tapply(mpg, cyl, mean)) #si
mean(mtcars$mpg, mtcars$cyl) # no
apply(mtcars, 2, mean) # no
lapply(mtcars, mean) #no 
sapply(mtcars, cyl, mean) # no
tapply(mtcars$cyl, mtcars$mpg, mean) #no

hp_cyl <- tapply(mtcars$hp, mtcars$cyl, mean)
abs(hp_cyl[1] - hp_cyl[3])


# execution of ls will suspendend at the beginning.......



