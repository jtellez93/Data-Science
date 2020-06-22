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