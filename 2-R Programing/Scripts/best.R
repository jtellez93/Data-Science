
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
        
        best <- sort(best, decreasing = F)
        best <- as.vector(best[1])
        
        ## rate
        return(best)
        
}