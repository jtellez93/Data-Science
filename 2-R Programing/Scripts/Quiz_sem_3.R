library(datasets)
data(iris)

?iris

tapply(iris$Sepal.Length, iris$Species, mean)

apply(iris[, 1:4], 2, mean)


library(datasets)
data(mtcars)

?mtcars

tapply(mtcars$mpg, mtcars$cyl, mean) #si
tapply(mtcars$cyl, mtcars$mpg, mean) #no
with(mtcars, tapply(mpg, cyl, mean)) #si

hp_cyl <- tapply(mtcars$hp, mtcars$cyl, mean)
abs(hp_cyl[1] - hp_cyl[3])



