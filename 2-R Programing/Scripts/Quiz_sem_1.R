

x <- 4L 
 class(x)
 x <- c(4, TRUE) 
class(x) 

x <- c(1,3, 5) 
y <- c(3, 2, 10)
a <- rbind(x, y)
b <- cbind(x, y)
class(b)

x <- list(2, "a", "b", TRUE)
class(x[[1]])
length(x[[1]])

x <- 1:4 
y <- 2:3
a <- x + y
class(a)

x <- c(3, 5, 1, 10, 12, 6)
x[x==6]<- 0 #no
x[x %in% 1:5]<- 0 #si
x[x<=5]<- 0 #si
x[x!=6]<- 0 #no
x[x==0]<6 #no
x[x<6] == 0 #no
x[x<6] <- 0 #si
x


datos <- read.csv("Data/hw1_data.csv")
names(datos)
datos[1:2,]
length(datos$Ozone)
sum(is.na(datos)=="TRUE")
datos[152:153,]
datos[47,1]
sum(is.na(datos$Ozone)=="TRUE")
x<-datos$Ozone; x <- x[!is.na(x)]; mean(x)
x <- datos[datos$Ozone > 31 & datos$Temp > 90, ]; x <- x$Solar.R; x <- x[!is.na(x)]; mean(x)
x <- datos[, 4:5]; x <- x[x$Month ==6,]; mean(x$Temp)
x <- datos[, c(1,5)]; x <- x[x$Month ==5,]; x <- x$Ozone[!is.na(x$Ozone)]; max(x)


x <- c(4, "a", TRUE)
class(x)
