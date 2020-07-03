

old.dir <- getwd()

path <- "D:/Documents/GitHub/Data-Science/2-R Programing/Data/rprog_data_ProgAssignment3-data"
path.scripts <- "D:/Documents/GitHub/Data-Science/2-R Programing/Scripts"
setwd(path)
getwd()

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

ncol(outcome); nrow(outcome)

## 1 Graficar las tasas de mortalidad de 30 días por ataque cardíaco

# porcentajes de riesgo de morir por ataque cardiaco en cada hospital
outcome[, 11] <- as.numeric(outcome[, 11]) # se convierne en numerica dado que leimos como caracter
hist(outcome[, 11])


## 2 Encontrar el mejor hospital en un estado

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
                
        ## Return hospital name in that state with lowest 30-day death
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
        
        #print(best)
        #print(min)
        
        best <- sort(best, decreasing = F)
        best <- as.vector(best[1])
        
        ## rate
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

## 3 Encontrar el mejor hospital en un estado



















## para experimentar
state <- "TX"
res <- "heart failure"

if(res == "heart attack") i <- 11
if(res == "heart failure") i <- 17
if(res == "pneumonia") i <- 23

y <- as.data.frame(outcome[outcome$State == state, c(2, i)])
names(y) <- c("Hospital.Name", "rate")
y <- suppressWarnings(data.frame(y$Hospital.Name, as.numeric(y$rate)))
names(y) <- c("Hospital.Name", "rate")
y <- y[!is.na(y$rate), ]

min <- min(as.numeric(y$rate), na.rm = TRUE)
best <- y[y$rate == min, 1]

best <- sort(best, decreasing = F)
best <- as.vector(best[1])




df <- data.frame(c("julian","camila", "paola"),c(10.1,10.1,20))
names(df) <- c("Hospital.Name", "rate")

min <- min(df$rate)
best <- df[df$rate == min, 1]

best <- sort(best, decreasing = F)
best <- as.vector(best[1])

