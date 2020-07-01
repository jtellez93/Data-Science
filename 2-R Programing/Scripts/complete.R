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