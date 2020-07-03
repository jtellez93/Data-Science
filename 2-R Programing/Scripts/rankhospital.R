
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
