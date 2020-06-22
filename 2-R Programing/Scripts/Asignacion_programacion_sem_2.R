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


setwd("Asignaciones de programacion")
file.create("pollutantmean.R")

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

setwd("Asignaciones de programacion")
file.create("complete.R")



### Parte 3 ####

corr <- function(directory, threshold = 0){
  
    old.dir <- getwd()
    setwd("D:/Documents/GitHub/Data-Science/2-R Programing")
  
    # creo un vector con los nombres de los monitores
    archivos <- NULL; id <- 1:332
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

    # data frame con el nombre de archivo y numero de casos completos
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
  
    completas <- data.frame(archivos, total)
    nombres <- c("Archivo", "nobs")
    names(completas) <- nombres


  # calculo correlacion de mediciones de los archivos que tienen 
  # casos completos por encima del umbral (threshold) dado

    completas <- completas[(completas$nobs > threshold), ] # archivos con n° de 
    # mediciones completas que superan el umbral

    archivo <- as.character(completas$Archivo) # vector con los archivos 
    # que superan umbral


    # extraigo informacion de cada archivo y calculo resultado
    lecturas <- NULL; cor <- NULL
    for (i in seq_along(archivo)){
      ruta <- paste("Data/", directory, "/", archivo[i], ".csv", sep = "")
      lecturas[i] <- list(read.csv(ruta))
  
      x <- lecturas[[i]][,c(2,3)]
      x <- x[!is.na(x$sulfate), ]
      good <- x[!is.na(x$nitrate), ]
  
      cor[i] <- cor(good$sulfate, good$nitrate)
    }

    setwd(old.dir)
    return(cor)

}


cr <- corr("specdata", 150)
head(cr)
## [1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -0.07588814

summary(cr)
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -0.21057 -0.04999  0.09463  0.12525  0.26844  0.76313

cr <- corr("specdata", 400)
head(cr)
## [1] -0.01895754 -0.04389737 -0.06815956 -0.07588814  0.76312884 -0.15782860

summary(cr)
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -0.17623 -0.03109  0.10021  0.13969  0.26849  0.76313

cr <- corr("specdata", 5000)
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## 

length(cr)
## [1] 0

cr <- corr("specdata")
summary(cr)
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -1.00000 -0.05282  0.10718  0.13684  0.27831  1.00000

length(cr)
## [1] 323


setwd("Asignaciones de programacion")
file.create("corr.R")


















































