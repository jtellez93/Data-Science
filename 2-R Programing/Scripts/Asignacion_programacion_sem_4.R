

old.dir <- getwd()

path <- "D:/Documents/GitHub/Data-Science/2-R Programing/Data/rprog_data_ProgAssignment3-data"
path.scripts <- "D:/Documents/GitHub/Data-Science/2-R Programing/Scripts"
setwd(path)
getwd()

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

ncol(outcome); nrow(outcome)

### 1 Graficar las tasas de mortalidad de 30 días por ataque cardíaco ####

# porcentajes de riesgo de morir por ataque cardiaco en cada hospital
outcome[, 11] <- as.numeric(outcome[, 11]) # se convierne en numerica dado que leimos como caracter
hist(outcome[, 11])


### 2 Encontrar el mejor hospital en un estado ####

best <- function(state, outcome){
        
        ## Read outcome data
        datos <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        x <- c("heart attack", "heart failure", "pneumonia")
        
        ## Check that state and outcome are valid
        if (any(state == datos[, 7]) == FALSE){
                stop("invalid state")
        }
        
        if (any(outcome == x) == FALSE){
                stop("invalid outcome")
        }
                
        ## Return hospital name in that state with lowest 30-day death rate
        i <- NULL; y <- NULL; min <- NULL; best <- NULL
        if(outcome == "heart attack") i <- 11
        if(outcome == "heart failure") i <- 17
        if(outcome == "pneumonia") i <- 23
        
        y <- as.data.frame(datos[datos$State == state, c(2, i)])
        names(y) <- c("Hospital.Name", "rate")
        y <- suppressWarnings(data.frame(y$Hospital.Name, as.numeric(y$rate)))
        names(y) <- c("Hospital.Name", "rate")
        y <- y[!is.na(y$rate), ]
        
        min <- min(as.numeric(y$rate), na.rm = TRUE)
        best <- y[y$rate == min, 1]
        
        best <- sort(best, decreasing = F)
        best <- as.vector(best[1])
        
        return(best)
}


# Prueba

old.dir <- "D:/Documents/GitHub/Data-Science/2-R Programing"
path.scripts <- "D:/Documents/GitHub/Data-Science/2-R Programing/Scripts"
setwd(path.scripts)
source("best.R")
path <- "D:/Documents/GitHub/Data-Science/2-R Programing/Data/rprog_data_ProgAssignment3-data"
setwd(path)

best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

setwd(old.dir)

### 3 Clasificación de hospitales por resultado en un estado ####


rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        datos <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        x <- c("heart attack", "heart failure", "pneumonia")
        
        ## Check that state and outcome are valid
        if (any(state == datos[, 7]) == FALSE){
                stop("invalid state")
        }
        
        if (any(outcome == x) == FALSE){
                stop("invalid outcome")
        }
        
        ## Return hospital name in that state with the given rank 30-day death rate
        if(outcome == "heart attack") i <- 11
        if(outcome == "heart failure") i <- 17
        if(outcome == "pneumonia") i <- 23
        
        y <- as.data.frame(datos[datos$State == state, c(2, i)])
        names(y) <- c("Hospital.Name", "rate")
        y <- suppressWarnings(data.frame(y$Hospital.Name, as.numeric(y$rate)))
        names(y) <- c("Hospital.Name", "rate")
        y <- y[!is.na(y$rate), ]
        
        best <- y[order(y$rate, y$Hospital.Name), ]
        
        if (num == "best"){
                best <- as.vector(best[ 1, 1])
        } else if (num == "worst"){
                best <- as.vector(best[ nrow(best), 1])
        } else{
                best <- as.vector(best[ num, 1])
        }
        
        return(best)
}


# Prueba

old.dir <- "D:/Documents/GitHub/Data-Science/2-R Programing"
path.scripts <- "D:/Documents/GitHub/Data-Science/2-R Programing/Scripts"
setwd(path.scripts)
source("rankhospital.R")
path <- "D:/Documents/GitHub/Data-Science/2-R Programing/Data/rprog_data_ProgAssignment3-data"
setwd(path)

rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)

setwd(old.dir)


### 4 Clasificación de hospitales en todos los estados ####

rankall <- function(outcome, num = "best") {
        ## Read outcome data
        datos <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        x <- c("heart attack", "heart failure", "pneumonia")
        
        ## Check that outcome are valid
        if (any(outcome == x) == FALSE){
                stop("invalid outcome")
        }
        
        ## For each state, find the hospital of the given rank
        if(outcome == "heart attack") i <- 11
        if(outcome == "heart failure") i <- 17
        if(outcome == "pneumonia") i <- 23
        
        estados <- unique(datos$State)
        estados <- sort(estados)
        y <- list()
        
        for (j in estados){
                
                y[[j]] <- datos[datos$State == j, c(2, 7, i)]
                names(y[[j]]) <- c("hospital", "state", "rate")
                y[[j]][["rate"]] <- suppressWarnings(as.numeric(y[[j]][["rate"]]))
                
                y[[j]] <- y[[j]][!is.na(y[[j]]$rate), ]
                y[[j]] <- y[[j]][order(y[[j]]$rate, y[[j]]$hospital), ]
                
                if (num == "best"){
                        y[[j]] <- y[[j]][1, 1]
                } else if (num == "worst"){
                        y[[j]] <- y[[j]][nrow(y[[j]]), 1]
                } else{
                        y[[j]] <- y[[j]][num, 1]
                }
        }
        
        rank <- data.frame(matrix(unlist(y), nrow = length(y), byrow = T))
        rank <- cbind(rank, estados)
        names(rank) <- c("hospital", "state")
        
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        return(rank)
}


# Prueba

old.dir <- "D:/Documents/GitHub/Data-Science/2-R Programing"
path.scripts <- "D:/Documents/GitHub/Data-Science/2-R Programing/Scripts"
setwd(path.scripts)
source("rankall.R")
path <- "D:/Documents/GitHub/Data-Science/2-R Programing/Data/rprog_data_ProgAssignment3-data"
setwd(path)

head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

setwd(old.dir)