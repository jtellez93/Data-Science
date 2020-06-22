library(tibble)
old.dir <- getwd()

setwd("Asignaciones de programacion")
file.create("sem_2.md")

setwd(old.dir) 

### Parte 1 ####

# Funcion pollutantmean calcule la media de un contaminante (sulfato o nitrato) 
# en una lista específica de monitores
# cada monitor mide 4 variables "Date" "sulfate" "nitrate" "ID"

pollutantmean <- function(directory, pollutant, id = 1:332){
        
        old.dir <- getwd()
        setwd("D:/Documents/GitHub/Data-Science/2-R Programing")
        
                # creo un vector con los nombres de los monitores
                archivos <- NULL
                for (i in id){
                        if(i <= 9){
                                archivos[i] <- paste("00", i, sep = "")
                        } else if(i > 9 && i <= 99){
                                archivos[i] <- paste("0", i, sep = "")
                        }
                        else{
                                archivos[i] <- i
                        }
                }

# extraigo informacion de cada archivo y calculo resultado
        lecturas <- NULL; total <- NULL; n <- NULL#monitores <- NULL
        for (i in id){
                ruta <- paste("Data/", directory, "/", archivos[i], ".csv", sep = "")
                lecturas[i] <- list(read.csv(ruta))
      
                #monitores[i] <- paste("lecturas[[", i, "]]", sep = "")
                if(pollutant == "sulfate"){
                        x <- lecturas[[i]]$sulfate
                } else {
                        x <- lecturas[[i]]$nitrate
                }
                good <- x[!is.na(x)]
                total[i] <- sum(good)
                n[i] <- length(good)
      
                total <- total[!is.na(total)]
                n <- n[!is.na(n)]
                resultado <- sum(total)/sum(n)
        }
        
        setwd(old.dir)
        return(resultado)
}


pollutantmean("specdata", "sulfate", 1:10)
4.064128

pollutantmean("specdata", "nitrate", 70:72)
1.706047

pollutantmean("specdata", "nitrate", 23)
1.280833




### Parte 2 ####

complete <- function(directory, id = 1:332){
        
        old.dir <- getwd()
        setwd("D:/Documents/GitHub/Data-Science/2-R Programing")

        # creo un vector con los nombres de los monitores
        archivos <- NULL
        for (i in id){
                if(i <= 9){
                        archivos[i] <- paste("00", i, sep = "")
                } else if(i > 9 && i <= 99){
                        archivos[i] <- paste("0", i, sep = "")
                }
                else{
                        archivos[i] <- i
                }
        }

        # creo el vector con los conteos de registros correctos
        lecturas <- NULL; total <- NULL;
        for (i in id){
                ruta <- paste("Data/", directory, "/", archivos[i], ".csv", sep = "")
                lecturas[i] <- list(read.csv(ruta))
        
                x <- lecturas[[i]][,c(2,3)]
                x <- x[!is.na(x$sulfate), ]
                good <- x[!is.na(x$nitrate), ]
                total[i] <- nrow(good)
                
                total <- total[!is.na(total)]
        }


        # valido el orden de la secuencia, en ese orden se debe presentar
        if(id[1] > id[length(id)]){
                completas <- data.frame(id, rev(total))
                } else {
                        completas <- data.frame(id, total)
                }

        nombres <- c("id", "nobs")
        names(completas) <- nombres

        setwd(old.dir)
        return(completas)
}

complete("specdata", 1)
##   id nobs
## 1  1  117

complete("specdata", c(2, 4, 8, 10, 12))
##   id nobs
## 1  2 1041
## 2  4  474
## 3  8  192
## 4 10  148
## 5 12   96

complete("specdata", 30:25)
##   id nobs
## 1 30  932
## 2 29  711
## 3 28  475
## 4 27  338
## 5 26  586
## 6 25  463

complete("specdata", 3)
##   id nobs
## 1  3  243




