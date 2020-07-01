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